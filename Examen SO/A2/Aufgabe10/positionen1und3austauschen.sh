#!/bin/bash

filename="$1"

sed 's/\(\b[a-zA-Z]*\)\(\b[a-zA-Z]*\)\(\b[a-zA-Z]*\)/\3\2\1/g' "$filename"
