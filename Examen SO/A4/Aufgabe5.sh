#!/bin/bash

# Überprüfen der Anzahl der Argumente
if [ "$#" -ne 2 ]; then
  echo "Bitte geben Sie die Namen der beiden Ordner als Parameter ein."
  exit 1
fi

# Lesen der Namen der beiden Ordner aus den Parametern
source_folder="$1"
destination_folder="$2"

# Überprüfen, ob die beiden Ordner existieren
if [ ! -d "$source_folder" ]; then
  echo "Der Quellordner '$source_folder' existiert nicht."
  exit 1
fi

if [ ! -d "$destination_folder" ]; then
  echo "Der Zielordner '$destination_folder' existiert nicht."
  exit 1
fi

# Erstellen des Zielpfads für den verschobenen Unterzweig
destination_path="$destination_folder/$(basename "$source_folder")"

# Verschieben des Unterzweigs in den Zielordner
mv "$source_folder" "$destination_path"

# Ändern der Dateierweiterungen im zweiten Ordner
find "$destination_path" -type f -exec rename 's/\.([^.]*)$/.eins/' {} +

