#!/bin/bash

# Überprüfen der Anzahl der Argumente
if [ "$#" -ne 1 ]; then
  echo "Bitte geben Sie den Namen des Ordners als Parameter ein."
  exit 1
fi

# Lesen des Ordnerpfads aus dem Parameter
folder="$1"

# Überprüfen, ob der Ordner existiert
if [ ! -d "$folder" ]; then
  echo "Der angegebene Ordner '$folder' existiert nicht."
  exit 1
fi

# Funktion zum Durchsuchen der Ordnerstruktur
search_folder() {
  local current_folder="$1"
  local indent="$2"

  # Ausgabe des aktuellen Ordners und der Anzahl der Vorkommen
  echo "${indent}$(basename "$current_folder") $(find "$current_folder" | wc -l)"

  # Durchsuchen der Dateien und Unterordner im aktuellen Ordner
  while IFS= read -r entry; do
    if [ -d "$entry" ]; then
      # Rekursiver Aufruf für Unterordner
      search_folder "$entry" "$indent  "
    fi
  done < <(find "$current_folder" -mindepth 1)
}

# Aufruf der Funktion für den angegebenen Ordner
search_folder "$folder" ""

