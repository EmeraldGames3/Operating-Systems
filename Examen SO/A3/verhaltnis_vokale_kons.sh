#!/bin/bash

for filename in "$@"; do
  vowels=$(grep -o -i "[aeiou]" "$filename" | wc -l)
  consonants=$(grep -o -i "[bcdfghjklmnpqrstvwxyz]" "$filename" | wc -l)
  echo "$filename $vowels $consonants"
done
