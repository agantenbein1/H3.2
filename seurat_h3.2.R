#to install GenomicFeatures
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("GenomicFeatures")
install.packages("rmarkdown")
# packages
suppressPackageStartupMessages({
  library("Seurat")
  library("Signac")
  library("glue")
  library("tidyverse")
  library("tidyr")
  library("Matrix")
  library("GenomicFeatures")
  library("data.table")
  library("ggpubr")
  library("GenomicRanges")
  library("rtracklayer")
  library("IRanges")
  library("plotly")
  library("scatterplot3d")
  library("processx")

})

# result folder
result_folder_h3.2 = "/Users/abbygantenbein/Desktop/SCILIFE/results/h3.2"

# create Seurat object
# raw = fread(file = "../data/count_tables/20230510_read_counts-cells_above_1000reads.tsv")
# rows = raw$range
# raw = raw %>% dplyr::select(-range)
# raw_sparse = as(as.matrix(raw), "sparseMatrix")
# rownames(raw_sparse) = rows
# rm(raw)
# seurat = CreateSeuratObject(counts = raw_sparse, project = "sciTIP_Seq")
#
# # export Rds
# saveRDS(seurat, "../data/count_tables/20230510_read_counts-cells_above_1000reads.Rds")

# load Seurat object
seurat = readRDS(file = "/Users/abbygantenbein/Desktop/SCILIFE/20230316_H3.2_read_counts-cells_above_1000reads.Rds")
# normalization
seurat = RunTFIDF(seurat)
norm_counts = seurat@assays$RNA@counts # normalized read counts
genomic_ranges = tibble(range = rownames(norm_counts))






