#!/bin/bash

read -p "Enter the desired audio format (mp3, opus, ogg): " audio_format

case $audio_format in
    "mp3") read -p "Enter the desired quality (0-9): " quality ;;
    "opus") read -p "Enter the desired bitrate for Opus (64k-256k): " bitrate
           read -p "Enter the desired compression level for Opus (0-10): " compression ;;
    "ogg") read -p "Enter the desired quality (0-9): " quality ;;
esac

read -p "Enter the input directory: " input_dir
read -p "Enter the output directory: " output_dir

if [ ! -d "$output_dir" ]; then
  mkdir -p "$output_dir"
fi

IFS=$'\n'
for file in $(find "$input_dir" \( -name '*.flac' -o -name '*.alac' -o -name '*.wav' \) -type f); do
    relative_path="$(dirname "${file#$input_dir}")"
    output_path="$output_dir/$relative_path"
    mkdir -p "$output_path"
    case $audio_format in
        "mp3") ffmpeg -i "$file" -q:a $quality -map a "$output_path/$(basename "${file%.*}").mp3";;
        "opus") ffmpeg -i "$file" -compression_level $compression -b:a $bitrate -vbr on "$output_path/$(basename "${file%.*}").opus";;
        "ogg") ffmpeg -i "$file" -q:a $quality -map a -c:a libvorbis "$output_path/$(basename "${file%.*}").ogg";;
    esac
done
