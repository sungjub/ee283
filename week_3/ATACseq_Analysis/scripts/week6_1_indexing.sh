#!/bin/bash

#SBATCH --job-name=ecoevo283_ATACseq_Indexing
#SBATCH -A ecoevo283
#SBATCH -p standard
#SBATCH --cpus-per-task=2

# change the directory where .sort.bam files are located
cd /pub/sungjub/ee283/week_3/ATACseq_Analysis/results

# load the right tools
module load samtools/1.15.1

for bam_file in *.sort.bam
do
	samtools index $bam_file
done

