meta <- inner_join(meta,tablePercent)
seurat <- AddMetaData(object = seurat, metadata = early_percent, col.name = 'earlyPercent')
seurat <- AddMetaData(object = seurat,metadata = mid_percent, col.name = 'midPercent')
seurat <- AddMetaData(object = seurat,metadata = late_percent, col.name = 'latePercent')

earlyPercent_umap<- FeaturePlot(seurat, features = "earlyPercent", pt.size = 2) +
  xlim(-10, 10) +
  ylim(-10, 10) +
  ggtitle("H3.2 Early Percent") +
  theme(
    text = element_text(size = 25),
    plot.title = element_text(size = 20),
    axis.text.x = element_text(size = 25, color = "black"),
    axis.text.y = element_text(size = 25, color = "black")
  )
earlyPercent_umap
ggsave(
  glue("{result_folder_h3.2}Seurat_H3.2_earlyPercent_umap.png"),
  plot = earlyPercent_umap,
  width = 10,
  height = 10,
  dpi = 300,
)

midPercent_umap<- FeaturePlot(seurat, features = "midPercent", pt.size = 2) +
  xlim(-10, 10) +
  ylim(-10, 10) +
  ggtitle("H3.2 Mid Percent") +
  theme(
    text = element_text(size = 25),
    plot.title = element_text(size = 20),
    axis.text.x = element_text(size = 25, color = "black"),
    axis.text.y = element_text(size = 25, color = "black")
  )
midPercent_umap
ggsave(
  glue("{result_folder_h3.2}Seurat_H3.2_midPercent_umap.png"),
  plot = midPercent_umap,
  width = 10,
  height = 10,
  dpi = 300,
)

latePercent_umap<- FeaturePlot(seurat, features = "latePercent", pt.size = 2) +
  xlim(-10, 10) +
  ylim(-10, 10) +
  ggtitle("H3.2 Late Percent") +
  theme(
    text = element_text(size = 25),
    plot.title = element_text(size = 20),
    axis.text.x = element_text(size = 25, color = "black"),
    axis.text.y = element_text(size = 25, color = "black")
  )
latePercent_umap
ggsave(
  glue("{result_folder_h3.2}Seurat_H3.2_latePercent_UMAP.png"),
  plot = latePercent_umap,
  width = 10,
  height = 10,
  dpi = 300,
)

percentDim = ggarrange(dim, earlyPercent_umap, midPercent_umap, latePercent_umap)
percentDim
ggsave(
  glue("{result_folder_h3.2}Seurat_H3.2_percents_UMAP.png"),
  plot = percentDim,
  width = 10,
  height = 10,
  dpi = 300,
)
