#!/bin/bash
if [ $# -lt  ]
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
content=$(cat "$fileName")
echo "$content"
echo ""
echo "After deleting words that contain digits: "
sed -E 's/\b[a-zA-Z]*[0-9]+[a-zA-Z]*\b//g' "$fileName"
