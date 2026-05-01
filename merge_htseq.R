# 1. Get a list of all the htseq files in the current directory
files <- list.files(pattern = "^htseq_.*\\.txt$")

if (length(files) == 0) {
  stop("No files found matching 'htseq_*.txt'")
}

# 2. Read the first file to initialize our master dataframe
first_sample <- sub("^htseq_(.*)\\.txt$", "\\1", files[1])
merged_matrix <- read.table(files[1], sep="\t", header=FALSE, stringsAsFactors=FALSE)
colnames(merged_matrix) <- c("gene", first_sample)

# 3. Loop through the remaining files and merge them one by one
for (i in 2:length(files)) {
  sample_name <- sub("^htseq_(.*)\\.txt$", "\\1", files[i])
  
  # Read the current file
  temp_data <- read.table(files[i], sep="\t", header=FALSE, stringsAsFactors=FALSE)
  colnames(temp_data) <- c("gene", sample_name)
  
  # Merge with the master dataframe based on the "gene" column
  merged_matrix <- merge(merged_matrix, temp_data, by="gene", all=TRUE)
}

# 4. Remove the htseq summary rows at the bottom (anything starting with "__")
merged_matrix <- merged_matrix[!grepl("^__", merged_matrix$gene), ]

# 5. Save the final matrix to a new file
write.table(merged_matrix, file="merged_gene_counts.tsv", sep="\t", row.names=FALSE, quote=FALSE)
cat("Successfully merged", length(files), "files into merged_gene_counts.tsv\n")
