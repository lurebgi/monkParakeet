#!/bin/bash

#SBATCH --job-name=bwa_parakeet
#SBATCH --partition=basic,himem
#SBATCH --cpus-per-task=1
#SBATCH --mem=11000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=depth-%j.out
#SBATCH --error=depth-%j.err

module load bwa bamtools
genome0=$1
read1=$2
read2=$3
size=$4
cpu=8

genome=$(echo ${genome0##*/})
#cp $genome0 .

if [ ! -f ${genome0}.bwt ] ; then
bwa index $genome0 #-p $genome
fi


cp ${genome0}.bwt ${genome0}.pac ${genome0}.ann ${genome0}.amb ${genome0}.sa ${genome0}  $TMPDIR
bwa mem -t $cpu  $TMPDIR/$genome $read1 $read2  |  samtools sort -@ $cpu  -O BAM -o $TMPDIR/$genome.$size.sorted.bam  -
mv $TMPDIR/$genome.$size.sorted.bam .


#samtools faidx $genome
#50k
#cut -f 1,2 $genome0.fai > $genome.fai.g
#bedtools makewindows -g $genome0.fai -w 50000 > $genome.scf-len.50k-win
samtools view -h $genome.$size.sorted.bam |  awk '$1~/@/ || $0~/NM:i:0/ || $0~/NM:i:1/'  | samtools depth -Q 10 - |  awk '{print $1"\t"$2-1"\t"$2"\t"$3}' |   bedtools map -a  $genome.scf-len.50k-win -b - -c 4 -o median,mean,count -g $genome.fai.g  > $genome.$size.sorted.bam.depth.bed.50k-win.NM1-Q10
