#!/bin/bash

if [ $# -lt 2 ]; then
    echo "Invalid number of arguments"
    exit 1
fi

text=$1

shift

for file in "$@"; do
    sed '1,30 {/'"$text"'/d}' "$file"
done

exit 0
