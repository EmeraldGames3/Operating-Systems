#!/bin/bash

# Überprüfen der Anzahl der Argumente
if [ "$#" -ne 1 ]; then
  echo "Bitte geben Sie den Pfad zum Ordner als Parameter ein."
  exit 1
fi

# Lesen des Ordnerpfads aus der Befehlszeile
folder_path=$1

# Verwenden von grep und cat, um den Inhalt der .txt-Dateien anzuzeigen
grep -rHl ".txt" "$folder_path" | xargs cat
