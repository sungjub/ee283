#!/bin/bash

#SBATCH --job-name=deeptools
#SBATCH -A ecoevo283
#SBATCH -p standard
#SBATCH --cpus-per-task=2

SourceDir="/pub/sungjub/ee283/week_3/DNAseq_Analysis/results"
DestDir="/pub/sungjub/ee283/week_3/DNAseq_Analysis/results/bamCoverage"

for f in $SourceDir/ADL0[6,9]*.sort_filtered.bam

do
# you can add "--extendReads" command for homework 4
	filename=$(basename "$f")
	outputfile="${filename%.*}.bw"
	bamCoverage -b $f -o $DestDir/$outputfile

done


