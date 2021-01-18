ref=$1
query=$2

perl /home/user/liu/Software/synPlot/genomeSynPlot.pl -r $ref.fa -q $query.fa -m 2.1 -p $ref.$query -t 4
