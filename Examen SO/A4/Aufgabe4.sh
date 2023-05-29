#!/bin/bash

# Überprüfen der Anzahl der Argumente
if [ "$#" -lt 1 ]; then
  echo "Bitte geben Sie den Ordner als Parameter ein."
  exit 1
fi

# Lesen des Ordners aus dem ersten Parameter
folder="$1"

# Überprüfen, ob der Ordner existiert
if [ ! -d "$folder" ]; then
  echo "Der angegebene Ordner existiert nicht."
  exit 1
fi

# Durchsuchen aller Dateien im Ordner und seinen Unterordnern
find "$folder" -type f | while read -r file; do
  # Ausgeben des Dateinamens
  echo -n "$(basename "$file"):"

  # Ausgeben der Unterordner
  dirname "$file" | tr '/' ' '

  # Neue Zeile
  echo
done
