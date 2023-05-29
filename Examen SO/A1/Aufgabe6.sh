#!/bin/bash

# Funktion zum Berechnen des Flächeninhalts des Dreiecks
calculate_area() {
  local x1=$1
  local y1=$2
  local x2=$3
  local y2=$4
  local x3=$5
  local y3=$6

  # Berechnung des Flächeninhalts (ganzzahliger Teil)
  local area=$(( (x1*(y2-y3) + x2*(y3-y1) + x3*(y1-y2)) / 2 ))

  echo $area
}

# Punktkoordinaten von der Befehlszeile lesen
points=$1

# Extrahieren der Koordinaten der einzelnen Punkte
x1=${points:0:1}
y1=${points:1:1}
x2=${points:2:1}
y2=${points:3:1}
x3=${points:4:1}
y3=${points:5:1}

# Überprüfen, ob die Punkte kollinear sind
if (( (x1*(y2-y3) + x2*(y3-y1) + x3*(y1-y2)) == 0 )); then
  echo "kollinear"
else
  # Berechnen und anzeigen des Flächeninhalts
  area=$(calculate_area $x1 $y1 $x2 $y2 $x3 $y3)
  echo "Flächeninhalt: $area"
fi
