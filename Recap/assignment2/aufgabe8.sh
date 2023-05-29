#!/bin/bash
if [ $# -lt 1 ]
then
	echo "Not enough arguments"
	exit 1
fi
arguments=($@)
shellScriptFiles=()
for file in "${arguments[@]}"; do
	if [ -f "$file" ]
	then
		fileType=$(file -b "$file")
		if [[ $fileType == *"shell script"* ]]
		then
			shellScriptFiles+=("$file")
		fi
	fi

done
IFS=$'\n' sorted_files=($(sort <<<"${shellScriptFiles[*]}"))

# Display the sorted shell script files
echo "Sorted Shell Script Files:"
for file in "${sorted_files[@]}"; do
    echo "$file"
done
