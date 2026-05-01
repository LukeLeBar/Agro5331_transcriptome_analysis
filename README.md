The directory contains the scripts necessary to perform a differential expression analysis. This analysis was conducted on
seedling leaf and root tissue from 24 Pakistani bread wheat (Triticum aestivum) genotypes representing 110 years of wheat
breeding. 

SRA_extract.sh - Script to extract all 58 RNAseq samples from the NVBI website

generate_wheat_index.sh - Script to generate a wheat STAR index for alignment from scratch.

wheat_transcript_abundance.sh - Script to align reads to index and then count transcript abundance.

number_expressed_genes.sh - Script to sum all of the expressed genes for a given SRA.

merge_htseq.R - R script to merge the transcript abundance files for each sample into a single matrix.

differential_expression_analysis.R - Script to create graphics and analyze how expression profiles have changed over time. Statistical analysis involves simple linear modeling and analysis of variance.

sample_metadata.csv - Metadata from the NCBI website for our SRAs.

cultivar_info.csv - Cultivar name, pedigree, and year of release.

MSI

% sbatch SRA_extract.sh

% sbatch generate_wheat_index.sh

% sbatch wheat_transcript_abundance.sh

% sbatch number_expressed_genes.sh

% module load R

% Rscript merge_htseq.R

Move to R and execute differential_expression_analysis.R
