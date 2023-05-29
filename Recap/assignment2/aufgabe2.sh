#!/bin/bash

if [ $# -lt 2 ]
then
    echo "Not enough argmunets.."
    exit 1
fi
# Store the word (last argument)
word=${!#}

# Store the filenames (excluding the last argument)
fileArray=("${@:1:$#-1}")

echo "Word"
echo "$word"
echo ""
count=0
for filename in "${fileArray[@]}"; do
    if grep -q "$word" "$filename"; then
       count=$(($count+1))
       echo "Word '$word' found in file: $filename"
    fi
done
echo "Number of files: $count"
