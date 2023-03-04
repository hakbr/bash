#!/bin/bash

echo "7 minutes. This length allows for a soft, runny yolk and firm white."
echo "8 minutes. The yolk is jammy and soft but not liquid."
echo "10 minutes. The eggs are mostly cooked through but slightly soft in the center."
echo "12–13 minutes. This amount of time will result in fully hard-boiled eggs that are not over-cooked."

read -p "Enter the duration of the timer in minutes: " duration

echo "Timer started for $duration minutes"

# Convert minutes to seconds
duration=$((duration * 60))

# Start the timer
for ((i=$duration; i>=0; i--)); do
    # Print the remaining time in minutes and seconds
    printf "\rTime remaining: %02d:%02d" $((i/60)) $((i%60))
    sleep 1
done

# Play the mp3 file
mplayer /home/hallvor/bell.mp3

echo "Your eggs are ready! Cool down the eggs to halt the cooking process."
