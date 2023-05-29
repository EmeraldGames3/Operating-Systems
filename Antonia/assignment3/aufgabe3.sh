#!/bin/bash
if [ $# -lt 1 ]; then
   echo "Not enough arguments"
   exit 1
fi
files=($@)
nrFiles=1
for file in "${files[@]}"; do
	echo "$nrFiles Filename: $file"
	echo ""
	echo "File Content: "
	if (( nrFiles % 2 == 1)); then
		cat "$file"
		echo ""
	else
		content=$(cat "$file")
		lines=()
		while IFS= read -r line; do
		    lines+=("$line")
		done <<< "$content"

		for line in "${lines[@]}"; do
			#reversed_line=$(echo "$line" | awk '{for(i=NF;i>=1;i--) printf "%s ", $i}')
			#echo "$reversed_line"
    			words=($(grep -oE '\w+' <<< "$line"))
			reversed=""
			for ((i=${#words[@]}-1; i>=0; i--)); do
   				 reversed+=" ${words[i]}"
			done
			echo "${reversed}"
		done
        fi
	nrFiles=$((nrFiles + 1))
done

