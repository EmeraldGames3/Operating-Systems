#!/bin/bash

search_text="$1"

shift

for file in "$@"; do
    if [ -f "$file" ]; then
        sed "1,30 {/$search_text/d}" "$file"
    else
        echo "Datei $file existiert nicht oder ist kein reguläres Dateiobjekt."
    fi
done
