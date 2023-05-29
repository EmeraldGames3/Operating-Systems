#!/bin/bash

for filename in "$@"; do
  line_number=0
  selected_lines=0
  file_name=""

  while IFS= read -r line; do
    line_number=$((line_number+1))
    line_length=${#line}

    if [[ $line_length -ge 10 ]]; then
      selected_lines=$((selected_lines+1))
      selected_content="${line:10}"
      echo "$selected_content"
      file_name="$filename"
    fi
  done < "$filename"

  if [[ $selected_lines -gt 0 ]]; then
    echo "$file_name $selected_lines"
  fi
done

