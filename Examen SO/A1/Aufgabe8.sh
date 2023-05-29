#!/bin/bash

# Überprüfen der Anzahl der Argumente
if [ "$#" -ne 2 ]; then
  echo "Bitte geben Sie die Anzahl der Ordner und die Anzahl der Dateien als Parameter ein."
  exit 1
fi

# Lesen der Anzahl der Ordner und der Anzahl der Dateien aus der Befehlszeile
num_folders=$1
num_files=$2

# Schleife zum Erstellen der Ordner
for ((i = 1; i <= num_folders; i++)); do
  folder_name="Ordner$i"
  mkdir "$folder_name"

  # Schleife zum Erstellen der Dateien in jedem Ordner
  for ((j = 1; j <= num_files; j++)); do
    file_name="$folder_name/Datei$j.txt"
    touch "$file_name"
    echo "Datei $file_name erstellt."
  done

  echo "Ordner $folder_name erstellt."
done
