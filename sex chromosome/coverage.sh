genome0=$1
read1=$2
read2=$3
size=$4
cpu=16

genome=$(echo ${genome0##*/})

## preparation for the reference
samtools faidx $genome0.fa

mkdir index
# alignment
if [ ! -f index/${genome}.bwt ] ; then
bwa index $genome0 -p index/$genome
fi
cp index/$genome* $TMPDIR

bwa mem -t $cpu -R $(echo "@RG\tID:$size\tSM:$size\tLB:$size"_"$size\tPL:ILLUMINA")   $TMPDIR/$genome $read1 $read2  |  samtools sort -@ $cpu -O BAM -o $TMPDIR/$genome.$size.sorted.bam  -
samtools index -@ $cpu $TMPDIR/$genome.$size.sorted.bam
mv $TMPDIR/$genome.$size.sorted.bam $TMPDIR/$genome.$size.sorted.bam.bai .


#java -Xmx108g -jar /apps/picard/2.21.4/picard.jar  MarkDuplicates I=$genome.$size.sorted.bam O=$TMPDIR/$genome.$size.dedup.bam M=$size.m
#samtools index -@ $cpu  $TMPDIR/$genome.$size.dedup.bam
#mv $TMPDIR/$genome.$size.dedup.bam $TMPDIR/$genome.$size.dedup.bam.bai .

cut -f 1,2 $genome0.fai > $genome0.fai.g
bedtools makewindows -g $genome0.fai.g -w 50000 > $genome0.fai.g.50k

samtools depth -m 100 -Q 60  $genome.$size.dedup.bam  | awk '{print $1"\t"$2-1"\t"$2"\t"$3}'  | bedtools map -a $genome0.fai.g.50k  -b - -c 4 -o median,mean,count  > $genome.$size.dedup.bam.cov-50k
