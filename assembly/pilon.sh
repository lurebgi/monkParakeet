#!/bin/bash

#SBATCH --job-name=pilon
#SBATCH --partition=himem
#SBATCH --cpus-per-task=40
#SBATCH --mem=505000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=depth-%j.out
#SBATCH --error=depth-%j.err

module load pilon bwa

genome=arrow.v2.fa
size=frag
#bam=bj.FINAL.fasta.bj_hap.sorted.bam

cp $genome $TMPDIR/$genome.fa

#bwa index $TMPDIR/$genome.fa
#bwa mem -t 20  $TMPDIR/$genome.fa /proj/luohao/parakeet/data/illumina/YW2_R1.fq.gz /proj/luohao/parakeet/data/illumina/YW2_R2.fq.gz  |  samtools sort -@ 20 -O BAM -o $TMPDIR/$genome.$size.sorted.bam  -
#samtools index $TMPDIR/$genome.$size.sorted.bam 
#mv $TMPDIR/$genome.$size.sorted.bam $TMPDIR/$genome.$size.sorted.bam.bai .

#java -Xmx358G  -jar /apps/pilon/1.22/pilon-1.22.jar  --genome $TMPDIR/$genome --frags $TMPDIR/$genome.$size.sorted.bam --output bj.v1 --changes --threads 20 --minmq 30 --mindepth 30
#java -Xmx358G  -jar /apps/pilon/1.22/pilon-1.22.jar  --genome $TMPDIR/$genome --frags $TMPDIR/$genome.$size.sorted.bam --output bb_canu.pilon1 --changes --threads 16 --minmq 30 --mindepth 30
java -Xmx600G  -jar /apps/pilon/1.22/pilon-1.22.jar  --genome $TMPDIR/$genome.fa --frags $genome.$size.sorted.bam --output $genome.pilon1 --changes --threads 40 --minmq 30 --mindepth 20 --fix bases --diploid
#java -Xmx358G  -jar /apps/pilon/1.22/pilon-1.22.jar  --genome $TMPDIR/$genome.fa --frags $TMPDIR/$genome.$size.sorted.bam --output $genome.pilon3 --changes --threads 40 --minmq 30 --mindepth 30

