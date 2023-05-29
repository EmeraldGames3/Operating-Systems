#!/bin/bash
if [ $# -lt 1 ]; then
   echo "Not enough arguments"
   exit 1
fi
files=($@)
totalNrLines=0
totalNrWords=0
for file in "${files[@]}"; do
        echo "Filename: $file"
        nrLines=$(wc -l "$file" | awk '{printf $1}')
	nrWords=$(wc -w "$file" | awk '{printf $1}')
	echo "Number of lines: $nrLines"
	echo "Number of words: $nrWords"
	durchschnitt=$((nrWords / nrLines))
	echo "Durchschnitt: $durchschnitt"
	echo ""
	totalNrLines=$((totalNrLines + nrLines))
	totalNrWords=$((totalNrWords + nrWords))
done
average=$((totalNrWords / totalNrLines))
echo "Durchschnitt fur alle Dateien: $average"
