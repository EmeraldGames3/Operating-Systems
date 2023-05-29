#!/bin/bash
if [ $# -lt 1 ]; then
	echo "Not enough arguments"
	exit 1
fi
files=($@)
maxWordCount=0
fileName=""
for file in "${files[@]}"; do
	wordCount=$(wc -w "$file" | awk '{printf $1}')
	echo "Filename: $file   Word count: $wordCount"
	if [ "$wordCount" -gt "$maxWordCount" ]; then
		maxWordCount=$wordCount
		fileName="$file"
	fi
done
echo "File with max number of words: $fileName"
