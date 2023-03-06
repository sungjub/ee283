#!/bin/bash

#SBATCH --job-name=EE283_RNAseq_featureCount
#SBATCH -A ecoevo283
#SBATCH -p standard
#SBATCH --cpus-per-task=8

# load the program:
module load subread/2.0.3

# the gtf should match the genome you aligned to
# coordinates and chromosome names

# making a gtf variable

gtf="/pub/sungjub/ee283/week_3/RNAseq_Analysis/reference/dmel-all-r6.13.gtf"

# the program expects a space delimited set of files...

bam_file="/pub/sungjub/ee283/week_3/RNAseq_Analysis/scripts/shortRNAseq.names.txt"
myfile=`cat shortRNAseq.names.txt | tr "\n" " "`

# change directory where the specific bam files are located

cd /pub/sungjub/ee283/week_3/RNAseq_Analysis/results

# perform featureCounts function

featureCounts -p -t exon -g gene_id -Q 30 -F GTF -a $gtf -o ./week7_hw/fly_counts.txt $myfile
