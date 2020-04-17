#!/bin/bash

#SBATCH --job-name=pbmm
#SBATCH --partition=himem
#SBATCH --cpus-per-task=30
#SBATCH --mem=50000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=depth-%j.out
#SBATCH --error=depth-%j.err

#module load pilon bwa samtools pbsmrt
source activate /scratch/luohao/software/pacbio

genome=$1
genome=curated.add-40k.Z-haplotig-w.fa
#genome=arrow.v2.fa.pilon1.add-w.fasta
dataset create --type SubreadSet subread.xml /proj/luohao/parakeet/data/*.subreads.bam

pbmm2 index $genome $genome.mmi

cp $genome $TMPDIR

#cat bam.list | while read line; do  pbmm2 align /proj/luohao/amphioxus/data/pacbio_bj/$line  $TMPDIR/$genome.mmi -j 20 --min-length 1000 | samtools sort -@ 20 -O BAM -o $TMPDIR/$line.bam; done
pbmm2 align $TMPDIR/$genome subread.xml   $TMPDIR/$genome.merged.bam --sort -j 30 -J 10


pbindex $TMPDIR/$genome.merged.bam
mv $TMPDIR/$genome.merged.bam  .
samtools index $genome.merged.bam
