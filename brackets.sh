#!/bin/bash

OPENING="{[(<"
ENDING="}])>"

read -p "Your code in here: " chain

openings=0
index=()
seen=0

chain_chars=($(echo "$chain" | fold -w1))

for c in "${chain_chars[@]}"; do
    seen=$((seen + 1))

    c_op=false
    if [[ "$OPENING" == *"$c"* ]]; then
        c_op=true
    fi
    
    c_ed=false
    if [[ "$ENDING" == *"$c"* ]]; then
        c_ed=true
    fi

    if $c_op; then
        openings=$((openings + 1))
        index+=($(expr index "$OPENING" "$c"))
    fi
    if $c_ed; then
        if [[ $openings -lt 1 ]] || [[ ${index[-1]} -ne $(expr index "$ENDING" "$c") ]]; then
            echo "Bad!!"
            exit 1
        fi
        openings=$((openings - 1))
        index=("${index[@]:0:${#index[@]}-1}")
    fi

    percentage=$(echo "scale=2; 100*$seen/${#chain_chars[@]}" | bc)
    echo "$c ${percentage}%"
done

if [[ $openings -ne 0 ]]; then
    echo "Bad!!"
    exit 1
fi

echo "Good!!"
