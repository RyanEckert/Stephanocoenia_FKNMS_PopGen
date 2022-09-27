#!/bin/bash

fastq="false"

while getopts o:e:q flag
do
    case "${flag}" in
        o) output=${OPTARG};;
        e) extension=${OPTARG};;
	q) fastq='true';;
    esac
done

ls *$extension | cut -d '.' -f 1 >count1

>count2

if [ "$fastq" = "false" ]; then
for file in *$extension; do
cat $file | wc -l | xargs -n 1 bash -c 'echo $(($1 / 4))' args >>count2;
done
else
for file in *$extension; do
grep ">" $file | wc -l >>count2;
done
fi

paste <(awk -F' ' '{print $1}' count1) <(awk -F' ' '{print $1}' count2) >$output'ReadCounts'
rm count1 count2
