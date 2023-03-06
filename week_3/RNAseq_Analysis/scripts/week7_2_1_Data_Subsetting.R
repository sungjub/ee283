# EE283 RNAseq Data Subsetting 

library(tidyverse)

sample="C:/Users/Sungjun/Desktop/EE283/RNAseq/data/RNAseq384_SampleCoding.txt"
mytab = read_tsv(sample)
mytab

# Selecting SampleNumber, i7index, Lane, RILcode, TissueCode, Replicate, FullSampleName

mytab2 <- mytab %>%
  select(SampleNumber, i7index, Lane, RILcode, TissueCode, Replicate, FullSampleName)

# view each column's information

table(mytab2$RILcode)
table(mytab2$TissueCode)
table(mytab2$Replicate)


# further filtering: filtering two tissues (Embryos - E and female Brains - B), RILs, and only replicate zeros

mytab3 <- mytab %>%
  select(SampleNumber, i7index, Lane, RILcode, TissueCode, Replicate, FullSampleName) %>%
  filter(RILcode %in% c(21148, 21286, 22162, 21297, 21029, 22052, 22031, 21293, 22378, 22390)) %>%
  filter(TissueCode %in% c("B", "E")) %>%
  filter(Replicate == "0")

# making another text file, which will be used for DEseq2 (.bam file names)

output="C:/Users/Sungjun/Desktop/EE283/RNAseq/data/shortRNAseq.names.txt"

for(i in 1:nrow(mytab3)){
  
  cat(mytab3$SampleNumber[i], "_", mytab3$i7index[i], "_", mytab3$Lane[i], ".sort.bam\n", file=output, append=TRUE, sep='')

}

# upload the `shortRNAseq.names.txt` file to the UCI HPC3 cluter to run `subread` program



