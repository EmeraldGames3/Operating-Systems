#!/bin/bash
if [ $# -lt 1 ]; then
   echo "Not enough arguments"
   exit 1
fi
files=($@)
nrFiles=1
for file in "${files[@]}"; do
        echo "Filename: $file"
        content=$(cat "$file")
        lines=()
        while IFS= read -r line; do
               lines+=("$line")
        done <<< "$content"
        nrLine=1
        for line in "${lines[@]}"; do
                
		if (( ${#line} >= 10 )); then
  		  echo "line $nrLine has at least 10 characters."
		  echo "Line content without the first 10 characters: "
		  trimmed_line="${line:10}"
		  echo "$trimmed_line"
		  echo ""
		fi
		nrLine=$((nrLine + 1))
	done
done
