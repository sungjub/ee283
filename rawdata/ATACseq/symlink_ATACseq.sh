#!/bin/bash

#SBATCH --job-name=ecoevo283_ATACseq__symlink    ## Name of the job. 
#SBATCH -A ecoevo283       ## account to charge 
#SBATCH -p standard        ## partition/queue 
#SBATCH --cpus-per-task=1  ## number of cores the job needs

SourceDir="/data/class/ecoevo283/public/RAWDATA/ATACseq/"
File="ATACseq.labels.txt"

while read p # now reading the variable File, each line by variable 'p'
do
	echo "${p}"
	barcode=$(echo $p | cut -f1 -d" ")
	genotype=$(echo $p | cut -f2 -d" ") 
	tissue=$(echo $p | cut -f3 -d" ") bioRep=$(echo $p | cut -f4 -d" ") 
	READ1=$(find ${SourceDir}/ -type f -iname "*_${barcode}_R1.fq.gz") 
	READ2=$(find ${SourceDir}/ -type f -iname "*_${barcode}_R2.fq.gz") 
	ln -s ${READ1} ${barcode}_${genotype}_${tissue}_${bioRep}_R1.fq.gz
	ln -s ${READ2} ${barcode}_${genotype}_${tissue}_${bioRep}_R2.fq.gz
done < $File

