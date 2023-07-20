cluster0 <- import("/Users/abbygantenbein/Downloads/cluster0_RPGC.bigwig")
cluster1 <- import("/Users/abbygantenbein/Downloads/cluster1_RPGC.bigwig")
cluster2 <- import("/Users/abbygantenbein/Downloads/cluster2_RPGC.bigwig")
cluster3 <- import("/Users/abbygantenbein/Downloads/cluster3_RPGC.bigwig")
cluster4 <- import("/Users/abbygantenbein/Downloads/cluster4_RPGC.bigwig")
cluster5 <-import("/Users/abbygantenbein/Downloads/cluster5_RPGC.bigwig")

clusters<- c("/Users/abbygantenbein/Downloads/cluster0_RPGC.bigwig", 
                       "/Users/abbygantenbein/Downloads/cluster1_RPGC.bigwig",
                       "/Users/abbygantenbein/Downloads/cluster2_RPGC.bigwig",
                       "/Users/abbygantenbein/Downloads/cluster3_RPGC.bigwig",
                       "/Users/abbygantenbein/Downloads/cluster4_RPGC.bigwig",
                       "/Users/abbygantenbein/Downloads/cluster5_RPGC.bigwig")

earlyClusters <- bw_loci(bwfiles = clusters, 
                loci=early_mm10)
earlyClusters <- data.frame(earlyClusters)

midClusters <- bw_loci(bwfiles = clusters,
                    loci=mid_mm10)
midClusters <- data.frame(midClusters)

lateClusters <- bw_loci(bwfiles = clusters,
                       loci=late_mm10)
lateClusters <- data.frame(lateClusters)
