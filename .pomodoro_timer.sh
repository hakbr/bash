#!/bin/bash

echo "Enter the duration of the Pomodoro timer (in minutes):"
read duration
echo "Enter the duration of the break (in minutes):"
read break_duration
echo "Enter the number of cycles:"
read cycles

count=1
while [ $count -le $cycles ]
do
    mpg321 start.mp3 &> /dev/null &
    echo "Starting Pomodoro timer for cycle $count , $duration minutes..."
    for i in $(seq $duration -1 1); do
        printf "\r%02d:%02d" $((i/60)) $((i%60))
        sleep 60
    done
    printf "\r00:00\n"
    echo "Time's up!"
    mpg321 finish.mp3 &> /dev/null &
    echo "Take a $break_duration min break"

    for i in $(seq $break_duration -1 1); do
        printf "\r%02d:%02d" $((i/60)) $((i%60))
        sleep 60
    done

    printf "\r00:00\n"
    echo "Break's Over!"
    echo ""
    count=$((count + 1))
done
echo "Pomodoro session completed"
