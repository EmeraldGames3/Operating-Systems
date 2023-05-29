#!/bin/bash

# Überprüfen der Anzahl der Argumente
if [ "$#" -ne 6 ]; then
  echo "Bitte geben Sie die Koordinaten der Vektoren a b c e f g als Parameter ein."
  exit 1
fi

# Lesen der Koordinaten der Vektoren aus der Befehlszeile
a=$1
b=$2
c=$3
e=$4
f=$5
g=$6

# Berechnen des Skalarprodukts der beiden Vektoren
dot_product=$((a*e + b*f + c*g))

# Überprüfen, ob das Skalarprodukt gleich 0 ist (senkrecht)
if [ $dot_product -eq 0 ]; then
  echo "ja"
else
  echo "nein"
fi
