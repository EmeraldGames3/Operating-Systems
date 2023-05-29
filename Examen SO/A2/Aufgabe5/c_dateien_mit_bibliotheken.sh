#!/bin/bash

folder="$1"

if [ -d "$folder" ]; then
    c_files=$(find "$folder" -name "*.c")
    libraries_count=$(grep -r "#include <.*>" "$folder" | sort | uniq -c | awk '{ if ($1 >= 3) print $2 }')

    for file in $c_files; do
        libraries_in_file=$(grep -c -f <(echo "$libraries_count") "$file")

        if [ $libraries_in_file -ge 3 ]; then
            echo "$file"
        fi
    done
else
    echo "Der angegebene Ordner existiert nicht oder ist kein Verzeichnis."
fi
