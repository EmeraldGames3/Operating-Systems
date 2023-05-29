#!/bin/bash

# Funktion zum Sortieren und Auflisten der Dateien nach Dateinamen
list_files_sorted_by_name() {
  local folder="$1"

  echo "Dateien sortiert nach Dateinamen:"
  ls -1 "$folder"
  echo
}

# Funktion zum Sortieren und Auflisten der Dateien nach Zeitpunkt des letzten Zugriffs
list_files_sorted_by_access_time() {
  local folder="$1"

  echo "Dateien sortiert nach Zeitpunkt des letzten Zugriffs:"
  ls -lt "$folder"
  echo
}

# Funktion zum Sortieren und Auflisten der Dateien nach Bytegröße
list_files_sorted_by_size() {
  local folder="$1"

  echo "Dateien sortiert nach Bytegröße:"
  ls -lS "$folder"
  echo
}

# Überprüfen der Anzahl der Argumente
if [ "$#" -ne 1 ]; then
  echo "Bitte geben Sie den Ordnerpfad als Parameter an."
  exit 1
fi

# Ordnerpfad aus dem Argument extrahieren
folder_path="$1"

# Überprüfen, ob der Ordner existiert
if [ ! -d "$folder_path" ]; then
  echo "Der angegebene Ordner existiert nicht."
  exit 1
fi

# Aufrufen der Funktionen für die drei Sortierungen
list_files_sorted_by_name "$folder_path"
list_files_sorted_by_access_time "$folder_path"
list_files_sorted_by_size "$folder_path"
