#!/bin/bash
#
#SBATCH --job-name=falcon
#SBATCH --cpus-per-task=1
#SBATCH --mem=5000
#SBATCH --partition=basic
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=raw.fc-%j.out
#SBATCH --error=raw.fc-%j.err

cfg=$1
#unzip=$2
#line=$1
module load  pbsmrt #mummer samtools minimap2
#source activate /scratch/luohao/software/pacbio

ls /proj/luohao/parakeet/data/*bam | while read line; do
/apps/pbsmrt/20171207/bin/bam2fasta -u $line -o $TMPDIR/`basename $line`.fa
mv $TMPDIR/`basename $line`.fa.fasta  /proj/luohao/parakeet/data/
done

module unload pbsmrt
source activate /scratch/luohao/software/pacbio
# falcon
fc_run.py $cfg
