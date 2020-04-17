#!/bin/bash

#SBATCH --job-name=pasa.bb
#SBATCH --partition=basic
#SBATCH --cpus-per-task=1
#SBATCH --mem=18000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=depth-%j.out
#SBATCH --error=depth-%j.err
#SBATCH --nice=3000
#SBATCH --constraint=array-8core

module load sqlite3
module load gmap ucsc blat
export PATH=/scratch/luohao/software/fasta-36.3.8g/bin:$PATH

trinity=monk.Trinity.2.fasta
chr=$1
chr=$(sed -n ${SLURM_ARRAY_TASK_ID}p chr.list)
/scratch/luohao/software/PASApipeline.v2.4.1/bin/seqclean $trinity

/scratch/luohao/software/PASApipeline.v2.4.1/Launch_PASA_pipeline.pl -c alignAssembly.conf -C -R -g /proj/luohao/parakeet/assembly/monk.2001.fa  -t $trinity.clean  -T -u $trinity --trans_gtf ../hisat-stringtie/monk.gtf   --ALIGNERS gmap --CPU 6 --stringent_alignment_overlap 30 --PASACONF conf.txt --TRANSDECODER


cp monk.sqlite *.conf $TMPDIR
sed -i -e "s#/scratch/luohao/parakeet/annotation/PASA#$TMPDIR#"  $TMPDIR/alignAssembly.conf
sed -i -e "s#/scratch/luohao/parakeet/annotation/PASA#$TMPDIR#"  $TMPDIR/annotationCompare.conf

mkdir gff3_split/$chr.out
cd gff3_split/$chr.out

/scratch/luohao/software/PASApipeline.v2.4.1/scripts/Load_Current_Gene_Annotations.dbi -c $TMPDIR/alignAssembly.conf -g /proj/luohao/parakeet/assembly/monk.2001.fa  -P ../$chr.gff3

/scratch/luohao/software/PASApipeline.v2.4.1/Launch_PASA_pipeline.pl -c $TMPDIR/annotationCompare.conf -A -g /proj/luohao/parakeet/assembly/monk.2001.fa  -t  ../../$trinity.clean --CPU 1 --PASACONF ../../conf.txt  --stringent_alignment_overlap 30 --gene_overlap 50
