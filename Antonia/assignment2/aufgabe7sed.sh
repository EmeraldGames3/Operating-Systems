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
echo "After changing vowels: "
sed -E 's/[aeiou]/\U&/g' "$fileName"
