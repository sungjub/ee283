#!/bin/bash

#SBATCH --job-name=ecoevo283_ATACseq_filter
#SBATCH -A ecoevo283
#SBATCH -p standard
#SBATCH --cpus-per-task=2

# filter for properly paired high quality mapped reads
# select only for reads mapping to major autosomes
# it is really helpful to remove mtDNA for ATACseq

# change the directory where .bam files are located

cd /pub/sungjub/ee283/week_3/ATACseq_Analysis/results/ucsc_dm6

# load the right tools
module load samtools/1.15.1

for bam_file in *.sort.bam
do
	# changing the chromosome names (eg, from X to chrX - following the UCSC format)
	samtools view -b -q 30 $bam_file chrX chr2L chr2R chr3L chr3R chrY chr4  > ${bam_file%.bam}_filtered.bam
done
