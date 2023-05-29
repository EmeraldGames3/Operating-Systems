#!/bin/bash

search_text="$1"

shift

for file in "$@"; do
    if [ -f "$file" ]; then
        sed "/$search_text/d" "$file"
    else
        echo "Datei $file existiert nicht oder ist kein reguläres Dateiobjekt."
    fi
done

