#Installing BiocManager
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("ChIPseeker")
BiocManager::install("TxDb.Hsapiens.UCSC.hg19.knownGene", force=TRUE)
BiocManager::install("clusterProfiler", force=TRUE)
BiocManager::install("GenomicFeatures", force=TRUE)
BiocManager::install("org.Hs.eg.db", force=TRUE)
BiocManager::install("ChIPpeakAnno", force=TRUE) 

library(ChIPseeker)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
library(clusterProfiler)

###

DATA_DIR <- 'GitHub/hse21_H3K27me3_ZDNA_human/data/'
OUT_DIR <- 'GitHub/hse21_H3K27me3_ZDNA_human/image/'

NAME <- 'H3K27me3_SK-N-SH.intersect_with_DeepZ'
#NAME <- 'DeepZ'
#NAME <- 'H3K27me3_SK-N-SH.ENCFF403PWJ.hg19.filtered'
#NAME <- 'H3K27me3_SK-N-SH.ENCFF493XGA.hg19.filtered'
BED_FN <- paste0(DATA_DIR, NAME, '.bed')


###

txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene

peakAnno <- annotatePeak(BED_FN, tssRegion=c(-3000, 3000), TxDb=txdb, annoDb="org.Hs.eg.db")

pdf(paste0(OUT_DIR, 'chip_seeker.', NAME, '.plotAnnoPie.pdf'))
#png(paste0(OUT_DIR, 'chip_seeker.', NAME, '.plotAnnoPie.png'))
plotAnnoPie(peakAnno)
dev.off()

 
peak <- readPeakFile(BED_FN)
 pdf(paste0(OUT_DIR, 'chip_seeker.', NAME, '.covplot.pdf'))
 covplot(peak, weightCol="V5")
 dev.off()
 