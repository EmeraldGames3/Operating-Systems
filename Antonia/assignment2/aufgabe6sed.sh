#!/bin/bash
if [ $# -lt  ]
then
        echo "Not enough arguments"
        exit 1
fi
character=$1
fileName=$2
if [ ! -f "$fileName" ]
then
        echo "Not a file.."
        exit 1
fi
echo "File Content: "
content=$(cat "$fileName")
echo "$content"
echo ""
echo "After substitution: "
sed -E "s/[a-z]/$character/g" "$fileName"
