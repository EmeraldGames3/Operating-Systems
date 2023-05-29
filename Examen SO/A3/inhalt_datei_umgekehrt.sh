#!/bin/bash

for filename in "$@"; do
  tac "$filename"
done

