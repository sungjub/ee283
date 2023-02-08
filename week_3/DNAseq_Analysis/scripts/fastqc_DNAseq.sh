#!/bin/bash

#SBATCH --job-name=ecoevo283_DNAseq_FASTQC
#SBATCH -A ecoevo283
#SBATCH -p standard
#SBATCH --cpus-per-task=2

SourceDir="/pub/sungjub/ee283/rawdata/DNAseq/"
DestDir="/pub/sungjub/ee283/week_3/DNAseq_Analysis/QC/"
File="$SourceDir/*.fq.gz"

for f in $File
do 
	echo "Processing $f..." 
	fastqc -o "$DestDir" $f
done 

echo "FASTQC Job Completed"

