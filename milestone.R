pseduo_milestone = readRDS(file ="/Users/abbygantenbein/Desktop/SCILIFE/slingshot_TI.Rds")
milestone_tbl <- data.frame(pseduo_milestone[7])
mile_stone_tbl = data.frame()
m = 1
s=2
for (mile in (milestone_tbl$milestone_percentages.cell_id)){
  for (stone in (milestone_tbl$milestone_percentages.cell_id)){
    if (milestone_tbl[m,1] == milestone_tbl[s,1]){
      if (milestone_tbl[m,3] > milestone_tbl[s,3]){
       mile_stone_tbl <-  rbind(mile_stone_tbl, milestone_tbl[c(m),])
      }else if (milestone_tbl[s,3] > (milestone_tbl[m,3])){
        mile_stone_tbl <- rbind(mile_stone_tbl, milestone_tbl[c(s),])
      }
    }
    if(s< 3252){
      s =s+1
    }else{
      break
    }
  }
  m = m+1
  s = m +1
  if(s>3252){
    break
  }
}



milestone =character()

i = 1
four = 0
two = 0
for (cell_id in unique(mile_stone_tbl$milestone_percentages.cell_id)){ 
  if (mile_stone_tbl[i,2] == '4' && mile_stone_tbl[i,3] >= 0.75){
    milestone <- append(milestone, '4')
  } else if (mile_stone_tbl[i,2] == '2' && mile_stone_tbl[i,3] >= 0.75){
    milestone <- append(milestone, '2')
  }else {
    milestone <- append(milestone, 'other')
  }
  i = i+ 1
}
meta <- cbind(meta, milestone)
seurat <- AddMetaData(object = seurat,metadata = milestone, col.name = 'milestone')
milestone_umap<- DimPlot(seurat, group.by = "milestone", pt.size = 2) +
  xlim(-10, 10) +
  ylim(-10, 10) +
  ggtitle("H3.2 Milestone 2 and 4") +
  theme(
    text = element_text(size = 25),
    plot.title = element_text(size = 20),
    axis.text.x = element_text(size = 25, color = "black"),
    axis.text.y = element_text(size = 25, color = "black")
  )
milestone_umap
ggsave(
  glue("{result_folder_h3.2}Seurat_H3.2_milestone_UMAP.png"),
  plot = dimEarly,
  width = 10,
  height = 10,
  dpi = 300,
)
