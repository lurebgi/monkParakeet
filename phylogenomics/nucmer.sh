ref0=$1
spe=$2
ref=$(echo ${ref0##*/})

/apps/mummer/4.0.0.beta2/bin/nucmer -l 50 -b 400  -t 8 $ref0  $spe -p ${ref}-$spe

/apps/mummer/4.0.0.beta2/bin/delta-filter -1 -l 400 ${ref}-$spe.delta > ${ref}-$spe.delta.filt 

/apps/mummer/4.0.0.beta2/bin/show-coords -H -c -l -o -r -T ${ref}-$spe.delta.filt > ${ref}-$spe.delta.filt.coords

