#!/bin/bash

# Check if there are enough arguments
if [ $# -lt 1 ]; then
    echo "Not enough arguments."
    echo "Usage: $0 <directory1> <directory2> ..."
    exit 1
fi

# Store the directory names
directories=("$@")

# Iterate over the directories
for directory in "${directories[@]}"; do
    # Check if the directory exists
    if [ -d "$directory" ]; then
        # Search for files within the directory
        files=$(find "$directory" -type f)
	echo "Directory: $directory"
        echo "Files: $files"
	for file in "${files[@]}"; do
	    if grep -q -E "\W" "$file"; then
		echo "Binary file: $file"
	    fi
	done
    fi
done

