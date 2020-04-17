#!/bin/bash

#SBATCH --job-name=minimap2
#SBATCH --partition=basic,himem
#SBATCH --cpus-per-task=8
#SBATCH --mem=50000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=depth-%j.out
#SBATCH --error=depth-%j.err

#module load pilon bwa samtools pbsmrt
source activate /scratch/luohao/software/pacbio

line=$1
genome=curated.add-40k.Z-haplotig-w.fa
#genome=arrow.v2.fa.pilon1.add-w.fasta
#genome=arrow.v2.fa.pilon1.add-w2.fasta
#dataset create --type SubreadSet subread.xml /proj/luohao/parakeet/data/*.subreads.bam

pbmm2 index $genome $genome.mmi
cp $genome $TMPDIR
minimap2 -x map-pb --secondary=no  -t 8 $TMPDIR/$genome <(samtools view $line | awk 'length($10)>6000{print ">"$1"\n"$10}') | awk '$11>3000' > $TMPDIR/`basename $line`.pdf
mv $TMPDIR/`basename $line`.pdf .

#ls *bam.pdf | grep -v m54297_190228_071006.subreads.bam.pdf | while read line; do cat $line | awk '$2>3000{print $1"\t"$4-$3"\t"$6}' | sort -k1,1 -k2,2nr | awk '!a[$1]++' | sed 's/|arrow.*//' | awk 'BEGIN{while(getline < "z.list"){b[$1]=3}; while(getline < "z.falcon/z.out/blacklist.list"){bl[$2]=3}}{if(b[$3]==3 && bl[$1]!=3){print $1}}' > $line.read-ID; done
#cat *read-ID | awk 'BEGIN{while(getline < "z.falcon/z.out/blacklist.list"){a[$2]=3}}{if(a[$1]==3){print }}' | wc -l

#samtools view /proj/luohao/parakeet/data/$line | awk 'BEGIN{while(getline < "'$line'.pdf.read-ID"){a[$1]=3}}{if(a[$1]==3){print ">"$1"\n"$10}}' > $TMPDIR/$line.pdf.read-ID.fa; mv $TMPDIR/$line.pdf.read-ID.fa .
#mv $TMPDIR/zw.fa.fai.readID.fa .
