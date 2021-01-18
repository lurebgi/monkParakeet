bam=$1
sample=$(sed -n ${SLURM_ARRAY_TASK_ID}p sample.list)
/apps/subread/1.6.2/bin/featureCounts -C --tmpDir $TMPDIR  -F GTF -p  -a monk.2003.gtf  -T 1 -o $sample.bam.count $sample.bam
