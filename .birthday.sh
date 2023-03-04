#!/bin/bash

# Get input from user
echo "Enter number of people in the group:"
read n

# Calculate probability of no shared birthday
prob=1
for (( i=1; i<=$n; i++ )); do
    prob=$(echo "scale=10; $prob * (365-$i+1)/365" | bc)
done
prob=$(echo "scale=10; 1 - $prob" | bc)

# Calculate probability of shared birthday
prob_shared=$(echo "scale=10; 1 - $prob" | bc)

# Print results
echo "Probability of no shared birthday: $prob"
echo "Probability of shared birthday: $prob_shared"
