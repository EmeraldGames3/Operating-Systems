#!/bin/bash

if [[ $# -lt 1 ]] || [[ $# -gt 2 ]]; then
    echo "Invalid number of arguments"
    exit 1
fi

n=$1

if [[ $n -le 1 ]]; then
    echo "Not prime"
    exit 0
fi

for ((i = 2; i <= n / 2; i++)); do
    if ((n % i == 0)); then
        echo "Not prime"
        exit 0
    fi
done

echo "Prime"
exit 0
