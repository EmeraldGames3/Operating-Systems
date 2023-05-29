#!/bin/bash

if (($# != 7)); then
    echo "Invalid number of arguments"
    exit 1
fi

x1=$1
y1=$2

x2=$3
y2=$4

x3=$5
y3=$6

det=$((x1 * y2 + x2 * y3 + x3 * y1 - x3 * y2 - x1 * y3 - x2 * y1))

if ((det == 0)); then
    echo "Kollinear"
    exit 0
fi

absdet=$((det < 0 ? -det : det))
area=$(bc <<< "scale=2; $absdet / 2")
echo "Flächeninhalt ist $area"
exit 0
