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
content=$(cat "$fileName")
echo ""
lines=()
while IFS= read -r line; do
    lines+=("$line")
done <<< "$content"

nrLine=1
for line in "${lines[@]}"; do
    words=($(grep -oE '\w+' <<< "$line"))
    count=1
    word1=""
    word3=""
    for word in "${words[@]}"; do
        if (( count == 1 )); then
               word1=$word
        fi
	if (( count == 3 )); then
		word3=$word
	fi
        count=$((count + 1))
    done
    sed -i "${nrLine}s/\\b$word1\\b/TEMP_PLACEHOLDER/" "$fileName"
    sed -i "${nrLine}s/\\b$word3\\b/$word1/" "$fileName"
    sed -i "${nrLine}s/TEMP_PLACEHOLDER/$word3/" "$fileName"
    nrLine=$((nrLine + 1))
done
echo "New File Content:"
cat "$fileName"
