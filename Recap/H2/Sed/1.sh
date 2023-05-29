#!/bin/bash

if [ $# -lt 2 ]; then
    echo "Invalid number of arguments"
    exit 1
fi

file=$1

shift

for word in "$@"; do
    sed -i "s/$word//g" "$file"
done

exit 0
