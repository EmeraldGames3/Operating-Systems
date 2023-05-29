#!/bin/bash

file="$1"

if [ -f "$file" ]; then
    sed 's/\([^[:space:]]\+[[:space:]]\+\)\{1\}\([^[:space:]]\+[[:space:]]\+\)\{1\}\([^[:space:]]\+[[:space:]]\+\)\{1\}//' "$file"
else
    echo "Die angegebene Datei existiert nicht oder ist kein reguläres Dateiobjekt."
fi
