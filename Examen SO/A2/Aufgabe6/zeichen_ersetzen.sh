#!/bin/bash

replacement="$1"
file="$2"

if [ -f "$file" ]; then
    sed "s/[^A-Z]/$replacement/g" "$file"
else
    echo "Die angegebene Datei existiert nicht oder ist kein reguläres Dateiobjekt."
fi
