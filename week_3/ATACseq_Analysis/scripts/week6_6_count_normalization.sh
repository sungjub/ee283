# this is a step-by-step script to make "normalized" bigwig files from processed .bam files 

# grab resources
srun -c 2 -p standard --pty /bin/bash -i

# load modules
module load samtools/1.15.1
module load bedtools2/2.30.0 
module load ucsc-tools/v429

# change the directory
cd /pub/sungjub/ee283/week_3/DNAseq_Analysis/reference/dm6_ucsc

# create chromosome size file using ucsc-tools::fetchChromSizes function
fetchChromSizes dm6 > dm6.chrom.sizes

# count the total number of reads and create a scaling constant for each bam
ref="/pub/sungjub/ee283/week_3/DNAseq_Analysis/reference/dm6_ucsc/dm6.fa"
chromsizes="/pub/sungjub/ee283/week_3/DNAseq_Analysis/reference/dm6_ucsc/dm6.chrom.sizes"

# making Scale varaible
Scale=`echo "1.0/($Nreads/1000000)" | bc -l`

# making a coverage variable - this is for one specific .bam file
samtools view -b P004_A4_ED_2.true.sorted.bam | genomeCoverageBed -ibam - -g $ref -bg -scale $Scale > P004_A4_ED_2.true.sorted.coverage

# making a bigwig file - this is for one specific .bam file
bedGraphToBigWig P004_A4_ED_2.true.sorted.coverage $chromsizes P004_A4_ED_2.true.sorted.bw

