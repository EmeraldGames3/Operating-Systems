#!/bin/bash

max_words=0
max_word_file=""

for filename in "$@"; do
  word_count=$(awk '{ print NF }' "$filename")
  
  if (( word_count > max_words )); then
    max_words=$word_count
    max_word_file=$filename
  fi
done

echo "$max_word_file $max_words"
