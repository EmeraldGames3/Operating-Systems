#!/bin/bash

for folder in "$@"; do
    if [ -d "$folder" ]; then
        find "$folder" -type f -exec file {} \; | grep -v "text"
    else
        echo "Ordner $folder existiert nicht oder ist kein Verzeichnis."
    fi
done
