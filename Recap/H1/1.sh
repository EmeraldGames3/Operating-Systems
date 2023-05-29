#!/bin/bash

# Current folder
current_folder=$(pwd)

# Find files with write permissions for "others" and display filenames
find "$current_folder" -type f -perm /o=w -printf "%f\n"
