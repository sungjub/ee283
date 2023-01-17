#!/bin/bash

#SBATCH --job-name=test# Name of the job 
#SBATCH -A ecoevo283 ## account to charge
#SBATCH -p standard ## partition/queu name (standard, free..)
#SBATCH --nodes=1 ## (-N) number of nodes to use
#SBATCH --ntasks=1 ## (-n) number of tasks to lanuch
#SBATCH --cpus-per-task=1 ## number of cores the job needs

echo "hello world"
sleep 2m # wait 2 minutes 
