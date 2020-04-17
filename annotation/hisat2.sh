#!/bin/bash

#SBATCH --job-name=hisat2_monk
#SBATCH --partition=basic
#SBATCH --cpus-per-task=16
#SBATCH --mem=38000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=hisat2-%j.out
#SBATCH --error=hisat2-%j.err

module load hisat2

#hisat2-build monk.fa monk.fa

cp monk.fa* $TMPDIR

hisat2 -x $TMPDIR/monk.fa -p 16 -5 5 -3 5 -1 /proj/luohao/parakeet/data/RNA-seq/YY16_R1.fq.gz,/proj/luohao/parakeet/data/RNA-seq/YY19_R1.fq.gz,/proj/luohao/parakeet/data/RNA-seq/YY20_R1.fq.gz,/proj/luohao/parakeet/data/RNA-seq/YY22_R1.fq.gz,/proj/luohao/parakeet/data/RNA-seq/YY23_R1.fq.gz,/proj/luohao/parakeet/data/RNA-seq/YY24_R1.fq.gz,/proj/luohao/parakeet/data/RNA-seq/YY28_R1.fq.gz,/proj/luohao/parakeet/data/RNA-seq/YY32_R1.fq.gz,/proj/luohao/parakeet/data/RNA-seq/YY33_R1.fq.gz,/proj/luohao/parakeet/data/RNA-seq/ZYT189_R1.fq.gz,/proj/luohao/parakeet/data/RNA-seq/ZYT232_R1.fq.gz,/proj/luohao/parakeet/data/RNA-seq/ZYT235_R1.fq.gz,/proj/luohao/parakeet/data/RNA-seq/ZYT236_R1.fq.gz,/proj/luohao/parakeet/data/RNA-seq/ZYT238_R1.fq.gz,/proj/luohao/parakeet/data/RNA-seq/ZYT239_R1.fq.gz,/proj/luohao/parakeet/data/RNA-seq/ZYT240_R1.fq.gz,/proj/luohao/parakeet/data/RNA-seq/ZYT242_R1.fq.gz,/proj/luohao/parakeet/data/RNA-seq/ZYT244_R1.fq.gz,/proj/luohao/parakeet/data/RNA-seq/ZYT247_R1.fq.gz,/proj/luohao/parakeet/data/RNA-seq/ZYT248_R1.fq.gz -2 /proj/luohao/parakeet/data/RNA-seq/YY16_R2.fq.gz,/proj/luohao/parakeet/data/RNA-seq/YY19_R2.fq.gz,/proj/luohao/parakeet/data/RNA-seq/YY20_R2.fq.gz,/proj/luohao/parakeet/data/RNA-seq/YY22_R2.fq.gz,/proj/luohao/parakeet/data/RNA-seq/YY23_R2.fq.gz,/proj/luohao/parakeet/data/RNA-seq/YY24_R2.fq.gz,/proj/luohao/parakeet/data/RNA-seq/YY28_R2.fq.gz,/proj/luohao/parakeet/data/RNA-seq/YY32_R2.fq.gz,/proj/luohao/parakeet/data/RNA-seq/YY33_R2.fq.gz,/proj/luohao/parakeet/data/RNA-seq/ZYT189_R2.fq.gz,/proj/luohao/parakeet/data/RNA-seq/ZYT232_R2.fq.gz,/proj/luohao/parakeet/data/RNA-seq/ZYT235_R2.fq.gz,/proj/luohao/parakeet/data/RNA-seq/ZYT236_R2.fq.gz,/proj/luohao/parakeet/data/RNA-seq/ZYT238_R2.fq.gz,/proj/luohao/parakeet/data/RNA-seq/ZYT239_R2.fq.gz,/proj/luohao/parakeet/data/RNA-seq/ZYT240_R2.fq.gz,/proj/luohao/parakeet/data/RNA-seq/ZYT242_R2.fq.gz,/proj/luohao/parakeet/data/RNA-seq/ZYT244_R2.fq.gz,/proj/luohao/parakeet/data/RNA-seq/ZYT247_R2.fq.gz,/proj/luohao/parakeet/data/RNA-seq/ZYT248_R2.fq.gz  -S $TMPDIR/monk.sam -k 4 --max-intronlen 100000 --min-intronlen 30


samtools sort $TMPDIR/monk.sam   -@ 16 -O BAM -o $TMPDIR/monk.sort.bam

mv $TMPDIR/monk.sort.bam .
samtools index monk.sort.bam
 
