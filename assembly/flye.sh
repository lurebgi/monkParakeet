#!/bin/bash

#SBATCH --job-name=flye
#SBATCH --partition=basic,himem
#SBATCH --cpus-per-task=16
#SBATCH --mem=15000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=flye-%j.out
#SBATCH --error=flye-%j.err

module load flye

read=$1
size=$2
chr=$3

flye --pacbio-raw $read --genome-size $size --out-dir $chr.out --threads 20
