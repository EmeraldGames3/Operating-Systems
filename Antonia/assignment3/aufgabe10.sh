#!/bin/bash
if [ $# -lt 1 ]; then
	echo "Not enough arguments"
	exit 1
fi
files=($@)

for file in "${files[@]}"; do

	while IFS= read -r line; do
    		lines+=("$line")
	done < "$file"
	nrLine=1
	for line in "${lines[@]}"; do
    		words=()
		wort=""
		found=0
		while read -r -d ' ' word; do
    			words+=("$word")
		done <<< "$line"
		for word in "${words[@]}"; do
			count=$(grep -oE "\b$word\b" <<< $line | wc -l)
			if [ $count -gt 1 ];then
				found=1
				wort="$word"
			fi
		done
		if [ $found -eq 1 ]; then
			echo "Line number: $nrLine  Word: $wort"
		fi
		nrLine=$((nrLine + 1))
	done
done
