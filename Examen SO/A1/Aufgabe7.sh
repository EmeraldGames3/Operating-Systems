#!/bin/bash

# Funktion zur Berechnung des Ergebnisses
calculate_result() {
  local number1=$1
  local number2=$2
  local number3=$3

  # Überprüfen, welche der beiden Zahlen größer ist
  if (( number1 >= number2 )); then
    result=$(( number1 + number3 ))
  else
    result=$(( number2 + number3 ))
  fi

  echo $result
}

# Überprüfen der Anzahl der Argumente
if [ "$#" -ne 3 ]; then
  echo "Bitte geben Sie drei Zahlen als Argumente ein."
  exit 1
fi

# Lesen der Zahlen aus der Befehlszeile
number1=$1
number2=$2
number3=$3

# Aufrufen der Funktion zur Berechnung des Ergebnisses
result=$(calculate_result $number1 $number2 $number3)

# Ausgabe des Ergebnisses in der Standardausgabe
echo "Ergebnis: $result"
