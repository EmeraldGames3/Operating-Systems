#!/bin/bash

customer_name="$1"

if [ -f "$customer_name.csv" ]; then
    total_expenses=0
    
    while IFS=',' read -r transaction_type transaction_name amount; do
        if [ "$transaction_type" = "OUT" ]; then
            total_expenses=$((total_expenses + amount))
        fi
    done < "$customer_name.csv"
    
    echo "Die monatlichen Ausgaben des Kunden $customer_name betragen: $total_expenses"
else
    echo "Die Datei für den Kunden $customer_name wurde nicht gefunden."
fi
