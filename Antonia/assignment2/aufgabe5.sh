#!/bin/bash

if [ $# -lt 1 ]
then
     echo "Not enough argumnets.."
     exit 1
fi

directoryName=$1

if [ ! -d "$directoryName" ]
then
    echo "Not a directory"
    exit 1
fi
filesC=($(find "$directoryName" -type f -name "*.c"))
for file in "${filesC[@]}"; do
    count=$(grep --count "#include" "$file")
    echo "File $file contains: $count libraries"
done
