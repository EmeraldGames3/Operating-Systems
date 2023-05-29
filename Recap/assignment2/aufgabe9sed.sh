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

echo ""
nrLine=1
for line in "${lines[@]}"; do
    words=($(grep -oE '\w+' <<< "$line"))
    count=1
    for word in "${words[@]}"; do
	if (( count == 2 || count == 4)); then
		 sed -i "${nrLine} s/\\b$word\\b//" "$fileName"
	fi
	count=$((count + 1))
    done
    nrLine=$((nrLine + 1))
done
echo "New File Content:"
cat "$fileName"
