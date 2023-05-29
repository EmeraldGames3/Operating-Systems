#!/bin/bash

# Überprüfen der Anzahl der Argumente
if [ "$#" -ne 2 ]; then
  echo "Bitte geben Sie den Namen der Textdatei und den Pfad zum Zielordner als Parameter ein."
  exit 1
fi

# Lesen der Argumente
text_file="$1"
target_folder="$2"

# Überprüfen, ob die Textdatei existiert
if [ ! -f "$text_file" ]; then
  echo "Die angegebene Textdatei '$text_file' existiert nicht."
  exit 1
fi

# Erstellen des Zielordners
mkdir -p "$target_folder/Wörterbuch"

# Funktion zum Erstellen der Wörterbuchdateien
create_word_file() {
  local prefix="$1"
  local start_char="$2"
  local end_char="$3"
  local word_file="${target_folder}/Wörterbuch/${prefix}.txt"

  # Extrahieren der Wörter, die mit dem entsprechenden Präfix beginnen
  grep -E "^${start_char}" "$text_file" | sort > "$word_file"

  # Erstellen der restlichen Dateien mit den entsprechenden Präfixen
  for ((i = ((start_char + 1)); i <= end_char; i++)); do
    cp "$word_file" "${target_folder}/Wörterbuch/$i.txt"
  done
}

# Erstellen der Wörterbuchdateien für die Ziffern 0-9
create_word_file 0 0 9

