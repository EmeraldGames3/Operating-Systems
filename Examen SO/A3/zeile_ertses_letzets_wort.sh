#!/bin/bash

for filename in "$@"; do
  line_number=0

  while IFS= read -r line; do
    line_number=$((line_number + 1))
    line_length=${#line}

    if [[ $line_length -gt 30 ]]; then
      first_word=$(echo "$line" | awk '{print $1}')
      last_word=$(echo "$line" | awk '{print $NF}')
      echo "$line_number $first_word $last_word"
    fi
  done < "$filename"
done
