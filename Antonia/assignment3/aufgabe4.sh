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
		words=($(grep -oE '\w+' <<< "$line"))
		for ((index=0; index<${#words[@]}-1; index++)); do
   			 current="${words[index]}"
    			 next="${words[index+1]}"
			 if [ "$current" = "$next" ]; then
				echo "$nrLine: $current"
			 fi
		done
		
		nrLine=$((nrLine + 1))
        done

done
