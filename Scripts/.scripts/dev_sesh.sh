#!/bin/bash

# Define session name using the current working directory's basename
CWD=$(pwd)
SESSION_NAME=$(basename "$CWD" | tr . _)

# --- Check if the session already exists ---
# This check is technically redundant because the sessionizer does it,
# but it keeps the script runnable on its own.
tmux has-session -t $SESSION_NAME 2>/dev/null

if [ $? -eq 0 ]; then
    echo "Session '$SESSION_NAME' already exists. Attaching..."
    tmux attach-session -t $SESSION_NAME
    exit 0
fi

# --- Create a new session with the first window (Nvim) ---
echo "Creating new session '$SESSION_NAME' in $CWD..."
tmux new-session -d -s $SESSION_NAME -c $CWD

# 1. Window 1: Nvim (current directory)
tmux rename-window -t $SESSION_NAME:1 "nvim"
tmux send-keys -t $SESSION_NAME:nvim "nvim" C-m

# 2. Window 2: Ai Coding CLI
tmux new-window -t $SESSION_NAME:2 -c $CWD -n "Clanka"
tmux send-keys -t $SESSION_NAME:2 "opencode" C-m

# 3. Window 3: Lazygit (or just 'git')
tmux new-window -t $SESSION_NAME:3 -c $CWD -n "git"
tmux send-keys -t $SESSION_NAME:3 "lazygit" C-m

# 4. Window 4: Shell (General tasks)
tmux new-window -t $SESSION_NAME:4 -c $CWD -n "shell"

# --- Attach to the session and select the Nvim window ---
echo "Attaching to session '$SESSION_NAME'. Focus is on the nvim window."
tmux select-window -t $SESSION_NAME:1
tmux attach-session -t $SESSION_NAME
