#!/bin/bash
if [ $# -lt 1 ]
then
        echo "Not enough arguments"
        exit 1
fi
fileName=$1
if [ ! -f "$fileName" ]
then
        echo "Not a file.."
        exit 1
fi
echo "File Content: "
cat "$fileName"
echo ""
content=($(cat "$fileName"))
echo ""
nrLine=1
for line in "${content[@]}"; do
	words=($(grep -oE '\w+' <<< "$line"))
	count=1
	firstWord="$words"
	for word in "${words[@]}"; do
		if (( count % 3 == 0 )); then
			sed -i "${nrLine} s/\\b$word\\b/$firstWord/" "$fileName"
		fi
		count=$((count + 1))
	done
	nrLine=$((nrLine + 1))
done
echo "New File Content: "
cat "$fileName"
