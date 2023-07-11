#boxplot using ggplot
top_boxplot = ggplot(top_rows, aes(x = "top 100 genomic ranges ", y= ave_norm_counts)) +
  geom_boxplot(notch=FALSE) + labs(title = "Enrichment of H3.2", y = "H3.2")
ggsave(
  glue("{result_folder_h3.2}Seurat_H3.2_sciTIP_boxplot.png"),
  plot = top_boxplot,
  width = 10,
  height = 10,
  dpi = 300,
)

seurat = FindTopFeatures(seurat, min.cutoff = 'q0')
seurat = RunSVD(seurat)
# Non-linear dimension reduction and clustering
seurat = RunUMAP(object = seurat,
                 reduction = 'lsi',
                 dims = 2:30)
seurat = FindNeighbors(object = seurat,
                       reduction = 'lsi',
                       dims = 2:30)
seurat = FindClusters(object = seurat,
                      verbose = FALSE,
                      resolution = 0.5,
                      algorithm = 3)
meta = seurat@meta.data
seurat@meta.data = meta
x = seurat@meta.data


# quality plots
nCount_violin_clusters = VlnPlot(seurat, group.by = "seurat_clusters", features = "nCount_RNA", pt.size = 0.1) +
  scale_fill_brewer(palette = "Set3") +
  ggtitle("nCount (bins)") +
  xlab("cluster") +
  ylab("read count") +
  #ylim(0, 60000) +
  scale_y_continuous(breaks = seq(0, 300000, 50000)) +
  theme(
    text = element_text(size = 25),
    plot.title = element_text(size = 20),
    axis.text.x = element_text(size = 25, color = "black", angle = 0),
    axis.text.y = element_text(size = 25, color = "black")
  ) +
  NoLegend()
nCount_violin_clusters

# visualizations
dim = DimPlot(object = seurat, label = FALSE, pt.size = 2, label.size = 7) +
  scale_color_brewer(palette = "Set3") +
  xlim(-10, 10) +
  ylim(-10, 10) +
  ggtitle("H3.2 sciTIP-Seq") +
  theme(
    text = element_text(size = 25),
    plot.title = element_text(size = 20),
    axis.text.x = element_text(size = 25, color = "black"),
    axis.text.y = element_text(size = 25, color = "black")
  )
dim
ggsave(
  glue("{result_folder_h3.2}Seurat_H3.2_sciTIP_0510_UMAP.png"),
  plot = dim,
  width = 10,
  height = 10,
  dpi = 300,
)

ggsave(
  glue("{result_folder_h3.2}Seurat_H3.2_sciTIP_0510_UMAP.pdf"),
  plot = dim,
  width = 10,
  height = 10,
  device = "pdf"
)


ggsave(
  glue("{result_folder_h3.2}Seurat_H3.2_sciTIP-quality_plots.png"),
  plot = nCount_violin_clusters,
  width = 12,
  height = 5,
  dpi = 300,
)

ggsave(
  glue("{result_folder_h3.2}Seurat_H3.2_sciTIP_quality_plots.pdf"),
  plot = nCount_violin_clusters,
  width = 12,
  height = 5,
  device = "pdf"
)
