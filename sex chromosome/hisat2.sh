mkdir index; hisat2-build monk.2003.fa index/monk.fa
cp index/monk.fa* $TMPDIR

sample=$(sed -n ${SLURM_ARRAY_TASK_ID}p sample.list)

hisat2 -x $TMPDIR/monk.fa -p 4 -1 /proj/luohao/parakeet/data/RNA-seq/link/${sample}_R1.fq.gz -2 /proj/luohao/parakeet/data/RNA-seq/link/${sample}_R2.fq.gz  -S $TMPDIR/monk.sam -k 4 --max-intronlen 100000 --min-intronlen 30

samtools sort $TMPDIR/monk.sam   -@ 4 -O BAM -o $TMPDIR/$sample.bam

mv $TMPDIR/$sample.bam .
samtools index -@ 4  $sample.bam
