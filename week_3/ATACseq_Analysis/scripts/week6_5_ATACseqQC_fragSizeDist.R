# ATACseqQC_fragSizeDist 

# run this script on your desktop using RStudio after downloading procssed .bam files

# Load the ATACseqQC library
library(ATACseqQC)

# Set the input and output directories
bam_dir <- "C:/Users/Sungjun/Desktop/ee283-ATACseq/data"
output_dir <- "C:/Users/Sungjun/Desktop/ee283-ATACseq/results/QC_fragSizeDist"

# Get a list of all the .dedup.bam files in the directory
bam_files <- list.files(bam_dir, pattern = "*.dedup.bam")

# Loop over each .dedup.bam file and generate the fragment size distribution
for (i in seq_along(bam_files)) {
  if (grepl(".dedup.bam$", bam_files[i])) {
    bamfile <- file.path(bam_dir, bam_files[i])
    bamfile.labels <- gsub(".dedup.bam", "", basename(bamfile))
    fragSize <- fragSizeDist(bamfile, bamfile.labels)
  }
}
