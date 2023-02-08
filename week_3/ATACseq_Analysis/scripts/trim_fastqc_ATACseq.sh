#!/bin/bash

#SBATCH --job-name=trimmomatic_fastqc 
#SBATCH -A ecoevo283
#SBATCH -p standard
#SBATCH --cpus-per-task=2

# loading the probrams first 

SourceDir="/pub/sungjub/ee283/rawdata/ATACseq/"
DestDir="/pub/sungjub/ee283/week_3/ATACseq_Analysis/QC_trim/"

for i in {004..060}
do
	Read1="${SourceDir}/P${i}_*_R1.fq.gz"
	Read2="${SourceDir}/P${i}_*_R2.fq.gz"
	Read1_trim="${DestDir}/P${i}_*_R1_trimmed.fq.gz"
	Read2_trim="${DestDir}/P${i}_*_R2_trimmed.fq.gz"

	# Run Trimmomatic

	java -jar /opt/apps/trimmomatic/0.39/trimmomatic-0.39.jar PE\
	-threads 2 -phred33 "$Read1" "$Read2"\
	"$Read1_trim" "${Read1_trim%.fq.gz}_unpaired.fq.gz"\
	"$Read2_trim" "${Read2_trim%.fq.gz}_unpaired.fq.gz"\
	ILLUMINACLIP:/opt/apps/trimmomatic/0.39/adapters/TruSeq3-PE.fa:2:30:10\
	SLIDEWINDOW:4:15 LEADING:3 TRAILING:3 MINLEN:36

	# Run fastqc

	fastqc -o "$DestDir" "$Read1_trim" "$Read2_trim"

done

echo "Trimmomatic and FASTQC Jobs Completed"
