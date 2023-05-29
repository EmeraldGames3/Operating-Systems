#!/bin/bash

# Funktion zum Überprüfen, ob eine Zahl eine Primzahl ist
is_prime() {
  local number="$1"

  # Überprüfen, ob die Zahl kleiner als 2 ist
  if [ "$number" -lt 2 ]; then
    return 1
  fi

  # Überprüfen, ob die Zahl durch eine andere Zahl ohne Rest teilbar ist
  for (( divisor = 2; divisor * divisor <= number; divisor++ )); do
    if [ $((number % divisor)) -eq 0 ]; then
      return 1
    fi
  done

  return 0
}

# Zahl von der Standardeingabe lesen
echo "Bitte geben Sie eine Zahl ein:"
read number

# Überprüfen, ob die eingegebene Zahl eine Primzahl ist
if is_prime "$number"; then
  echo "prime"
else
  echo "not prime"
fi
