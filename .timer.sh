#!/bin/bash

# Get user input for the number of rounds, minutes per round, and seconds between rounds
echo "Enter the number of rounds: "
read rounds
echo "Enter the number of minutes per round: "
read minutes
echo "Enter the number of seconds between rounds: "
read between_rounds

# Calculate the total number of seconds per round
total_seconds=$((minutes * 60))

# Run the round timer
for (( i=1; i<=rounds; i++ )); do
  # Play the start of round audio file
  mplayer bell.mp3

  # Run the countdown timer for the current round
  while [ $total_seconds -gt 0 ]; do
    # Print the current time remaining as ASCII art
    printf "Round $i: "
    figlet -f standard -c "$((total_seconds/60)):$((total_seconds%60))"

    # Play a sound ten seconds before the end of the round
    if [ $total_seconds -eq 10 ]; then
      mplayer bell.mp3
    fi

    # Sleep for one second
    sleep 1

    # Decrement the total number of seconds by 1
    total_seconds=$((total_seconds - 1))
  done

  # Play the end of round audio file
  mplayer bell.mp3

  # Reset the total number of seconds for the next round
  total_seconds=$((minutes * 60))

  # Sleep for the specified number of seconds between rounds
  sleep $between_rounds
done

# Print a message when the timer is finished
echo "Time's up!"
