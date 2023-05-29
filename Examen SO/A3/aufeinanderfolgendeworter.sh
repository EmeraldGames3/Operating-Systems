#!/bin/bash

for filename in "$@"; do
  current_word=""
  current_line=0
  prev_word=""
  prev_line=0
  
  while IFS= read -r line; do
    current_line=$((current_line+1))
    
    # Leerzeichen als Trennzeichen verwenden, um Wörter zu extrahieren
    words=()
    IFS=' ' read -ra words <<< "$line"
    
    # Überprüfen, ob das aktuelle Wort dasselbe ist wie das vorherige Wort
    if [[ "${words[0]}" == "$prev_word" ]]; then
      # Das aktuelle Wort ist dasselbe wie das vorherige Wort
      if [[ "$current_line" -eq "$prev_line"+1 ]]; then
        # Das aktuelle Wort befindet sich auf der nächsten Zeile
        echo "$current_line ${words[0]}"
      else
        # Das aktuelle Wort befindet sich auf derselben Zeile
        echo -n "${words[0]} "
      fi
    else
      # Das aktuelle Wort ist nicht dasselbe wie das vorherige Wort
      echo "" # Neue Zeile für verschiedene Wörter
    fi
    
    prev_word="${words[0]}"
    prev_line="$current_line"
  done < "$filename"
done
