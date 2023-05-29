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
txtFiles=$(ls -R "$directoryName" | grep -E "\.txt")
echo ""
echo "Printing files.txt.."
echo "$txtFiles"
echo ""
echo "Printing files with their path.."
abspathFiles=$(find "$directoryName" -type f | grep -E "\.txt$")
echo "$abspathFiles"
IFS=$'\n' read -rd '' -a files <<< "$abspathFiles"

# Loop through each file in the file list
for file in "${files[@]}"; do
    # Perform the desired operation on each file
    echo "Processing file: $file"

    # Example operation: Read the contents of the file
    contents=$(cat "$file")
    echo "File contents:"
    echo "$contents"

    # Count the number of lines in the file
    lineCount=$(wc -l < "$file")
    echo "Line count: $lineCount"

    echo "--------------------"
done
