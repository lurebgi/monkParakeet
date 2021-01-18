/scratch/LiuJing/Luohao/HiC/parakeet_HiC/scripts/juicer.sh -g parakeet -s MboI -d /scratch/LiuJing/Luohao/HiC/parakeet_HiC/HiCReads -p /scratch/LiuJing/Luohao/HiC/parakeet_HiC/references/parakeet.fa.chrom.sizes -y /scratch/LiuJing/Luohao/HiC/parakeet_HiC/restriction_sites/parakeet_MboI.txt -z /scratch/LiuJing/Luohao/HiC/parakeet_HiC/references/parakeet.fa -D /scratch/LiuJing/Luohao/HiC/parakeet_HiC -r -t 16

java -jar /scratch/luohao/software/3d-dna/visualize/juicebox_tools.jar pre merged_nodups.txt $chr.hic size -d true -f /scratch/LiuJing/Luohao/HiC/parakeet_HiC/restriction_sites/parakeet_MboI.txt -c $chr
java -jar /scratch/luohao/software/3d-dna/visualize/juicebox_tools.jar dump observed KR $chr.hic $chr $chr BP 100000 $chr.hic.100k
