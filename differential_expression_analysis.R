##### Differential Expression Analysis #####

##### Load Packages
library(tidyverse)
library(ggplot2)
library(ggpubr)
library(readr)

##### Read in Data #####
gene_exp_cts <- read_tsv("number_expressed_genes.txt", col_names = FALSE)
colnames(gene_exp_cts)[1] = "sample_id"
colnames(gene_exp_cts)[2] = "count"
gene_exp_cts$sample_id <- gsub("_1", "", gene_exp_cts$sample_id)

rna_matrix <- read_tsv("merged_gene_counts.tsv")
#Remove uninformative genes
rna_matrix <- rna_matrix[rowSums(rna_matrix[,2:59]) > 0, ]
rna_matrix <- rna_matrix %>% pivot_longer(., cols = c(2:59), names_to = "sample_id", values_to = "count")
rna_matrix$sample_id <- gsub("_1", "", rna_matrix$sample_id)

metadata <- read.csv("sample_metadata.csv")
metadata <- metadata[, c(1, 11, 32)]
colnames(metadata)[1] = "sample_id"
colnames(metadata)[2] = "cultivar"


cultivar_info <- read.csv("cultivar_info.csv")
cultivar_info <- cultivar_info[,1:2]

metadata <- left_join(metadata, cultivar_info)
metadata <- na.omit(metadata)

gene_exp_cts <- left_join(metadata, gene_exp_cts)
rna_matrix <- left_join(metadata, rna_matrix)

##### Graphing Tissue Expression #####

ggplot(data=gene_exp_cts, aes(x=year, y=count, colour=tissue)) +
  geom_point() + geom_smooth(method = "lm", se = FALSE) + 
  xlab("Year") + ylab("Number of Expressed Genes") + 
  stat_regline_equation() +
  theme_bw()
root_model <- gene_exp_cts %>% filter(tissue == "root") %>% lm(count ~ year, data = .)
leaf_model <- gene_exp_cts %>% filter(tissue == "leaf") %>% lm(count ~ year, data = .)
summary(aov(root_model))
summary(aov(leaf_model))
##### Graphing Gene Expression #####
expression_change <- rna_matrix %>%
  group_by(gene, tissue) %>%
  summarise(slope = coef(lm(count ~ year))["year"], .groups = 'drop')