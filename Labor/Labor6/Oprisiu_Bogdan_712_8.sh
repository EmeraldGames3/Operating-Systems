#!/bin/bash

# Check if a valid number of arguments is passed
if [ $# -eq 0 ]; then
  echo "Error: no transport ticket files provided"
  exit 1
fi

#Check if the provided files exist
for file in "$@"; do
  if [ ! -f "$file" ]; then
    echo "Error: File $file not found"
    exit 1
  fi
done

# Process each transport ticket file
for transport_file in "$@"; do
  transport_type=$(head -n 1 "$transport_file") # Get transport type from first line
  tail -n +2 "$transport_file" | while read -r line; do
    product=$(echo "$line" | cut -d ',' -f 1)
    amount=$(echo "$line" | cut -d ',' -f 2)

	# Check if the product exists in lager.csv and update the amount accordingly
    if [[ $transport_type == "OUT" ]]; then    
      if grep -q "^$product," lager.csv; then
        existing_amount=$(grep "^$product," lager.csv | cut -d ',' -f 2)
        if [[ $amount -gt $existing_amount ]]; then
          echo "Error: Cannot remove $amount units of $product. Only $existing_amount units are available in lager."
          exit 1
        elif [[ $amount -eq $existing_amount ]]; then
          sed -i "/^$product,/d" lager.csv
        else
          updated_amount=$((existing_amount - amount))
          sed -i "s/^$product,.*/$product, $updated_amount/" lager.csv
        fi
      else
        echo "Error: Product $product not found in lager."
        exit 1
      fi
    fi

	# Check if the product exists in lager.csv and update the amount accordingly, or add a new product with the given amount
    if [[ $transport_type == "IN" ]]; then
      if grep -q "^$product," lager.csv; then
        existing_amount=$(grep "^$product," lager.csv | cut -d ',' -f 2)
        updated_amount=$((existing_amount + amount))
        sed -i "s/^$product,.*/$product, $updated_amount/" lager.csv
      else
        echo "$product, $amount" >> lager.csv
      fi
    fi
  done
done

# Remove products with 0 units
sed -i '/, 0$/d' lager.csv

# Remove last comma if it exists
sed -i -e '${/^,$/d;}' lager.csv

exit 0

