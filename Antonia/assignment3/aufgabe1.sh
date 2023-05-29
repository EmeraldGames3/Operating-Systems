#!/bin/bash
if [ $# -lt 1 ]
then
	echo "Not enough arguments"
	exit 1
fi
files=($@)
for file in "${files[@]}"; do
	vowels=($(grep -o -E "[aeiouAEIOU]" "$file"))
	consonants=($(grep -o -E "[^aeiouAEIOU0-9[:punct:][:space:]]" "$file"))
	lengthv=${#vowels[@]}
	lengthc=${#consonants[@]}
	echo "File: $file"
	echo "Number of vowels: $lengthv"
	echo "Number of consonants: $lengthc"
done
