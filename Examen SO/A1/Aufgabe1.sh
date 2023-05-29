#!/bin/bash

# Funktionn zum Durchsuchen der Dateien
search_files() {
  local folder="$1"

  # Durchlaufen aller Dateien im Ordner
  for file in "$folder"/*; do
    # Überprüfen der Schreibrechte für "others"
    if [ -w "$file" ]; then
      echo "$file"
    fi

    # Überprüfen, ob es sich um einen Unterordner handelt
    if [ -d "$file" ]; then
      # Rekursiver Aufruf für den Unterordner
      search_files "$file"
    fi
  done
}

# Aufruf der Funktion für den aktuellen Ordner
search_files "."


