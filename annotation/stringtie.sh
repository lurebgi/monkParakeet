#!/bin/bash

#SBATCH --job-name=stringtie_YY
#SBATCH --partition=basic
#SBATCH --cpus-per-task=16
#SBATCH --mem=68000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=hisat2-%j.out
#SBATCH --error=hisat2-%j.err

module load stringtie

stringtie monk.sort.bam   -o monk.gtf -p 16  -m 300  -a 12 -j 5 -c 10
