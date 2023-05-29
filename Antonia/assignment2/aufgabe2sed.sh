#!/bin/bash

if [ $# -lt 2 ]
then
	echo "Not enough arguments"
	exit 1
fi
text=${!#}
echo "Text: $text"
echo ""
files=("${@:1:$#-1}")
for file in "${files[@]}"; do
	echo "File: $file"
	content=$(cat "$file")
	echo ""
	echo "Content:"
	echo "$content"
	echo ""
	echo "Sed: "
	sed "/$text/d" "$file"
done

