#!/bin/bash

#SBATCH --job-name=ecoevo283_ATACseq_filter
#SBATCH -A ecoevo283
#SBATCH -p standard
#SBATCH --cpus-per-task=2

# filter for properly paired high quality mapped reads
# select only for reads mapping to major autosomes
# it is really helpful to remove mtDNA for ATACseq

# change the directory where .bam files are located

cd /pub/sungjub/ee283/week_3/ATACseq_Analysis/results

# load the right tools
module load samtools/1.15.1

for bam_file in *.sort.bam
do
	samtools view -b -q 30 $bam_file X 2L 2R 3L 3R Y 4  > ${bam_file%.bam}_filtered.bam
done
