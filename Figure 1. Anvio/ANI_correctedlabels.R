#ANI
library(reshape2)
library(ggplot2)
library(viridis)
library(dplyr)
setwd("~/Desktop")

ani <- read.csv("230731_gbk_files/ANI/ANIb_full_percentage_identity.txt",header = T,sep = '\t')

ani.corr <- ani %>%
  rename("SBP7Φ1" = "SBP7_1", 
         "SBP5Φ1" = "SBP5_1", 
         "SBP5Φ2" = "SBP5_2", 
         "SBP4Φ1" = "SBP4_1", 
         "SBP4Φ2" = "SBP4_2", 
         "S28Φ1" = "S28_1", 
         "S28Φ2" = "S28_2", 
         "SBP2Φ1" = "SBP2_1", 
         "SBP2Φ2" = "SBP2_2", 
         "SBP6Φ1" = "SBP6_1",
         "SBP3.1Φ1" ="SBP3_1_1", 
         "SBP3.1Φ2" = "SBP3_1_2", 
         "SBP3.2Φ1" = "SBP3_2_1", 
         "SBP3.1Φ2.1" = "SBP3_1_2_1") %>%
  mutate(key = case_when(
    key == "SBP7_1" ~ "SBP7Φ1",
    key == "SBP5_1" ~ "SBP5Φ1",
    key == "SBP5_2" ~ "SBP5Φ2",
    key == "SBP4_1" ~ "SBP4Φ1",
    key == "SBP4_2" ~ "SBP4Φ2",
    key == "S28_1" ~ "S28Φ1",
    key == "S28_2" ~ "S28Φ2",
    key == "SBP2_1" ~ "SBP2Φ1",
    key == "SBP2_2" ~ "SBP2Φ2", 
    key == "SBP6_1" ~ "SBP6Φ1",
    key == "SBP3_1_1" ~ "SBP3.1Φ1",
    key == "SBP3_1_2" ~ "SBP3.1Φ2",
    key == "SBP3_2_1" ~ "SBP3.2Φ1",
    key == "SBP3_1_2_1" ~ "SBP3.1Φ2.1",
    TRUE ~ as.character(key)))

ani.melt <- melt(ani.corr, id.vars = "key")

rownames(ani.corr) <- ani.corr[,1]
clusters <- hclust(dist(ani.corr[,-1]))
clusters_2 <- hclust(dist(t(ani.corr[,-1])))
clusters.order <- clusters_2$labels[clusters_2$order]

cat(clusters.order) 

clusters.order

#Fix names and order
ani.melt$variable <- factor(ani.melt$variable, ordered=T, levels= clusters.order, 
                            labels= c("SBP4Φ1" ,"SBP6Φ1","SBP3.1Φ1","SBP3.2Φ1","SBP7Φ1","KB824","SBP1","SBP2Φ1","SBP5Φ1","S28Φ1","S28Φ2","ANB28","SBP3.1Φ2.1","SBP4Φ2","SBP5Φ2","SBP2Φ2","S72","SBP3.1Φ2"))
ani.melt$key <- factor(ani.melt$key, ordered=T, levels= clusters.order, 
                       labels= c("SBP4Φ1" ,"SBP6Φ1","SBP3.1Φ1","SBP3.2Φ1","SBP7Φ1","KB824","SBP1","SBP2Φ1","SBP5Φ1","S28Φ1","S28Φ2","ANB28","SBP3.1Φ2.1","SBP4Φ2","SBP5Φ2","SBP2Φ2","S72","SBP3.1Φ2"))
png("ANI.png", units="in", width=9, height=7, res=600)
ggplot(data = ani.melt) +
  geom_tile( aes(x=key, y=variable, fill=value), color="black") +
  labs(fill="", x='',y='') +
  geom_text(aes(x=key, y=variable, label = round(value, digits = 2))) +
  scale_fill_gradientn(colors = c("#ffffb2", '#ffeda0','#feb24c','#e31a1c'),  breaks= c(.70,.9,.95,1),labels=c("70 %", "90 %","95 %","100 %"), limits=c(0.7,1),
                       na.value = "white") +
  theme(axis.text = element_text(size=15, color="black"),
    axis.text.x = element_text(angle=90, hjust = 1, vjust = .5),
    legend.text = element_text(size=15),
    legend.key.size = unit(x = 10, units = "mm"))
dev.off()

   #alignmnet_coverage

cov <- read.delim("Annotated_StenoPhage_220307/ANI/ANIb_alignment_coverage.txt",header = T,sep = '\t')
cov.melt <- melt(cov, id.vars = "key")
rownames(cov) <- cov[,1]
clusters2 <- hclust(dist(cov[,-1]))
clusters.order2 <- clusters2$labels[clusters2$order]

#order
cov.melt$variable <- factor(cov.melt$variable, ordered=T, levels= clusters.order2, 
                            labels= c("KB824", "SBP6_Phage1", "SBP1", "SBP7_Phage1", "SBP3_1_Phage1", "SBP3_2_Phage1", "SBP2_Phage1", "SBP4_Phage1", "SBP5_Phage1", "S28_Phage1", "S28_Phage2", "ANB28", "SBP4_Phage2", "SBP5_Phage2", "S72", "SBP3_1_Phage2_1", "SBP2_Phage2", "SBP3_1_Phage2"))
cov.melt$key <- factor(cov.melt$key, ordered=T, levels= clusters.order2, 
                       labels= c("KB824", "SBP6_Phage1", "SBP1", "SBP7_Phage1", "SBP3_1_Phage1", "SBP3_2_Phage1", "SBP2_Phage1", "SBP4_Phage1", "SBP5_Phage1", "S28_Phage1", "S28_Phage2", "ANB28", "SBP4_Phage2", "SBP5_Phage2", "S72", "SBP3_1_Phage2_1", "SBP2_Phage2", "SBP3_1_Phage2"))

ggplot(data = cov.melt) +
  geom_tile( aes(x=key, y=variable, fill=value), color="black") +
  labs(fill="", x='',y='') +
#  scale_fill_viridis(option = "magma") +
  scale_fill_gradientn(colors = c('#ffffcc','#fed976','#feb24c','#fd8d3c','#f03b20','#bd0026'), breaks=c(0,.20,.40,.60,.80,1), limits=c(0,1),
                       labels=c("0 %","20 %", "40 %", "60 %", "80 %", "100 %") ) +
  theme(axis.text = element_text(size=15, color="black"),
        axis.text.x = element_text(angle=90, hjust = 1, vjust = .5),
        legend.text = element_text(size=15),
        legend.key.size = unit(x = 10, units = "mm"))
