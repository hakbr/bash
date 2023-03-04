#!/bin/bash

# Get the input directory
read -p "Please enter the input directory: " input_dir

# Get the output directory
read -p "Please enter the output directory: " output_dir

# Get the codec
read -p "Please enter the codec (libx264 or libx265): " codec

# Get the target resolution
read -p "Please enter the target resolution (e.g. 720x480, 1280x720 or 1920x1080): " resolution

# Get the target bitrate
read -p "Please enter the target bitrate (e.g. 1000k, 2000k or 4000k): " bitrate

# Check if the input and output directories are provided
if [ -z "$input_dir" ] || [ -z "$output_dir" ]; then
    echo "Both input and output directories are required."
    exit 1
fi

# Check if codec is supported
if [ "$codec" != "libx264" ] && [ "$codec" != "libx265" ]; then
    echo "Codec is not supported, please enter either libx264 or libx265."
    exit 1
fi

# Create the output directory if it does not exist
if [ ! -d "$output_dir" ]; then
    mkdir -p "$output_dir"
    echo "Output directory created"
fi

# Save the current IFS
OLDIFS=$IFS
IFS=$'\0'

# Find all the video files in the input directory
for file in "$input_dir"/*; do
    # Get the filename without the path
    filename=$(basename "$file")

    # Use ffmpeg to convert the video file to the smaller size
    ffmpeg -i "$file" -s $resolution -b:v $bitrate -c:v $codec -c:a copy -map 0 -scodec copy -strict -2 "$output_dir/$filename"
done

# Print a message to confirm the process is complete
echo "Batch video conversion complete!"

# Reset the IFS
IFS=$OLDIFS
