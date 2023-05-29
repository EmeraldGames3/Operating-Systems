#!/bin/bash

filename=$1
valid_lines=0
invalid_lines=0
sum=0

while IFS= read -r line; do
  field_sum=0
  field_count=0

  for field in $line; do
    if [[ $field =~ ^[0-9]+([.][0-9]+)?$ ]]; then
      field_sum=$(awk "BEGIN { printf \"%.2f\", $field_sum + $field }")
      field_count=$((field_count + 1))
    fi
  done

  if [[ $field_count -gt 0 ]]; then
    sum=$(awk "BEGIN { printf \"%.2f\", $sum + $field_sum }")
    valid_lines=$((valid_lines + 1))
  else
    invalid_lines=$((invalid_lines + 1))
  fi
done < "$filename"

echo "Summe=$sum"
echo "Verhältnis enthält_Zahl/enthält_keine_Zahl=$valid_lines:$invalid_lines"
