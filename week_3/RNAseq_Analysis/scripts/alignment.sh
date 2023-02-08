#!/bin/bash

#SBATCH --job-name=RNAseq_Alignment 
#SBATCH -A ecoevo283
#SBATCH -p standard
#SBATCH --cpus-per-task=2
#SBATCH --ntasks=1
#SBATCH --array=1-384

# load the right program - here, for the RNAseq aligner, I am going to use the hisat2

module load python/3.10.2
module load hisat2/2.2.1
module load samtools/1.15.1

file="/pub/sungjub/ee283/week_3/RNAseq_Analysis/scripts/prefixes.txt"

pathToRawData="/pub/sungjub/ee283/rawdata/RNAseq" 

pathToOutput="/pub/sungjub/ee283/week_3/RNAseq_Analysis/results"

prefix=`head -n $SLURM_ARRAY_TASK_ID $file | tail -n 1`

cd /pub/sungjub/ee283/week_3/RNAseq_Analysis/reference

hisat2 -p 2 -x dm6_trans -1 $pathToRawData/${prefix}_R1_001.fastq.gz -2 $pathToRawData/${prefix}_R2_001.fastq.gz |\
samtools view -bS - > $pathToOutput/${prefix}.bam

samtools sort $pathToOutput/${prefix}.bam -o $pathToOutput/${prefix}.sort.bam

samtools index $pathToOutput/${prefix}.sort.bam.sorted.bam
