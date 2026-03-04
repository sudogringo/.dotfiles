#!/bin/bash

# Ensure necessary tools are installed
if ! command -v checkupdates >/dev/null 2>&1; then
    notify-send "Update Checker" "Error: 'pacman-contrib' not found." --icon=dialog-error
    exit 1
fi

if ! command -v notify-send >/dev/null 2>&1; then
    echo "Error: 'libnotify' not found. Install it to see desktop notifications."
    exit 1
fi

# Fetch updates silently
CHUP=$(checkupdates 2>/dev/null | grep -Ei 'discord|steam')

if [[ -n "$CHUP" ]]; then
    # Send a desktop notification with the list of updates
    notify-send "Fun Day Updates Found!" "$CHUP" --icon=software-update-available --urgency=normal
fi
