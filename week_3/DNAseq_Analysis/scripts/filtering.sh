#!/bin/bash

#SBATCH --job-name=ecoevo283_DNAseq_filter
#SBATCH -A ecoevo283
#SBATCH -p standard
#SBATCH --cpus-per-task=2

# change the directory where .bam files are located

cd /pub/sungjub/ee283/week_3/DNAseq_Analysis/results

# load the right tools
module load samtools/1.15.1

for bam_file in *ADL06*.bam *ADL09*.bam
do
	echo "filtering $bam_file..."
	samtools view -b -q 30 $bam_file X:1880000-2000000  > ${bam_file%.bam}_filtered.bam
done
