#!/bin/bash

# Überprüfen der Anzahl der Argumente
if [ "$#" -ne 3 ]; then
  echo "Bitte geben Sie drei Zahlen als Parameter ein."
  exit 1
fi

# Lesen der Zahlen aus der Befehlszeile
number1=$1
number2=$2
number3=$3

# Überprüfen, ob die Zahlen pythagoreisch sind
if (( number1**2 == number2**2 + number3**2 || number2**2 == number1**2 + number3**2 || number3**2 == number1**2 + number2**2 )); then
  echo "ja"
else
  echo "nein"
fi
