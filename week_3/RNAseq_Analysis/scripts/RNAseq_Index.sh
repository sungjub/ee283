#!/bin/bash

#SBATCH --job-name=RNAseq_Index
#SBATCH -A ecoevo283
#SBATCH -p standard
#SBATCH --cpus-per-task=8
#SBATCH --ntasks=1

module load python/3.10.2
module load hisat2/2.2.1

cd /pub/sungjub/ee283/week_3/RNAseq_Analysis/reference 

ref="/pub/sungjub/ee283/week_3/RNAseq_Analysis/reference/dmel-all-chromosome-r6.13.fasta" 
gtf="/pub/sungjub/ee283/week_3/RNAseq_Analysis/reference/dmel-all-r6.13.gtf" 

hisat2_extract_splice_sites.py $gtf > dm6.ss 
hisat2_extract_exons.py $gtf > dm6.exon
hisat2-build -p 8 --exon dm6.exon --ss dm6.ss $ref dm6_trans
