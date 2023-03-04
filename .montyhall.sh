#!/bin/bash

# Number of simulations to run
num_sims=10000

# Function to simulate a game
simulate_game() {
  # Choose a random door for the prize
  prize_door=$((1 + RANDOM % 3))

  # Choose a random door for the player's selection
  player_door=$((1 + RANDOM % 3))

  # Choose a door to reveal that doesn't have the prize and isn't the player's selection
  if [[ $prize_door -eq $player_door ]]; then
    # If the player chose the prize door, reveal one of the other doors at random
    reveal_door=$((1 + RANDOM % 2))
    if [[ $reveal_door -eq 1 ]]; then
      reveal_door=2
    else
      reveal_door=1
    fi
  else
    # If the player didn't choose the prize door, reveal the other door that doesn't have the prize
    for door in 1 2 3; do
      if [[ $door -ne $prize_door && $door -ne $player_door ]]; then
        reveal_door=$door
        break
      fi
    done
  fi

  # Switch or keep the player's original choice
  if [[ $1 == "switch" ]]; then
    # Switch to the other unopened door
    for door in 1 2 3; do
      if [[ $door -ne $player_door && $door -ne $reveal_door ]]; then
        player_door=$door
        break
      fi
    done
  fi

  # Determine if the player won or lost
  if [[ $player_door -eq $prize_door ]]; then
    result="win"
  else
    result="lose"
  fi

  # Return the result of the game
  echo $result
}

# Run the simulations with keeping the original choice
wins=0
losses=0
for (( i=1; i<=$num_sims; i++ )); do
  result=$(simulate_game "keep")
  if [[ $result == "win" ]]; then
    ((wins++))
  else
    ((losses++))
  fi
done
echo "Keep strategy: $wins wins and $losses losses"

# Run the simulations with switching the choice
wins=0
losses=0
for (( i=1; i<=$num_sims; i++ )); do
  result=$(simulate_game "switch")
  if [[ $result == "win" ]]; then
    ((wins++))
  else
    ((losses++))
  fi
done
echo "Switch strategy: $wins wins and $losses losses"
