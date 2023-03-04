#!/bin/bash

# prompt the user to set the directory path where the files are located
read -p "Enter the directory path where the files are located: " dir

# prompt the user to set the pattern to match against in the filenames
read -p "Enter the pattern to match against in the filenames: " pattern

# loop through all the files in the directory
for file in "$dir"/*
do
  # check if the filename matches the pattern
  if [[ $file == *$pattern* ]]
  then
    # prompt the user to set the new string to replace the old string in the filename
    read -p "Enter the new string to replace '$pattern' in '$file': " newstring

    # replace the old string with the new string in the filename
    newfile=$(echo $file | sed "s/$pattern/$newstring/g")

    # rename the file
    mv "$file" "$newfile"

    # print a message to the console indicating that the file has been renamed
    echo "Renamed $file to $newfile"
  fi
done
