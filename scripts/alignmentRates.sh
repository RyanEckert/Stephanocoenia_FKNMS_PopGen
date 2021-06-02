#!/bin/bash
TYPE=${1?Error: no file extension given}

>alignmentRates
for F in `ls *$TYPE`; do 
M=`grep -E '^[ATGCN]+$' $F | wc -l | grep -f - maps.e* -A 4 | tail -1 | perl -pe 's/maps\.e\d+-|% overall alignment rate//g'` ;
echo "$F.sam $M">>alignmentRates;
done
