#importing bed files
bed_early <- "/Users/abbygantenbein/Desktop/SCILIFE/RepliTime_early_mm10.bed"
bed_mid <- "/Users/abbygantenbein/Desktop/SCILIFE/RepliTime_mid_mm10.bed"
bed_late <- "/Users/abbygantenbein/Desktop/SCILIFE/RepliTime_late_mm10.bed"
norm_counts <- data.frame(norm_counts)
norm_counts <- rownames_to_column(norm_counts)
genome <- separate( norm_counts,col= rowname, into =c("Chr","Start","End"), sep =  "-")

early_mm10 <- import(bed_early)
mid_mm10 <- import(bed_mid)
late_mm10 <- import(bed_late)
# seperating genomic_ranges and converting into genomic ranges(GRanges)
#genome <- separate( genomic_ranges,col= range , into =c("Chr","Start","End"), sep =  "-")
early_mm10 <- as(early_mm10, "GRanges")
mid_mm10 <- as(mid_mm10 , "GRanges")
late_mm10 <- as(late_mm10, "GRanges")
seuratGenome <- as(genome,"GRanges")
#finding overlap
early_overlap <- findOverlaps(seuratGenome, early_mm10)
mid_overlap <- findOverlaps(seuratGenome, mid_mm10)
late_overlap <- findOverlaps(seuratGenome, late_mm10)
# using query hits to select overlaps
early_query <- queryHits(early_overlap)
mid_query <- queryHits(mid_overlap)
late_query <- queryHits(late_overlap)
early_gr <- seuratGenome[early_query]
mid_gr <- seuratGenome[mid_query]
late_gr <- seuratGenome[late_query]

# get rid of duplicates
early_gr <- data.frame(early_gr)
early_gr <- early_gr[ -c(4,5) ]
early_gr <- early_gr %>% unite(chromosome, c("seqnames","start","end"),sep="-")
early_gr<-pivot_longer(early_gr, cols = !chromosome)
early_gr <- distinct(early_gr, .keep_all = TRUE)
early_gr <- early_gr %>% rename("name" = "cell.id")
#mid
mid_gr <- data.frame(mid_gr)
mid_gr <- mid_gr[ -c(4,5) ]
mid_gr <- mid_gr %>% unite(chromosome, c("seqnames","start","end"),sep="-")
mid_gr<-pivot_longer(mid_gr, cols = !chromosome)
mid_gr <- distinct(mid_gr, .keep_all = TRUE)
mid_gr <- mid_gr %>% rename("name" = "cell.id")
#late
late_gr <- data.frame(late_gr)
late_gr <- late_gr[ -c(4,5) ]
late_gr <- late_gr %>% unite(chromosome, c("seqnames","start","end"),sep="-")
late_gr<-pivot_longer(late_gr, cols = !chromosome )
late_gr <- distinct(late_gr, .keep_all = TRUE)
late_gr <- late_gr %>% rename("name" = "cell.id")

early_tbl <- early_gr %>% group_by(cell.id)%>% summarise(early = sum(value))
mid_tbl <- mid_gr %>% group_by(cell.id) %>% summarise(Mid = sum(value))
late_tbl <- late_gr %>% group_by(cell.id) %>% summarise(Late = sum(value))

table <- cbind(early_tbl, mid_tbl, late_tbl)
table <- table[ -c(3,5)]
result_folder_h3.2 <- saveRDS(table,"h3.2_early_mid_late.rds")

#adding a column showing which phase had the most read count
x =character()
i = 1
for (cell_id in unique(table$cell.id)){
  if (table[i,2] > table[i,3] && table[i,2] > table[i,4]){
    x <- append(x, 'early')
  } else if (table[i,3] > table[i,2] && table[i,3] > table[i,4]){
      x <- append(x, 'mid')
    }else {
        x <- append(x, 'late')
  }
  i = i+ 1
  }
table <- table %>% add_column(x)
colnames(table)[5]  <- "phase"

