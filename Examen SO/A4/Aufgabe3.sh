#!/bin/bash

# Überprüfen der Anzahl der Argumente
if [ "$#" -ne 2 ]; then
  echo "Bitte geben Sie die Namen der Dateien als Parameter ein: studenten.csv notenSommer.csv"
  exit 1
fi

# Lesen der Dateinamen aus den Parametern
students_file=$1
grades_file=$2

# Sortieren der Datei "studenten.csv" nach dem allgemeinen Durchschnitt absteigend
sorted_students=$(sort -t ',' -k 2 -nr "$students_file")

# Erstellen einer temporären Datei für die aktualisierte Rangliste
temp_file="temp_studenten.csv"

# Kopieren der sortierten Studierenden in die temporäre Datei
echo "$sorted_students" > "$temp_file"

# Verknüpfen der beiden Dateien, um die endgültige Rangliste zu erstellen
join -t ',' -j 1 "$temp_file" "$grades_file" > "$students_file"

# Löschen der temporären Datei
rm "$temp_file"
