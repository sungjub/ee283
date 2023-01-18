#!/bin/bash

#SBATCH --job-name=homework_1 ## Name of the job 
#SBATCH -A ecoevo283 ## account to charge 
#SBATCH -p standard ## partition/queu names
#SBATCH --nodes=1 ## (-N) number of nodes to use 
#SBATCH --ntasks=1 ## (-n) number of tasks to lanuch 
#SBATCH --cpus-per-task=1 ## number of cores the job needs

# download the file
wget https://wfitch.bio.uci.edu/~tdlong/problem1.tar.gz

# uncompress the file
tar -xvf problem1.tar.gz

# show the 10th line of each file
 head -10 problem1/p.txt | tail -1
 head -10 problem1/f.txt | tail -1
