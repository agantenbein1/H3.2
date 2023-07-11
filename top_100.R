# retrieve those genomic intervales (rows)
# that show high read count numbers ( = high H3.2 incorporation)
#head(norm_counts)
ave_norm_counts <- rowMeans(norm_counts)
ave_norm_counts = data.frame(ave_norm_counts)
top_rows<- ave_norm_counts %>% top_n(100)

