#!/bin/bash
#SBATCH --job-name=wheat_rnaseq_array
#SBATCH --time=48:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem=160g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=lebar030@umn.edu
#SBATCH --array=1-58%10

# Navigate to the folder containing your 58 SRA fastq files
cd /scratch.global/agro5431/lebar030/Differential_Expression/SRA_files

# Define the paths to your new Wheat references
WHEAT_INDEX="/scratch.global/agro5431/lebar030/Differential_Expression/wheat_star_index"
WHEAT_GTF="/scratch.global/agro5431/lebar030/Differential_Expression/Triticum_aestivum.IWGSC.62.gtf"

# Load all the required modules upfront
module load fastqc/0.11.7
module load cutadapt/1.18
module load star/2.5.3a
module load htseq/0.11.0

# Create an array of all raw fastq files (excluding cutadapt outputs)
# This prevents the script from accidentally processing intermediate files
mapfile -t FILES < <(ls *.fastq | grep -v "cutadapt")

# Safety check: Ensure the task ID doesn't exceed the number of files
if [ "$SLURM_ARRAY_TASK_ID" -gt "${#FILES[@]}" ]; then
    echo "Task ID $SLURM_ARRAY_TASK_ID exceeds the number of files (${#FILES[@]}). Exiting."
    exit 0
fi

# Get the specific file for this task 
# (SLURM arrays are 1-based, bash arrays are 0-based, so we subtract 1)
FASTQ_FILE=${FILES[$SLURM_ARRAY_TASK_ID - 1]}

# Extract the base name of the file
BASE_NAME=$(basename "$FASTQ_FILE" .fastq)

echo "=========================================================="
echo " PROCESSING FILE: $BASE_NAME (Array Task ID: $SLURM_ARRAY_TASK_ID)"
echo "=========================================================="

echo "Step 1: Check the quality of the raw reads..."
fastqc -f fastq "$FASTQ_FILE"

echo "Step 2: Remove the adapter sequences..."
cutadapt -a GATCGGAAGAGCACACGTCTGAACTCCAGTCACCAGATCATCTCGTATGCCGTCTTCTGCTTG \
         -a AATGATACGGCGACCACCGAGATCTACACTCTTTCCCTACACGACGCTCTTCCGATCT \
         -f fastq -m 30 --quality-base=33 \
         -o "${BASE_NAME}_cutadapt.fastq" "$FASTQ_FILE" > "${BASE_NAME}_cutadapt.log"

echo "Step 3: Check the quality of the cleaned reads..."
fastqc -f fastq "${BASE_NAME}_cutadapt.fastq"

echo "Step 4: Align RNAseq reads to the Wheat RefSeq v2.1 genome..."
STAR --genomeDir "$WHEAT_INDEX" \
     --runThreadN 8 \
     --readFilesIn "${BASE_NAME}_cutadapt.fastq" \
     --outFileNamePrefix "${BASE_NAME}_STAR_" \
     --outSAMtype BAM SortedByCoordinate

echo "Step 5: Get transcript abundance using HTSeq..."
htseq-count -f bam -s no -t exon -i gene_id -m union -a 20 \
            "${BASE_NAME}_STAR_Aligned.sortedByCoord.out.bam" \
            "$WHEAT_GTF" > "htseq_${BASE_NAME}.txt"

echo " Finished processing $BASE_NAME!"
echo "----------------------------------------------------------"
