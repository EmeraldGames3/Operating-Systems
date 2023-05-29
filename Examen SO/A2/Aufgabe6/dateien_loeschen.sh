#!/bin/bash

file="$1"
shift
folders=("$@")

if [ -f "$file" ]; then
    while IFS= read -r filename; do
        for folder in "${folders[@]}"; do
            find "$folder" -type f -name "$filename" -delete
        done
    done < "$file"
else
    echo "Die angegebene Datei existiert nicht oder ist kein reguläres Dateiobjekt."
fi
