#!/bin/bash

#SBATCH --job-name=juicer_parakeet
#SBATCH --partition=basic
#SBATCH --cpus-per-task=1
#SBATCH --mem=7800
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=canu-%j.out
#SBATCH --error=canu-%j.err

module load juicer bwa

spe=$1

/apps/python2/2.7.14/bin/python  /scratch/luohao/app/juicer/generate_site_positions.py MboI  $spe.fa $spe.fa

bwa index $spe.fa
cd /scratch2/parakeet_falcon/hic.v2/
cp $spe.fa* $TMPDIR
cd -

samtools faidx $spe.fa; cut -f 1,2 $spe.fa.fai > $spe.fa.sizes

juicer.sh -t 32 -g $spe -s MboI  -D /apps/juicer/1.7.6 -y $spe.fa_MboI.txt  -z $TMPDIR/$spe.fa -p $spe.fa.sizes
