#!/bin/bash

#SBATCH --job-name=3d-dna
#SBATCH --partition=basic
#SBATCH --cpus-per-task=1
#SBATCH --mem=36800
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=canu-%j.out
#SBATCH --error=canu-%j.err

module load juicer bwa lastz

ln -s aligned/merged_nodups.txt .

/scratch/luohao/software/3d-dna/run-asm-pipeline.sh   --editor-coarse-resolution 500000 --editor-coarse-region 1000000 --editor-saturation-centile 2 -r 1  aln_summary.tsv.merge2.fa   merged_nodups.txt

# assembly after review
#sh /scratch/luohao/software/3d-dna/run-asm-pipeline-post-review.sh -r new_ref.rawchrom.review.review.assembly   ../new_ref.fa  ../merged_nodups.txt
