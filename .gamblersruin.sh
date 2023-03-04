#!/bin/bash

# Set initial parameters
goal=1000
stake=1
win_prob=0.5
bankroll=50
num_trials=1000

# Define function to simulate one game
function simulate_game {
    outcome=$(echo "scale=0; $RANDOM / 32768 < $win_prob" | bc)
    if [ $outcome -eq 1 ]; then
        bankroll=$(($bankroll + $stake))
    else
        bankroll=$(($bankroll - $stake))
    fi
}

# Run simulations
wins=0
for ((i=1; i<=$num_trials; i++)); do
    while [ $bankroll -gt 0 ] && [ $bankroll -lt $goal ]; do
        simulate_game
    done
    if [ $bankroll -eq $goal ]; then
        wins=$(($wins + 1))
    fi
    bankroll=50
done

# Print results
echo "Win probability: $(echo "scale=2; $wins / $num_trials" | bc)"
