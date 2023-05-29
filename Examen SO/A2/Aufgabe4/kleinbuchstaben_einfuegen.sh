#!/bin/bash

insert_word="$1"
file="$2"

if [ -f "$file" ]; then
    sed 's/[a-z]/'"$insert_word"'\0/g' "$file"
else
    echo "Die angegebene Datei existiert nicht oder ist kein reguläres Dateiobjekt."
fi
