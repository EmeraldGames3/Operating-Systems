#!/bin/bash

echo "Please enter a number:"
read number

if ! [[ "$number" =~ ^[0-9]+$ ]]; then
    echo "Invalid input. You must enter a positive number."
    exit 1
fi

prime=true

if [ $number -lt 0 ]; then
    echo "You should not enter negative numbers"
    exit 64
fi

if [ $number -le 1 ]; then
    echo "not prime"
    exit 0
fi

for ((i=2; i<number; i++)); do
    if [ $((number % i)) -eq 0 ]; then
        echo "not prime"
        prime=false
        break
    fi
done

if $prime; then
    echo "prime"
fi

exit 0

