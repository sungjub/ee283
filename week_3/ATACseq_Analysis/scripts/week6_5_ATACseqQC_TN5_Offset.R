# ATACseqQC_TN5_offsets

# run this script on your desktop using RStudio after downloading procssed .bam files

# Load required libraries
library(ATACseqQC)
library(Rsamtools) 
library(BSgenome.Dmelanogaster.UCSC.dm6)
library(TxDb.Dmelanogaster.UCSC.dm6.ensGene)
library(GenomicFeatures)
library(ChIPpeakAnno)

# Set the input and output directories
bam_dir <- "C:/Users/Sungjun/Desktop/ee283-ATACseq/data"
output_dir <- "C:/Users/Sungjun/Desktop/ee283-ATACseq/results/QC_TN5_Offset"
outPath <- "C:/Users/Sungjun/Desktop/ee283-ATACseq/results/QC_TN5_Offset_splitByCut"

# this works for the example bam file in the tutorial
tags <- c("AS", "XN", "XM", "XO", "XG", "NM", "MD", "YS", "YT")

# this seems to work more generally for any bam file
# the tags have to match the tags that happen to be in the bamfile
# you are working with
possibleTag <- combn(LETTERS, 2)
possibleTag <- c(paste0(possibleTag[1, ], possibleTag[2, ]),
                 paste0(possibleTag[2, ], possibleTag[1, ]))

# Get a list of all the .dedup.bam files in the directory 
bam_files <- list.files(bam_dir, pattern = "*.dedup.bam")

# Loop over each .dedup.bam file and perform TN5 offset

for (i in seq_along(bam_files)) { 
  if (grepl(".dedup.bam$", bam_files[i])) { 
    bamfile <- file.path(bam_dir,bam_files[i])
    # Get the tags present in the bam file
    bamTags <- scanBam(bamfile, yieldSize = 100, param = ScanBamParam(tag = possibleTag))[[1]]$tag
    tags <- names(bamTags)[lengths(bamTags)>0]
    # Shift the coordinates of 5' ends of alignments in the bam file
    gal <- readBamFile(bamfile, tag = tags, asMates = TRUE)
    gal1 <- shiftGAlignmentsList(gal)
    # Output the shifted bam file
    output_bam <- file.path(output_dir, paste0(basename(bamfile), "_shifted.bam"))
    export(gal1, output_bam)
  }
}

txs <- transcripts(TxDb.Dmelanogaster.UCSC.dm6.ensGene)
objs <- splitGAlignmentsByCut(gal1, txs = txs, outPath = outPath)

# generate TSS
TSS <- promoters(txs, upstream=0, downstream=1)
TSS <- unique(TSS)

# estimating the library size

bamfiles_for_lib_est <- list.files(bam_dir, pattern = "\\.bam$", full.names = TRUE)
librarySize <- estLibSize(bamfiles_for_lib_est)

## calculate the signals around TSSs.  
NTILE <- 101  
dws <- ups <- 1010  
sigs <- enrichedFragments(gal=objs[c("NucleosomeFree",  
                                     "mononucleosome",  
                                     "dinucleosome",  
                                     "trinucleosome")],  
                          TSS=TSS,  
                          librarySize=librarySize,  
                          seqlev=seqlevels(gal),  
                          TSS.filter=0.5,  
                          n.tile = NTILE,  
                          upstream = ups,  
                          downstream = dws)  
## log2 transformed signals  
sigs.log2 <- lapply(sigs, function(.ele) log2(.ele+1))  
#plot heatmap  
featureAlignedHeatmap(sigs.log2, reCenterPeaks(TSS, width=ups+dws),  
                      zeroAt=.5, n.tile=NTILE)
