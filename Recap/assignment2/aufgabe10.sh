#!/bin/bash
if [ $# -lt 2 ]
then
	echo "Not enough arguments"
	exit 1

fi
fileName=$1
hersteller=$2
if [ ! -f "$fileName" ]
then
	echo "Not a file"
	exit 1
fi
if [[ $fileName != *".csv" ]]
then
	echo "Not a csv file"
	exit 1
fi
searched=($(grep -i -E "$hersteller" "$fileName"))
for prozessor in "${searched[@]}"; do
	if [[ "$prozessor" != *,*,0* ]]; then
    echo "Prozessor: $prozessor"
  fi
done
