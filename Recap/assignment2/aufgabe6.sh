#!/bin/bash

if [ $# -lt 2 ]
then
	echo "Not enough arguments"
	exit
fi
# Store the word (last argument)
fileName=${!#}

# Store the filenames (excluding the last argument)
dirArray=("${@:1:$#-1}")
fileContent=$(cat "$fileName")
echo "File content: "
echo "$fileContent"
echo ""
for directory in "${dirArray[@]}"; do
	files=($(find "$directory" -type f))
	echo "Directory: $directory"
	echo "Files: "
	for file in "${files[@]}"; do
		filename=$(basename "$file")
    		echo "File: $file Basename: $filename"
		word=$filename
		count=$(grep --count "$word" "$fileName")
		if [ $count -ne 0 ]
		then
		     echo "File will be removed.."
		     rm "$file"
		fi
		echo ""
	done
done
