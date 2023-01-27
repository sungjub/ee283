#!/bin/bash 
#SBATCH --job-name=ecoevo283_RNAseq_symlink    ## Name of the job. 
#SBATCH -A ecoevo283       ## account to charge 
#SBATCH -p standard        ## partition/queue name
#SBATCH --cpus-per-task=1  ## number of cores the job needs

SourceDir="/data/class/ecoevo283/public/RAWDATA/RNAseq/RNAseq384plex_flowcell01/"
FILES="$SourceDir/*"

for f in FILES
do
	echo "Processing $f..."
	Link=$(find ${f} -name "*.fastq.gz")
	echo "Symlink for ${Link} will be created in $(pwd)"
	ln -s ${Link} ./
done

