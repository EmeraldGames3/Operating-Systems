#!/bin/bash

file="$1"

if [ -f "$file" ]; then
    sed 's/[[:alnum:]]*[[:digit:]][[:alnum:]]*//g' "$file"
else
    echo "Die angegebene Datei existiert nicht oder ist kein reguläres Dateiobjekt."
fi

