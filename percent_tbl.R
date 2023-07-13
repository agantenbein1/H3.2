#sum of read counts of early, mid and late so can calculate a perentage 
sum <- (table$early + table$Mid + table$Late)
table <- cbind(table, sum)
early_percent <- ((table$early/table$sum)*100)
mid_percent <- ((table$Mid/table$sum)*100)
late_percent<- ((table$Late/table$sum)*100)
tablePercent <- cbind(table, early_percent, mid_percent, late_percent)
tablePercent <- tablePercent[c("cell.id", "early_percent","mid_percent", "late_percent", "phase" )]

saveRDS(tablePercent,"h3.2_phase_Percent.rds")
write.csv(tablePercent, "h3.2_phase_Percent.csv")

#bar graph of read count per phase
orderPhase <- c("early","early/mid", "mid", "mid/late","late")
bar_phase_percent <- ggplot(tablePercent,aes( x = phase, fill = phase) ) +
  labs(title = "H3.2 Amount of Cells per Phase",
       x = "Phase",
       y = "Amount of Cells") +
  geom_bar(aes(x = factor(phase, orderPhase)), width=0.7,)+
  geom_text(aes(label = after_stat(count)), stat="count",vjust=-0.3, size=3)
bar_phase_percent
ggsave(
  glue("{result_folder_h3.2}Seurat_H3.2_bar_graph.pdf"),
  plot = bar_phase_percent,
  width = 8,
  height = 5,
  device = "pdf"
)

#scatter plot of early% vs late%
early_late_scatter<- ggplot(meta, aes(x=early_percent, y=late_percent)) + geom_point()+
  labs(title="H3.2 Early vs Late ", x="Early %", y = "Late %")
early_late_scatter
ggsave(
  glue("{result_folder_h3.2}early_late_scatter.png"),
  plot = early_late_scatter,
  width = 8,
  height = 5,
  device = "png"
)

#3d plot of early vs mid vs late in %
three_d_plot <- plot_ly(
  meta, x = early_percent, y = mid_percent, z = late_percent, size = 4
) %>%
  add_markers() %>%
  layout(title = 'H3.2 Early vs Mid vs Late ',
    scene = list(xaxis = list(title = 'Early %'),
                 yaxis = list(title = 'Mid %'),
                 zaxis = list(title = 'Late%'))
  )
three_d_plot

#scatter plot of early vs late (raw counts)

early_late_scatter_count <- ggplot(table, aes(x=early, y=Late)) + geom_point()+
  labs(title="H3.2 Early vs Late ", x="Early", y = "Late")
early_late_scatter_count
ggsave(
  glue("{result_folder_h3.2}early_late_scatter_count.png"),
  plot = early_late_scatter_count,
  width = 8,
  height = 5,
  device = "png"
)
