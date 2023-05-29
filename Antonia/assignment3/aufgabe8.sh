#!/bin/bash
if [ $# -lt 1 ]; then
	echo "Not enough arguments"
	exit 1
fi
files=($@)

for file in "${files[@]}"; do
	echo "Filename: $file"
	sum=$(grep -oE "[0-9]+" "$file" | awk '{sum += $1} END {print sum}')
	echo "Total sum: $sum"
	while IFS= read -r line; do
    		lines+=("$line")
	done < "$file"
	doc=0
	dontc=0
	for line in "${lines[@]}"; do
   		if grep -qE '[0-9]+' <<< "$line"; then
    			doc=$((doc + 1))
		else
			dontc=$((dontc + 1))
		fi
	done
	echo "enthält_Zahl/enthält_keine_Zahl: $doc : $dontc"
done
