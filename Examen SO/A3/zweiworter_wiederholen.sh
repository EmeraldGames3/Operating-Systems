#!/bin/bash

for filename in "$@"; do
  awk '{ 
    for(i=1; i<=NF; i++) {
      if (++count[$i] == 2) {
        print FILENAME, FNR, $i
        break
      }
    }
    delete count
  }' "$filename"
done
