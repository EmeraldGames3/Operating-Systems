#!/bin/bash

file="$1"

if [ -f "$file" ]; then
    sed 'y/aeiouAEIOU/AEIOUaeiou/' "$file"
else
    echo "Die angegebene Datei existiert nicht oder ist kein reguläres Dateiobjekt."
fi
