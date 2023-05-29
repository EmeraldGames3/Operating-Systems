#!/bin/bash

if [ $# -lt 2 ]
then
	echo "Not enonugh arguments"
	exit 1

fi
fileName=$1
echo "File Content: "
content=$(cat "$fileName")
echo "$content"
echo ""
words=("${@:2}")
for word in "${words[@]}"; do
	echo "Word: $word"
	sed -i "s/\b$word\b//g" "$fileName"
done
newcontent=$(cat "$fileName")
echo "File Content: "
echo "$newcontent"
echo ""
