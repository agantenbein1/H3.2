pseudo_tbl <- read.delim("/Users/abbygantenbein/Downloads/slingshot_pseudotime_scores.tsv",sep="\t")
colnames(pseudo_tbl)[1]  <- "cell.id"
meta <- inner_join(meta, pseudo_tbl)
seurat <- AddMetaData(object = seurat, metadata = meta[,14], col.name = 'pseudotime_score')
pseudo_umap<- FeaturePlot(seurat, features = "pseudotime_score", pt.size = 3) +
  xlim(-10, 10) +
  ylim(-10, 10) +
  ggtitle("H3.2 Pseudotime Score") +
  theme(
    text = element_text(size = 25),
    plot.title = element_text(size = 20),
    axis.text.x = element_text(size = 25, color = "black"),
    axis.text.y = element_text(size = 25, color = "black")
  )
pseudo_umap
ggsave(
  glue("{result_folder_h3.2}Seurat_H3.2_pseudo_umap.png"),
  plot = pseudo_umap,
  width = 10,
  height = 10,
  dpi = 300,
)


all_umaps = ggarrange(dimEarly, dimMid, dimLate,earlyPercent_umap, midPercent_umap, latePercent_umap,dim,pseudo_umap)
all_umaps
ggsave(
  glue("{result_folder_h3.2}all_umaps_seurat.png"),
  plot = all_umaps,
  width = 15,
  height = 15,
  dpi = 300,
)

#scatter plot of early% vs late%
early_late_scatter_pseudo<- ggplot(meta, aes(x=early_percent, y=late_percent,color = pseudotime_score)) + geom_point()+
  labs(title="H3.2 Early vs Late ", x="Early %", y = "Late %")+
  scale_color_viridis_c()
early_late_scatter_pseudo
ggsave(
  glue("{result_folder_h3.2}early_late_scatter.png"),
  plot = early_late_scatter_pseudo,
  width = 8,
  height = 5,
  device = "png"
)

#3d plot of early vs mid vs late in %
three_d_plot <- plot_ly(
  meta, x = meta[,10], y = meta[,11], z = meta[,12], size = 4, color = meta[,14]) %>%
  add_markers() %>%
  layout(title = 'H3.2 Early vs Mid vs Late ',
         scene = list(xaxis = list(title = 'Early %'),
                      yaxis = list(title = 'Mid %'),
                      zaxis = list(title = 'Late %'))
  )
three_d_plot

