#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --mem=250gb
#SBATCH --time=10:00:00
#SBATCH --job-name=star_index
#SBATCH --mail-type=ALL
#SBATCH --mail-user=lebar030@umn.edu

module load star/2.5.3a

mkdir -p ./wheat_star_index

STAR --runMode genomeGenerate \
     --runThreadN 32 \
     --genomeDir ./wheat_star_index \
     --genomeFastaFiles Triticum_aestivum.IWGSC.dna.toplevel.fa \
     --sjdbGTFfile Triticum_aestivum.IWGSC.62.gtf \
     --sjdbOverhang 100 \
     --genomeSAindexNbases 14 \
     --limitGenomeGenerateRAM 100000000000
