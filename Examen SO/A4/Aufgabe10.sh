#!/bin/bash

# Überprüfen der Anzahl der Argumente
if [ "$#" -lt 1 ]; then
  echo "Bitte geben Sie mindestens einen Kundennamen als Parameter ein."
  exit 1
fi

# Schleife über alle übergebenen Kundennamen
for customer_name in "$@"; do
  # Pfad zur Kunden-Textdatei
  customer_file="${customer_name}.txt"
  
  # Überprüfen, ob die Kunden-Textdatei existiert
  if [ ! -f "$customer_file" ]; then
    echo "Die Datei für den Kunden '$customer_name' existiert nicht."
    continue
  fi
  
  # Lesen des Gehalts des Kunden aus der ersten Zeile der Datei
  read -r salary < "$customer_file"
  
  # Lesen der monatlichen Ausgaben des Kunden aus der zweiten Zeile der Datei
  read -r expenses < <(tail -n 1 "$customer_file")
  
  # Berechnung des Notfallfonds und der Anzahl der Monate
  emergency_fund=$((expenses * 6))
  months_of_saving=$((emergency_fund / salary))
  
  # Hinzufügen der Notfallfonds- und Monatsanzahlzeile ans Ende der Kunden-Textdatei
  echo "Notfallfonds: $emergency_fund, Monate des Sparens: $months_of_saving" >> "$customer_file"
done
