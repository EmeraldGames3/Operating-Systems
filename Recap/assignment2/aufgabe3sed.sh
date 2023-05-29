#!/bin/bash

if [ $# -lt 2 ]
then
	echo "Not enough arguments"
	exit 1
fi
text=$1
files=("${@:2}")
for file in "${files[@]}"; do
	echo "File Content: "
	content=$(cat "$file")
	echo "$content"
	echo ""
	echo "Sed: "
	sed "1,30 {/\b$text\b/d}" "$file"
	echo ""
done
