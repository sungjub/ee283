#!/bin/bash

#SBATCH --job-name=DNAseq_Alignment 
#SBATCH -A ecoevo283
#SBATCH -p standard
#SBATCH --cpus-per-task=2
#SBATCH --ntasks=1
#SBATCH --array=1-12   ## number of tasks to launch (here we have 12 unique sample identification - 24 total)

ref="/pub/sungjub/ee283/week_3/DNAseq_Analysis/reference/dmel-all-chromosome-r6.13.fasta"
file="/pub/sungjub/ee283/week_3/DNAseq_Analysis/scripts/prefixes_2.txt"
prefix=`head -n $SLURM_ARRAY_TASK_ID $file | tail -n 1`
pathToRawData="/pub/sungjub/ee283/rawdata/DNAseq"
pathToOutput="/pub/sungjub/ee283/week_3/DNAseq_Analysis/results"

bwa mem -t 2 -M $ref $pathToRawData/${prefix}_1.fq.gz $pathToRawData/${prefix}_2.fq.gz | samtools view -bS - > $pathToOutput/${prefix}.bam

samtools sort $pathToOutput/${prefix}.bam -o $pathToOutput/${prefix}.sort.bam
