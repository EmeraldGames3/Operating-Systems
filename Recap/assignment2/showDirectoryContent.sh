#!/bin/bash

if [ $# -lt 1 ]
then
    echo "Not enough arguments.."
    exit 1
fi

directoryName=$1

if [ ! -d "$directoryName" ]; then
    echo "The specified directory does not exist."
    exit 1
fi

echo "Directory name: $directoryName"
echo "Content:"
ls -R $directoryName
echo ""
echo "Find all files: "
# Find all files in the given directory recursively and store the output in a variable
fileList=$(find "$directoryName" -type f)

IFS=$'\n' read -rd '' -a files <<< "$fileList"

# Loop through each file in the file list
for file in "${files[@]}"; do
    # Perform the desired operation on each file
    echo "Processing file: $file"

    # Example operation: Read the contents of the file
    contents=$(cat "$file")
    wordCount=$(wc -w < "$file")
    linesCount=$(wc -l < "$file")
    echo "Lines count: $linesCount"
    echo "Word count: $wordCount"
    echo "File contents:"
    echo "$contents"
    echo "--------------------"
done
