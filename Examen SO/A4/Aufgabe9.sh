#!/bin/bash

# Überprüfen der Anzahl der Argumente
if [ "$#" -ne 3 ]; then
  echo "Bitte geben Sie den Ordner, den Funktionsnamen und den Ersatzwert als Parameter ein."
  exit 1
fi

# Lesen der Argumente
folder="$1"
function_name="$2"
replacement_value="$3"

# Zählen der vorgenommenen Ersetzungen
replacement_count=0

# Durchsuchen des Ordners und seiner Unterordner nach .c-Dateien
find "$folder" -name "*.c" | while read -r file; do
  # Überprüfen, ob die Funktion im aktuellen Codeausschnitt vorkommt
  if grep -q "\b${function_name}(" "$file"; then
    # Ersetzen des Funktionsparameters im aktuellen Codeausschnitt
    sed -i "s/\b${function_name}(/${function_name}(${replacement_value}, /g" "$file"
    replacement_count=$((replacement_count + 1))
  fi
done

# Anzeigen der Anzahl der vorgenommenen Ersetzungen
echo "Anzahl der vorgenommenen Ersetzungen: $replacement_count"
