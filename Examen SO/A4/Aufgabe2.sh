#!/bin/bash

# Überprüfen der Anzahl der Argumente
if [ "$#" -ne 1 ]; then
  echo "Bitte geben Sie den Dateinamen als Parameter ein."
  exit 1
fi

# Lesen des Dateinamens aus dem Parameter
file_name=$1

# Erstellen des Wörterbuchordners
mkdir -p Wörterbuch

# Extrahieren der Wörter, die mit jedem Buchstaben beginnen
words=$(grep -oP '\b[a-zA-Z]\w*' "$file_name")

# Sortieren der Wörter alphabetisch
sorted_words=$(echo "$words" | sort)

# Erstellen der Wörterbuchdateien für jeden Buchstaben des Alphabets
for letter in {A..Z}; do
  letter_file="Wörterbuch/$letter"
  filtered_words=$(echo "$sorted_words" | grep -i "^$letter")
  echo "$filtered_words" > "$letter_file"
done

