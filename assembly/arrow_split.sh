#!/bin/bash

#SBATCH --job-name=arrow
#SBATCH --partition=basic
#SBATCH --cpus-per-task=8
#SBATCH --mem=18000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=depth-%j.out
#SBATCH --error=depth-%j.err
#SBATCH --constraint=array-8core
#SBATCH --nice=5000

#module load pilon bwa samtools pbsmrt
source activate /scratch/luohao/software/pacbio

genome=curated.add-40k.Z-haplotig.fa
#genome=arrow.filt.fa
samtools faidx $genome
#rsync  $genome $genome.fai $TMPDIR

## split genome to speed up arrow polishing
mkdir fa_split
cat $genome.fai | sort -k2R | split -l 20 - fa_split/

ls fa_split | grep -v fa | while read line; do

samtools index $genome.merged.bam
line=$(sed -n ${SLURM_ARRAY_TASK_ID}p fa.list)


cat fa_split/$line | cut -f 1 |  seqkit grep -f - $genome > $TMPDIR/$line.fa; samtools faidx $TMPDIR/$line.fa
cat fa_split/$line | awk '{printf "\x27"$1"\x27 "  }' | sed "s#^#samtools view -h $genome.merged.bam #"  | awk  '{print $0" -O BAM -o '$TMPDIR'/'$line'.bam" }' | sh
samtools index $TMPDIR/$line.bam
pbindex $TMPDIR/$line.bam
samtools faidx $TMPDIR/$line.fa
arrow -j32 $TMPDIR/$line.bam  -r $TMPDIR/$line.fa  -o fa_split/$line.arrow.fasta -o fa_split/$line.variants.gff;
mv $TMPDIR/$line.arrow.fa fa_split/
#done
