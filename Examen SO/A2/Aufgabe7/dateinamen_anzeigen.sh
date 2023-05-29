#!/bin/bash

folder="$1"

if [ -d "$folder" ]; then
    grep -rl "#define" --include "*.c" "$folder" | sort | xargs -I {} basename {}
else
    echo "Der angegebene Ordner existiert nicht oder ist kein Verzeichnis."
fi
