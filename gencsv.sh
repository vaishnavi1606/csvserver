#!/bin/bash

#rm inputFile

if [ -z "$@" ]
 then
    count=9
 else
    count=`expr $@ - 1`
fi

for i in $(seq 0 $count);
do
        echo "$i,$RANDOM" >> inputFile
done
chmod 664 inputFile
