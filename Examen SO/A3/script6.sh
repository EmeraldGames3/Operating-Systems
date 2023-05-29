#!/bin/bash

total_words=0
total_files=0

for filename in "$@"; do
  file_words=0
  file_lines=0

  while IFS= read -r line; do
    line_words=($line)
    words_count=${#line_words[@]}
    file_words=$((file_words + words_count))
    file_lines=$((file_lines + 1))
  done < "$filename"

  if [[ $file_lines -gt 0 ]]; then
    average_words=$(bc -l <<< "scale=2; $file_words / $file_lines")
    echo "$filename $average_words"
    total_words=$((total_words + file_words))
    total_files=$((total_files + file_lines))
  fi
done

if [[ $total_files -gt 0 ]]; then
  overall_average=$(bc -l <<< "scale=2; $total_words / $total_files")
  echo "Overall Average $overall_average"
fi
