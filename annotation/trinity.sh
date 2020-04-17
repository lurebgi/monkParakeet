#!/bin/bash

#SBATCH --job-name=Trinity
#SBATCH --partition=himem
#SBATCH --cpus-per-task=16
#SBATCH --mem=500000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=nucmer-%j.out
#SBATCH --error=nucmer-%j.err

module unload python2
module unload java
module load trinityrnaseq
#source activate anaCogent5.2
sample=$1



Trinity --workdir $TMPDIR/trinity --max_memory 500G --seqType fq  --output $TMPDIR/$sample.trinity2.out  --CPU 32 --verbose  --min_glue 10 \
 --path_reinforcement_distance 30   --samples_file sample.list --min_contig_length 400  \
 --trimmomatic  --no_bowtie

mv $TMPDIR/$sample.trinity2.out/*.fasta $sample.Trinity.2.fasta
