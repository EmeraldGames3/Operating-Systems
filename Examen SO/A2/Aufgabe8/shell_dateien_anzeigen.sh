#!/bin/bash

for file in "$@"; do
    if [ -f "$file" ]; then
        if file "$file" | grep -q "shell script"; then
            echo "$(basename "$file")"
        fi
    else
        echo "Die Datei '$file' existiert nicht oder ist kein reguläres Dateiobjekt."
    fi
done | sort
