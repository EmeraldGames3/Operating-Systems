#!/bin/bash

if [ $# -lt 1 ]
then
	echo "Not enough arguments"
	exit 1
fi
directoryName=$1
if [ ! -d "$directoryName" ]
then
	echo "Not a directory"
	exit 1
fi
filesC=($(find "$directoryName" -type f -name "*.c"))
for file in "${filesC[@]}";do
	count=$(grep --count "#define" "$file")
	if [ $count -ne 0 ]
	then
		echo "$file"
	fi
done
