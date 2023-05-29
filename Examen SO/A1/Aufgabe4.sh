#!/bin/bash

# Funktion zum Umbenennen der Dateien
rename_files() {
  local folder="$1"

  # Durchlaufen aller Dateien im Ordner
  for file in "$folder"/*; do
    # Überprüfen, ob es sich um eine ".txt"-Datei handelt
    if [ -f "$file" ] && [ "${file##*.}" = "txt" ]; then
      # Umbenennen der Datei mit ".ascii"-Erweiterung
      local new_name="${file%.*}.ascii"
      mv "$file" "$new_name"
      echo "Umbenannt: $new_name"
    fi

    # Überprüfen, ob es sich um einen Unterordner handelt
    if [ -d "$file" ]; then
      # Rekursiver Aufruf für den Unterordner
      rename_files "$file"
    fi
  done
}

# Überprüfen der Anzahl der Argumente
if [ "$#" -ne 1 ]; then
  echo "Bitte geben Sie den Ordnerpfad als Parameter an."
  exit 1
fi

# Überprüfen, ob der Ordner existiert
if [ ! -d "$1" ]; then
  echo "Der angegebene Ordner existiert nicht."
  exit 1
fi

# Aufruf der Funktion mit dem übergebenen Ordnerpfad
rename_files "$1"
