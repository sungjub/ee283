# running DEseq2 from the `fly_counts.txt` file - the subread output)
# download the `fly_counts.txt` file in my local computer

library(DESeq2)
library(tidyverse)

## creating the sampleInfo table

sample="C:/Users/Sungjun/Desktop/EE283/RNAseq/data/RNAseq384_SampleCoding.txt"
mytab = read_tsv(sample)
mytab

# Selecting SampleNumber, i7index, Lane, RILcode, TissueCode, Replicate, FullSampleName
# create the sampleInfo table

sampleInfo <- mytab %>%
  select(SampleNumber, i7index, Lane, RILcode, TissueCode, Replicate, FullSampleName)

# create countdata file

count="C:/Users/Sungjun/Desktop/EE283/RNAseq/results/fly_counts.txt"
countdata = read.table(count, header = TRUE, row.names=1)
head(countdata)

# removing first five columns (chr, start, end, strand, and length)

countdata <- countdata %>%
  select(6:ncol(countdata))

# Extract the SampleNumber from the column names
SampleNumber <- sub("X", "", sub("_.*", "", colnames(countdata)))

# Convert to numeric
SampleNumber <- as.numeric(SampleNumber)

# Get the FullSampleName from the sampleInfo file
sample_name <- sampleInfo$FullSampleName[match(SampleNumber, sampleInfo$SampleNumber)]

# Replace the column names in countdata
colnames(countdata) <- sample_name

matched <- sample_name %in% sampleInfo$FullSampleName

# check if the values in the `FullSampleName` presents in the sampleInfo text file
matched_samples <- sampleInfo %>%
  filter(FullSampleName %in% sample_name)

# creating DEseq2 object and running DEseq2

dds = DESeqDataSetFromMatrix(countData=countdata, colData=matched_samples, design=~TissueCode)
dds <- DESeq(dds)
res <- results( dds )
res

plotMA( res, ylim = c(-1, 1) )
plotDispEsts( dds )
hist( res$pvalue, breaks=20, col="grey" )

###  throw out lowly expressed genes?? ... I leave this as an exercise
###  add external annotation to "gene ids"
# log transform
rld = rlog( dds )

## this is where you could just extract the log transformed normalized data for each sample ID, and then roll your own analysis
head( assay(rld) )
mydata = assay(rld)

sampleDists = dist( t( assay(rld) ) )
sampleDistMatrix = as.matrix( sampleDists )
rownames(sampleDistMatrix) = rld$TissueCode
colnames(sampleDistMatrix) = NULL

library( "gplots" )
library( "RColorBrewer" )

colours = colorRampPalette( rev(brewer.pal(9, "Blues")) )(255)
heatmap.2( sampleDistMatrix, trace="none", col=colours)

# PCs
# wow you can sure tell tissue apart
print( plotPCA( rld, intgroup = "TissueCode") )

# heat map with gene clustering
library( "genefilter" )
topVarGenes <- head( order( rowVars( assay(rld) ), decreasing=TRUE ), 35 )
heatmap.2( assay(rld)[ topVarGenes, ], scale="row", trace="none", dendrogram="column", col = colorRampPalette( rev(brewer.pal(9, "RdBu")) )(255))

# volcano plot

res <- results(dds)
sig <- res$pvalue < 0.01 & abs(res$log2FoldChange) > 5
plot(
  res$log2FoldChange,
  -log10(res$pvalue),
  col = ifelse(sig, "red", "black"),
  xlab = "log2 fold change",
  ylab = "-log10 p-value",
  main = "Volcano plot"
)


