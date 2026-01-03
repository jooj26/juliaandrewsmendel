#!/bin/bash

# Create medium directory if it doesn't exist
mkdir -p images/medium

# Process each image in the images directory
for img in images/*.jpg; do
    if [ -f "$img" ]; then
        filename=$(basename "$img")
        convert "$img" -resize 800x800\> -quality 85 "images/medium/$filename"
        echo "Processed: $filename"
    fi
done 