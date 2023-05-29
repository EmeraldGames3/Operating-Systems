#!/bin/bash

# Überprüfen der Anzahl der Argumente
if [ "$#" -lt 2 ]; then
  echo "Bitte geben Sie den Dateinamen und mindestens ein Wort als Parameter ein."
  exit 1
fi

# Lesen des Dateinamens aus dem ersten Parameter
file_name=$1

# Erstellen des sed-Befehls, um die Wörter zu löschen
sed_command=""

# Schleife über die restlichen Parameter, um die Wörter zum sed-Befehl hinzuzufügen
for ((i = 2; i <= $#; i++)); do
  word="${!i}"  # Lesen des Worts aus dem Parameter
  sed_command+="s/$word//g; "  # Hinzufügen des Befehls, um das Wort zu löschen
done

# Anwenden des sed-Befehls auf die Datei
sed -i "$sed_command" "$file_name"
