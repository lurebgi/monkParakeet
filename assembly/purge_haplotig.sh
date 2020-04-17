#!/bin/bash

#SBATCH --job-name=purge_haplotig
#SBATCH --partition=himem,basic
#SBATCH --cpus-per-task=20
#SBATCH --mem=19000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=canu-%j.out
#SBATCH --error=canu-%j.err

#source activate /scratch/luohao/software/pacbio/
#export PATH=/scratch/luohao/software/pacbio/bin/:$PATH
#source activate /scratch/luohao/software/purge_haplotigs
cpu=20

cp 2-asm-falcon/p_ctg.fa $TMPDIR

/scratch/luohao/software/pacbio/bin/minimap2  -t $cpu -x map-pb -a  $TMPDIR/p_ctg.fa <(cat /proj/luohao/parakeet/data/*.subreads.bam.fa.fasta)   | samtools view -hF 256 - |  samtools sort -m 2G -@ $cpu  -O BAM -o $TMPDIR/contigs.fasta.bam
#samtools index $TMPDIR/contigs.fasta.bam

mv $TMPDIR/contigs.fasta.bam $TMPDIR/contigs.fasta.bam.bai .
/apps/perl/5.28.0/bin/perl /scratch/luohao/software/purge_haplotigs/bin/purge_haplotigs   readhist  -b contigs.fasta.bam -g 2-asm-falcon/p_ctg.fa  -t $cpu

xvfb-run /apps/perl/5.28.0/bin/perl /scratch/luohao/software/purge_haplotigs/bin/purge_haplotigs contigcov  -i  contigs.fasta.bam.gencov -l 10 -m 35 -h 130 -o coverage_stats.csv -j 80  -s 80

/apps/perl/5.28.0/bin/perl /scratch/luohao/software/purge_haplotigs/bin/purge_haplotigs purge  -g 2-asm-falcon/p_ctg.fa  -c coverage_stats.csv -t $cpu -d -b contigs.fasta.bam -a 60 -limit_io 8 -wind_min 10000
