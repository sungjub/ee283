### Making multiple plots from the RNAseq data EE283 ###
### Assume you already prepared "res", "dds", and "rld" files - note RNAseq homework script "week7_2_2_DEseq2.R"

# load library
library("DESeq2")
library("ggplot2")
library("gridExtra")
library("gridGraphics")
library("grid")

### note the figures made in the DESeq2 package are base R plots

# setting the number of panels using par function
par(mfrow=c(2,2))

# MA plot
plotMA( res, ylim = c(-1, 1))

# DispEsts
plotDispEsts( dds )

# Volcano plot 1
sig <- res$pvalue < 0.05 & abs(res$log2FoldChange) > 2
plot(
  res$log2FoldChange,
  -log10(res$pvalue),
  col = ifelse(sig, "red", "black"),
  xlab = "log2 fold change",
  ylab = "-log10 p-value",
  main = "Volcano plot"
)

# Volcano plot 2
sig2 <- res$pvalue < 0.01 & abs(res$log2FoldChange) > 5
plot(
  res$log2FoldChange,
  -log10(res$pvalue),
  col = ifelse(sig2, "red", "black"),
  xlab = "log2 fold change",
  ylab = "-log10 p-value",
  main = "Volcano plot"
)

# save the figure manually 

