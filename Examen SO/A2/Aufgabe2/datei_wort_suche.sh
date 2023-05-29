#!/bin/bash

search_word="$1"
file_count=0

shift

for file in "$@"; do
    if [ -f "$file" ]; then
        if grep -q "\<$search_word\>" "$file"; then
            echo "$file"
            ((file_count++))
        fi
    else
        echo "Datei $file existiert nicht oder ist kein reguläres Dateiobjekt."
    fi
done

echo "Anzahl der Dateien: $file_count"
