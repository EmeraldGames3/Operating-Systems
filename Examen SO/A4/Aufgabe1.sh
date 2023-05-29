#!/bin/bash

# Überprüfen der Anzahl der Argumente
if [ "$#" -ne 1 ]; then
  echo "Bitte geben Sie den Dateinamen als Parameter ein."
  exit 1
fi

# Lesen des Dateinamens aus dem Parameter
file_name=$1

# Verwenden von grep und sed, um die Anzahl der Aufrufe für jede int-Funktion zu bestimmen
function_calls=$(grep -oP '\bint\b\s+\b\w+\b' "$file_name" | sed 's/int //')

# Zählen der Anzahl der Aufrufe für jede Funktion
function_counts=$(echo "$function_calls" | sort | uniq -c)

# Ausgabe der Anzahl der Aufrufe für jede Funktion in der Standardausgabe
echo "$function_counts"
