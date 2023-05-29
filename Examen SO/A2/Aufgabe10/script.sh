#!/bin/bash

search="$1"
filename="stoc.csv"

grep -i "$search" "$filename" | grep -v ",0$"
