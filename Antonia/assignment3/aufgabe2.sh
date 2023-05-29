#!/bin/bash
if [ $# -lt 1 ]; then
   echo "Not enough arguments"
   exit 1
fi
files=($@)
for file in "${files[@]}"; do
    echo "Filename: $file"
    echo "File content"
    tac "$file"
    echo ""
done
