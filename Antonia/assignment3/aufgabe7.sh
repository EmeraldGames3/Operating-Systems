#!/bin/bash
if [ $# -lt 1 ]
then
	echo "Not enough arguments"
	exit 1
fi
files=($@)
for file in "${files[@]}"; do
	echo "Filename: $file"
	lines=()
	while IFS= read -r line; do
    		lines+=("$line")
	done < "$file"
	nrLine=1
	for line in "${lines[@]}"; do
		length=${#line};
		if [ $length -gt 30 ]; then
			first_word=$(echo "$line" | awk '{print $1}')
			last_word=$(echo "$line" | awk '{print $NF}')
			echo "Line number: $nrLine First word: $first_word Last word: $last_word"
		fi
		nrLine=$((nrLine + 1))
	done
	echo ""
done
