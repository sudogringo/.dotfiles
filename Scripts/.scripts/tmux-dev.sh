#!/usr/bin/env bash
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/tmux"
CONFIG_FILE="$CONFIG_DIR/tmux-sessionizer.conf"

# --- Custom Script Definition ---
# This is the path to the script that creates the 4-window session
DEV_SESH_SCRIPT="$HOME/.scripts/dev_sesh.sh"
# --------------------------------

# test if the config file exists
if [[ -f "$CONFIG_FILE" ]]; then
    # shellcheck source=/dev/null
    source "$CONFIG_FILE"
fi

sanity_check() {
    if ! command -v tmux &>/dev/null; then
        echo "tmux is not installed. Please install it first. 😞"
        exit 1
    fi

    if ! command -v fzf &>/dev/null; then
        echo "fzf is not installed. Please install it first. 🔍"
        exit 1
    fi
}

switch_to() {
    if [[ -z $TMUX ]]; then
        tmux attach-session -t "$1"
    else
        tmux switch-client -t "$1"
    fi
}

has_session() {
    tmux list-sessions | grep -q "^$1:"
}

# The hydrate function for default single-window session is now deprecated
# since we are always using the custom script for new sessions.
# We'll just remove it or leave it unused for simplicity.

sanity_check

# Define search paths
[[ -n "$TS_SEARCH_PATHS" ]] || TS_SEARCH_PATHS=(~/ ~/Documents ~/.config ~/.dotfiles)

# Add any extra search paths
if [[ ${#TS_EXTRA_SEARCH_PATHS[@]} -gt 0 ]]; then
    TS_SEARCH_PATHS+=("${TS_EXTRA_SEARCH_PATHS[@]}")
fi

# Utility function to find directories
find_dirs() {
    # list TMUX sessions
    if [[ -n "${TMUX}" ]]; then
        current_session=$(tmux display-message -p '#S')
        tmux list-sessions -F "[TMUX] #{session_name}" 2>/dev/null | grep -vFx "[TMUX] $current_session"
    else
        tmux list-sessions -F "[TMUX] #{session_name}" 2>/dev/null
    fi

    for entry in "${TS_SEARCH_PATHS[@]}"; do
        if [[ "$entry" =~ ^([^:]+):([0-9]+)$ ]]; then
            path="${BASH_REMATCH[1]}"
            depth="${BASH_REMATCH[2]}"
        else
            path="$entry"
        fi

        [[ -d "$path" ]] && find "$path" -mindepth 1 -maxdepth "${depth:-${TS_MAX_DEPTH:-1}}" -path '*/.git' -prune -o -type d -print
    done
}

# --- FZF SELECTION ---
if [[ $# -eq 1 ]]; then
    selected="$1"
else
    # Use fzf to select a path or an existing session
    selected=$(find_dirs | fzf)
fi

if [[ -z $selected ]]; then
    exit 0
fi

# Process fzf selection: If it's an existing TMUX session, capture the name
if [[ "$selected" =~ ^\[TMUX\]\ (.+)$ ]]; then
    selected_name="${BASH_REMATCH[1]}"
    
    # Switch directly to the existing session
    switch_to "$selected_name"
    exit 0
fi

# If we reached this point, $selected is a directory path.
selected_name=$(basename "$selected" | tr . _)

# -----------------------------------------------------
## New Session Creation Logic (The Dev Environment)
# -----------------------------------------------------

# 1. Check if a session for this project already exists
if has_session "$selected_name"; then
    switch_to "$selected_name"
    exit 0
fi

# 2. If session does NOT exist, create it using the custom script.
echo "Creating new specialized session '$selected_name' in $selected..."

# Change directory to the selected path and execute the custom script.
# The custom script handles the session creation (new-session), window setup, and final attachment.
(cd "$selected" && "$DEV_SESH_SCRIPT")

# The dev_sesh.sh script should ideally be updated to use the selected_name
# instead of its hardcoded "dev" session name.

# NOTE on the dev_sesh.sh script:
# Ensure your ~/.scripts/dev_sesh.sh script is modified to accept the 
# selected project name as an argument and use that for the session name,
# or simply modify the script to always use the current directory's basename 
# for the session name, which the updated logic above handles automatically.
