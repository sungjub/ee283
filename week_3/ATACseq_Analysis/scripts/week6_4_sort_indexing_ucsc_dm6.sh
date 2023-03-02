#!/bin/bash

#SBATCH --job-name=ATACseq_sorting
#SBATCH -A ecoevo283
#SBATCH -p standard
#SBATCH --cpus-per-task=2

# Load the program:
module load samtools/1.15.1

# Path to directory containing the .bam files
SourceDir="/pub/sungjub/ee283/week_3/ATACseq_Analysis/results/ucsc_dm6"

# Path to the text file containing the unique IDs
ID_FILE="/pub/sungjub/ee283/week_3/ATACseq_Analysis/scripts/prefixes.txt"

# Loop over each ID in the text file
while read ID; do

	# Construct the file name of the corresponding .bam file
	BAM_FILE="${SourceDir}/${ID}.sort_filtered.bam"

	# Sort the .bam file using samtools sort
	samtools sort "${BAM_FILE}" -o "${SourceDir}/${ID}.true.sorted.bam"

	# Index the sorted .bam file using samtools index
	samtools index "${SourceDir}/${ID}.true.sorted.bam"

done < "${ID_FILE}"
