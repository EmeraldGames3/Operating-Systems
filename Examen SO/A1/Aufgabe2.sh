#!/bin/bash

# Funktion zum Zählen der Zeilen in einer Datei
count_lines() {
  local file="$1"
  local lines=$(wc -l < "$file")
  echo "$lines"
}

# Funktion zum Durchsuchen der Dateien
search_files() {
  local folder="$1"
  local total_lines=0

  # Durchlaufen aller Dateien im Ordner
  for file in "$folder"/*; do
    # Überprüfen, ob es sich um eine Textdatei handelt
    if [ -f "$file" ] && [ "${file##*.}" = "txt" ]; then
      # Zeilen in der Datei zählen
      local lines=$(count_lines "$file")
      total_lines=$((total_lines + lines))
    fi

    # Überprüfen, ob es sich um einen Unterordner handelt
    if [ -d "$file" ]; then
      # Rekursiver Aufruf für den Unterordner
      local lines=$(search_files "$file")
      total_lines=$((total_lines + lines))
    fi
  done

  echo "$total_lines"
}

# Überprüfen der Anzahl der Argumente
if [ "$#" -ne 1 ]; then
  echo "Bitte geben Sie den Ordnerpfad als Parameter an."
  exit 1
fi

# Aufruf der Funktion mit dem übergebenen Ordnerpfad
search_files "$1"
