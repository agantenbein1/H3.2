# table showing at least two-fold change of h3.2 between the different phases(early,mid, late)
set.seed(42)
tableX2 <- data.frame()
cell.id <- c()
earlyPhase <- c()
midPhase <- c()
latePhase <- c()
# for loop to make tableX2 and sorting out the different phases
j = 1
for (cell_id in unique(table$cell.id)){
  if (table[j,2] > table[j,3] && table[j,2] > table[j,4]){
    if (table[j,2] > (table[j,3]*2) && table[j,2] > (table[j,4])*2){
      tableX2<- rbind(tableX2, table[j,])
      (earlyPhase <- append(earlyPhase, "early"))
      (midPhase <- append(midPhase, "other"))
      (latePhase <- append(latePhase, "other"))
      (cell.id <- append(cell.id, table[j,1]))
    }
    else{
      (earlyPhase <- append(earlyPhase, "other"))
      (midPhase <- append(midPhase, "other"))
      (latePhase <- append(latePhase, "other"))
      (cell.id <- append(cell.id, table[j,1]))
    }
  } else if (table[j,3] > table[j,2] && table[j,3] > table[j,4]){
    if (table[j,3] > (table[j,2]*2) && table[j,3] > (table[j,4])*2){
      tableX2<- rbind(tableX2, table[j,])
      (earlyPhase <- append(earlyPhase, "other"))
      (midPhase <- append(midPhase, "mid"))
      (latePhase <- append(latePhase, "other"))
      (cell.id <- append(cell.id, table[j,1]))
    }else{
      (earlyPhase <- append(earlyPhase, "other"))
      (midPhase <- append(midPhase, "other"))
      (latePhase <- append(latePhase, "other"))
      (cell.id <- append(cell.id, table[j,1]))
    }
  }else if (table[j,4] > (table[j,2]) && table[j,4] > (table[j,3])){
    if (table[j,4] > (table[j,2]*2) && table[j,4] > (table[j,3])*2){
      tableX2<- rbind(tableX2, table[j,])
      (earlyPhase <- append(earlyPhase, "other"))
      (midPhase <- append(midPhase, "other"))
      (latePhase <- append(latePhase, "late"))
      (cell.id <- append(cell.id, table[j,1]))
    }else{
      (earlyPhase <- append(earlyPhase, "other"))
      (midPhase <- append(midPhase, "other"))
      (latePhase <- append(latePhase, "other"))
      (cell.id <- append(cell.id, table[j,1]))
    }
  }else{
    (earlyPhase <- append(earlyPhase, "other"))
    (midPhase <- append(midPhase, "other"))
    (latePhase <- append(latePhase, "other"))
    (cell.id <- append(cell.id, table[j,1]))
    }
  j = j+ 1
}
#saving tableX2
saveRDS(tableX2,"h3.2_phase.rds")
write.csv(tableX2, "h3.2_phase.csv")

# making table of the sorted phase to inner_join with meta
earlyPhase_tbl <- data.frame(cell.id, earlyPhase)
midPhase_tbl <- data.frame(cell.id, midPhase)
latePhase_tbl <- data.frame(cell.id, latePhase)


#barplot of early_mid_late_tbl showing at least two-fold change
phase_order <- c("early", "mid", "late")
bar_early_mid_late <- ggplot(tableX2, x = phase) +
  labs(title = "Cells per Phase Showing at least two-fold Change of H3.2",
            x = "Phase",
            y = "Amount of Cells") +
  geom_bar(aes(x = factor(phase, phase_order)), stat="count", width=0.7)
bar_early_mid_late
ggsave(
  glue("{result_folder_h3.2}Seurat_H3.2_two-fold_Change.pdf"),
  plot = bar_early_mid_late,
  width = 8,
  height = 5,
  device = "pdf"
)

#inner_joing meta with the different phases
meta <- tibble::rownames_to_column(meta, "cell.id")
meta <- inner_join(meta,earlyPhase_tbl)
meta <- inner_join(meta,midPhase_tbl)
meta <- inner_join(meta,latePhase_tbl)

seurat <- AddMetaData(object = seurat, metadata = earlyPhase, col.name = 'earlyPhase')
seurat <- AddMetaData(object = seurat, metadata = midPhase_tbl[,2], col.name = 'midPhase')
seurat <- AddMetaData(object = seurat, metadata = latePhase_tbl[,2], col.name = 'latePhase')

# 3 umaps group by phases
dimEarly = DimPlot(object = seurat, group.by = "earlyPhase", label = FALSE, pt.size = 2, label.size = 7) +
  scale_color_brewer(palette = "Set3") +
  xlim(-10, 10) +
  ylim(-10, 10) +
  ggtitle("H3.2 Early") +
  theme(
    text = element_text(size = 25),
    plot.title = element_text(size = 20),
    axis.text.x = element_text(size = 25, color = "black"),
    axis.text.y = element_text(size = 25, color = "black")
  )
dimEarly
ggsave(
  glue("{result_folder_h3.2}Seurat_H3.2_early_UMAP.png"),
  plot = dimEarly,
  width = 10,
  height = 10,
  dpi = 300,
)

dimMid = DimPlot(object = seurat, group.by = "midPhase", label = FALSE, pt.size = 2, label.size = 7) +
  scale_color_brewer(palette = "Set3") +
  xlim(-10, 10) +
  ylim(-10, 10) +
  ggtitle("H3.2 Mid") +
  theme(
    text = element_text(size = 25),
    plot.title = element_text(size = 20),
    axis.text.x = element_text(size = 25, color = "black"),
    axis.text.y = element_text(size = 25, color = "black")
  )
dimMid
ggsave(
  glue("{result_folder_h3.2}Seurat_H3.2_mid_UMAP.png"),
  plot = dimMid,
  width = 10,
  height = 10,
  dpi = 300,
)

dimLate = DimPlot(object = seurat,group.by = "latePhase", label = FALSE, pt.size = 2, label.size = 7) +
  scale_color_brewer(palette = "Set3") +
  xlim(-10, 10) +
  ylim(-10, 10) +
  ggtitle("H3.2 Late") +
  theme(
    text = element_text(size = 25),
    plot.title = element_text(size = 20),
    axis.text.x = element_text(size = 25, color = "black"),
    axis.text.y = element_text(size = 25, color = "black")
  )
dimLate
ggsave(
  glue("{result_folder_h3.2}Seurat_H3.2_late_UMAP.png"),
  plot = dimLate,
  width = 10,
  height = 10,
  dpi = 300,
)

phases = ggarrange(dim, dimEarly, dimMid, dimLate)
phases
ggsave(
  glue("{result_folder_h3.2}Seurat_H3.2_phases_UMAP.png"),
  plot = phases,
  width = 10,
  height = 10,
  dpi = 300,
)
