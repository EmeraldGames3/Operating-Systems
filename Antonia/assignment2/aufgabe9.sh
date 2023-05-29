#!/bin/bash
if [ $# -lt 1 ]
then
	echo "Not enough arguments"
	exit 1
fi
fileName=$1
if [[ ! -f "$fileName" ]]
then
        echo "Not a file.."
        exit 1
fi

if [[ $fileName != *".csv" ]]
then
	echo "Not a csv file.."
	exit 1
fi
sum=0
outContent=($(grep -E "OUT" "$fileName" | grep -o "[0-9]*"))
for value in "${outContent[@]}"; do
	sum=$((sum + value))
done
sum2=0
inContent=($(grep -E "IN" "$fileName" | grep -o "[0-9]*"))
for value in "${inContent[@]}"; do
        sum2=$((sum2 + value))
done
echo "IN amount: $sum2"
echo "OUT amount: $sum"
left=$((sum2 - sum))
echo "Money left: $left"
