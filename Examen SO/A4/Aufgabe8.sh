#!/bin/bash

# Überprüfen der Anzahl der Argumente
if [ "$#" -ne 1 ]; then
  echo "Bitte geben Sie die Liste der Transport-Tickets als Parameter ein."
  exit 1
fi

# Lesen der Argumente
tickets_file="$1"

# Überprüfen, ob die Transport-Tickets-Datei existiert
if [ ! -f "$tickets_file" ]; then
  echo "Die angegebene Transport-Tickets-Datei '$tickets_file' existiert nicht."
  exit 1
fi

# Funktion zum Aktualisieren des Lagerbestands
update_inventory() {
  local product="$1"
  local quantity="$2"
  local inventory_file="lager.csv"
  local temp_file="lager_temp.csv"

  # Aktualisieren des Lagerbestands
  awk -v product="$product" -v quantity="$quantity" 'BEGIN { FS = OFS = "," } $1 == product { $2 += quantity } 1' "$inventory_file" > "$temp_file"

  # Umbenennen der temporären Datei
  mv "$temp_file" "$inventory_file"
}

# Verarbeiten der Transport-Tickets-Datei
while IFS= read -r line; do
  # Extrahieren der Art des Transports und der Produktinformationen
  transport_type=$(echo "$line" | head -n 1)
  product_info=$(echo "$line" | tail -n +2)

  # Verarbeiten der Produktinformationen
  IFS=',' read -r product quantity <<<"$product_info"

  # Aktualisieren des Lagerbestands basierend auf der Art des Transports
  case "$transport_type" in
    "IN")
      update_inventory "$product" "$quantity"
      ;;
    "OUT")
      update_inventory "$product" "-$quantity"
      ;;
    *)
      echo "Ungültige Art des Transports: $transport_type"
      exit 1
      ;;
  esac
done <"$tickets_file"
