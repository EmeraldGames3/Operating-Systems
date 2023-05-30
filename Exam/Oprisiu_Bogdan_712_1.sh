#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Invalid number of arguments"
  exit 1
fi

directory=$1

file_list=($(find "$directory" -type f -name "*"))
d_list=($(find "$directory" -type d -name "*"))

total_files=0
total_directories=0

for file in "${file_list[@]}"; do
	lines=1
	total_files=$((total_files + lines))
done

for d in "${d_list[@]}"; do
	lines=1
	total_directories=$((total_directories + lines))
done

echo "Total files: $total_files"
echo "Total directories: $total_directories"
