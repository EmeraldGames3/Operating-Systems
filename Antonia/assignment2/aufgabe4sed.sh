#!/bin/bash
if [ $# -lt 2 ]
then
	echo "Not enough arguments"
	exit 1
fi
word=$1
fileName=$2
echo "File Content: "
content=$(cat "$fileName")
echo "$content"
echo "Insert $word befor lower-case: "
sed "s/\([a-z]\)/$word\1/g" "$fileName"
echo ""
echo "Insert $word after lower-case: "
sed "s/\([a-z]\)/\1$word/g" "$fileName"
