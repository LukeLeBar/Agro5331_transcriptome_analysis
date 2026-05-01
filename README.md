The directory contains the scripts necessary to perform a differential expression analysis. This analysis was conducted on
seedling leaf and root tissue from 24 Pakistani bread wheat (Triticum aestivum) genotypes representing 110 years of wheat
breeding. 

SRA_extract.sh - Script to extract all 58 RNAseq samples from the NVBI website
generate_wheat_index.sh - Script to generate a wheat STAR index for alignment from scratch.
wheat_transcript_abundance.sh - Script to align reads to index and then count transcript abundance.
number_expressed_genes.sh - Script to sum all of the expressed genes for a given SRA.
merge_htseq.R - R script to merge the transcript abundance files for each sample into a single matrix.
