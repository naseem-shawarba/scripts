#!/bin/bash

# Check if a number was provided
if [ -z "$1" ]; then
    echo "Usage: ./organize_videos.sh [number_per_folder]"
    exit 1
fi

LIMIT=$1
folder_count=1
file_count=0

# Create the first folder
mkdir -p "$folder_count"

# Loop through common video files (adjust extensions as needed)
# Using find to handle spaces in filenames safely
find . -maxdepth 1 -type f \( -iname "*.mp4" -o -iname "*.mkv" -o -iname "*.avi" -o -iname "*.mov" \) | while read -r file; do
    
    # If we hit the limit, increment folder number and reset file counter
    if [ "$file_count" -eq "$LIMIT" ]; then
        ((folder_count++))
        file_count=0
        mkdir -p "$folder_count"
    fi

    # Move the file
    mv "$file" "$folder_count/"
    ((file_count++))
done

echo "Finished! Videos have been organized into folders."
