# H3.2
Data analysis of H3.2 sciTIP-Seq
Run Code Order:
1. Seurat_h3.2 (loads the different libraries needed. It also defines seurat, genomic_ranges, and norm_counts)
2. top_100 (Finds the top 100 regions)
3. plots(Umap and Violin Plot of seurat object, and a box plot of the top 100 regions)
4. early_mid_late_tbl(table to show the read counts at each different mESC replication timing data (early, mid, late) at the different cell ids, and indicates which phase had the most read counts)
5. EarlyMidLateTwoFoldChange (A table showing at least two-fold change of h3.2 between the different phases(early,mid, late), and 3 umaps highlighting each phase, and bar graph with how many cells per phase)
6. percent_tbl( calculates the percentage of read count per cell for each phase and makes a scatter plot of the early phase% vs late% as well as a 3d graph of early% vs mid% vs late%)
7. percent_umaps( makes 3 umap for each phase and is scaled by the phase percentage) 
   
