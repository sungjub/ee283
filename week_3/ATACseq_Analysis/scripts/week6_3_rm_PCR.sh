#!/bin/bash

#SBATCH --job-name=ecoevo283_ATACseq_rm.PCR
#SBATCH -A ecoevo283
#SBATCH -p standard
#SBATCH --cpus-per-task=2
#SBATCH --ntasks=1
#SBATCH --array=1-24

# Load the programs:

module load java/1.8.0
module load picard-tools/2.27.1
module load samtools/1.15.1

# directory variables
pathToData="/pub/sungjub/ee283/week_3/ATACseq_Analysis/results"
pathToOutput="/pub/sungjub/ee283/week_3/ATACseq_Analysis/results/post_alignment"

# making "prefix" variable for the array job
file="/pub/sungjub/ee283/week_3/ATACseq_Analysis/scripts/prefixes.txt"
prefix=`head -n $SLURM_ARRAY_TASK_ID $file | tail -n 1`

# change the directory where .bam files are located
cd /pub/sungjub/ee283/week_3/ATACseq_Analysis/results

java -jar /opt/apps/picard-tools/2.27.1/picard.jar MarkDuplicates REMOVE_DUPLICATES=true \
I=${prefix}.sort_filtered.bam \
O=$pathToOutput/${prefix}_dedup.bam \
M=$pathToOutput/${prefix}_marked_dup_metrics.txt


