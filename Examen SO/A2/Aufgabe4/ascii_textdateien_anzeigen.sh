#!/bin/bash

folder="$1"

if [ -d "$folder" ]; then
    find "$folder" -type f -exec file {} \; | grep "ASCII text" | awk -F: '{print $1}' | sort
else
    echo "Der angegebene Ordner existiert nicht oder ist kein Verzeichnis."
fi
