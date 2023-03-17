### Plotting Manhattan plot ### 
### Note the "Homework_week_8" script - need to have "myResult_1", "myResult_2", and "myResult_Merged"

# load library 
library(ggplot2)
library(dplyr)
library(tidyverse)
library(qqman)
library(grid)
library(gridExtra)


# setting the grid (2X1 grid)
par(mfrow=c(2,1))

# wrangle "myResult_1" and "myResult_2"

myResult_1_qq <- myResult_1 %>%
  select(chr, pos, p.value) %>%
  rename(CHR = chr, BP = pos, P = p.value) %>%
  mutate(SNP = paste(CHR, BP, sep = "_")) 

# changing the CHR labels to numbers 
myResult_1_qq <- myResult_1_qq %>%
  mutate(CHR = recode(CHR, "chrX" = 1, "chr2L" = 2, "chr2R" = 3, "chr3L" = 4, "chr3R" = 5))

myResult_2_qq <- myResult_2 %>%
  select(chr, pos, p.value) %>%
  rename(CHR = chr, BP = pos, P = p.value) %>%
  mutate(SNP = paste(CHR, BP, sep = "_")) 

# changing the CHR labels to numbers 
myResult_2_qq <- myResult_2_qq %>%
  mutate(CHR = recode(CHR, "chrX" = 1, "chr2L" = 2, "chr2R" = 3, "chr3L" = 4, "chr3R" = 5))

q1 <- manhattan(myResult_1_qq,
          main = "model 1 result",
          ylim = c(0,10),
          cex = 1.0,
          cex.axis = 0.9,
          logp = FALSE,
          chrlabs = c("chrX", "chr2L", "chr2R", "chr3L", "chr3R"))

q2 <- manhattan(myResult_2_qq,
                main = "model 2 result",
                ylim = c(0,10),
                cex = 1.0,
                cex.axis = 0.9,
                logp = FALSE,
                chrlabs = c("chrX", "chr2L", "chr2R", "chr3L", "chr3R"))

# mannually save the plot 


