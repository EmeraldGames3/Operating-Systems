#!/bin/bash

first_file=true

for filename in "$@"; do
  if $first_file; then
    cat "$filename"
    first_file=false
  else
    while IFS= read -r line; do
      words=()
      IFS=' ' read -ra words <<< "$line"
      reversed_words=""
      for ((i=${#words[@]}-1; i>=0; i--)); do
        reversed_words+=":${words[i]}"
      done
      reversed_words="${reversed_words:1}"
      echo "$reversed_words"
    done < "$filename"
  fi
done
