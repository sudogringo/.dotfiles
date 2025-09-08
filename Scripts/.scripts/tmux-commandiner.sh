#!/bin/bash

# Check if a session name/command is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <session_name/command>"
    exit 1
fi

session_name="$1"
command_to_run="$1"

# Create a new tmux session and run the command
tmux new-session -A -s "$session_name" "$command_to_run"
