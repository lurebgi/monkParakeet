bwa index monk.fa
cp monk.fa* $TMPDIR/
mkdir mapping/
bwa mem -A 1 -B 4 -E 50 -L 0 -t 16 $TMPDIR/monk.fa /proj/luohao/parakeet/data/hic/YW18_R1.fq.gz | samtools view -Shb - > $TMPDIR/hic.R1.bam
bwa mem -A 1 -B 4 -E 50 -L 0 -t 8 $TMPDIR/monk.fa /proj/luohao/parakeet/data/hic/YW18_R2.fq.gz | samtools view -Shb - > $TMPDIR/hic.R2.bam

findRestSite --fasta $TMPDIR/monk.fa  --searchPattern GATC -o monk.rest_site_positions.bed

Build Hi-C matrix
mkdir hicMatrix/
hicBuildMatrix --samFiles mapping/hic.R1.bam mapping/hic.R2.bam --binSize 10000 --restrictionSequence GATC  --outFileName hicMatrix/10kb.sub.h5 --QCfolder hicMatrix/10kb_QC.sub --threads 8 --inputBufferSize 400000

hicMergeMatrixBins --matrix hicMatrix/10kb.corrected.h5 --numBins 25 --outFileName hicMatrix/250kb.corrected.h5

hicFindTADs --matrix hicMatrix/250kb.corrected.h5 --minDepth 1000000 --maxDepth 2000000 --numberOfProcessors 4 --step 250000 --thresholdComparisons 0.05 --outPrefix TADs/250Kb.TADs --correctForMultipleTesting fdr
