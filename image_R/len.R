library(ggplot2)
library(dplyr)
# library(tidyr)   # replace_na
# library(tibble)  # column_to_rownames

###
DATA_DIR <- 'GitHub/hse21_H3K27me3_ZDNA_human/data/'
OUT_DIR <- 'GitHub/hse21_H3K27me3_ZDNA_human/image/'

#NAME <- 'H3K27me3_SK-N-SH.ENCFF403PWJ.hg19'
#NAME <- 'H3K27me3_SK-N-SH.ENCFF403PWJ.hg38'
#NAME <- 'H3K27me3_SK-N-SH.ENCFF493XGA.hg19'
#NAME <- 'H3K27me3_SK-N-SH.ENCFF493XGA.hg38'
NAME <- 'DeepZ'


###

bed_df <- read.delim(paste0(DATA_DIR, NAME, '.bed'), as.is = TRUE, header = FALSE)
#colnames(bed_df) <- c('chrom', 'start', 'end', 'name', 'score')
colnames(bed_df) <- c('chrom', 'start', 'end')
bed_df$len <- bed_df$end - bed_df$start
head(bed_df)

ggplot(bed_df) +
  aes(x = len) +
  geom_histogram() +
  ggtitle(NAME, subtitle = sprintf('Number of peaks = %s', nrow(bed_df))) +
  theme_bw()
ggsave(paste0('len_hist.', NAME, '.pdf'), path = OUT_DIR)
