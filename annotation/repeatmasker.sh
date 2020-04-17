#!/bin/bash

#SBATCH --job-name=repMask
#SBATCH --partition=basic
#SBATCH --cpus-per-task=8
#SBATCH --mem=3000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=nucmer-%j.out
#SBATCH --error=nucmer-%j.err


module unload repeatmasker
module load repeatmasker/4.0.7
module load ncbiblastplus

spe=$1
lib=$2

mkdir ${lib}_RM_output_dir

cp $spe.fa $TMPDIR

RepeatMasker -pa 16 -a -xsmall -gccalc -dir ${lib}_RM_output_dir -lib $lib  $TMPDIR/$spe.fa
