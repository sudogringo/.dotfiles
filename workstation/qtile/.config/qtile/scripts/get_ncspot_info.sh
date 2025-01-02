#!/bin/bash

# Run ncspot and get the current song information
ncspot_output=$(ncspot --now-playing)

# Extract the relevant information (adjust this based on the output format of ncspot)
song_info=$(echo "$ncspot_output" | grep -oP '(?<=Now playing: ).*')

# Output the song information
echo "$song_info"
