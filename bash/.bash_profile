#
# ,,                ,,                              /\    ,,       
# ||      _         ||                             ||   ' ||       
# ||/|,  < \,  _-_, ||/\\       -_-_  ,._-_  /'\\ =||= \\ ||  _-_  
# || ||  /-|| ||_.  || ||       || \\  ||   || ||  ||  || || || \\ 
# || |' (( ||  ~ || || ||       || ||  ||   || ||  ||  || || ||/   
# \\/    \/\\ ,-_-  \\ |/       ||-'   \\,  \\,/   \\, \\ \\ \\,/  
#                     _/  _____ |/                                 
#

# --- XDG Base Directory Specification ---
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Ensure essential XDG directories exist
mkdir -p "$XDG_CONFIG_HOME" "$XDG_CACHE_HOME" "$XDG_DATA_HOME" "$XDG_STATE_HOME"

# Go
export GOPATH="$XDG_DATA_HOME/go"

# Python (Clean up the REPL history)
# Note: You need to create this file for it to work: mkdir -p ~/.config/python && touch ~/.config/python/pythonrc
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh

# Less history
export LESSHISTFILE="$XDG_STATE_HOME/less/history"
mkdir -p "$(dirname "$LESSHISTFILE")"

# Node/NPM
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
# export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc" # Uncomment if you move your npmrc

# --- Wayland / Sway Specifics ---
export MOZ_ENABLE_WAYLAND=1
export _JAVA_AWT_WM_NONREPARENTING=1
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_TYPE=wayland

# --- Environment Variables ---
export EDITOR='vim'
export VISUAL='nvim'
export TERM='screen-256color'
export JAVA_HOME="/usr/lib/jvm/java-21-openjdk"
export PYENV_ROOT="$HOME/.pyenv"

# --- PATH Construction ---
_add_to_path() {
    if [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH="$PATH:$1"
    fi
}

_add_to_path "$HOME/.local/bin"
_add_to_path "$HOME/.scripts"
_add_to_path "$GOPATH/bin"
_add_to_path "$PYENV_ROOT/bin"
unset -f _add_to_path

# --- Session Logic ---

# Weekend Fun Script (Login only)
case $(date +%u) in
    4|5|6)
        FLAG_FILE="$XDG_STATE_HOME/bash/weekend_fun_run"
        mkdir -p "$(dirname "$FLAG_FILE")"
        if [[ ! -f "$FLAG_FILE" ]]; then
            if [[ -f "$HOME/.dotfiles/Scripts/.scripts/weekendFun.sh" ]]; then
                # Run in background to not block login
                "$HOME/.dotfiles/Scripts/.scripts/weekendFun.sh" &
            fi
            touch "$FLAG_FILE"
        fi
        ;;
    *)
        rm -f "$XDG_STATE_HOME/bash/weekend_fun_run"
        ;;
esac

# Load interactive settings
[[ -f ~/.bashrc ]] && . ~/.bashrc
if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
  exec startx
fi
#if [ -f /etc/bash_completion ]; then
#    . /etc/bash_completion
#fi

# --- XDG Base Directory Specification ---
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Ensure essential XDG directories exist
mkdir -p "$XDG_CONFIG_HOME" "$XDG_CACHE_HOME" "$XDG_DATA_HOME" "$XDG_STATE_HOME"

# Go
export GOPATH="$XDG_DATA_HOME/go"

# Python (Clean up the REPL history)
# Note: You need to create this file for it to work: mkdir -p ~/.config/python && touch ~/.config/python/pythonrc
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"

# Less history
export LESSHISTFILE="$XDG_STATE_HOME/less/history"
mkdir -p "$(dirname "$LESSHISTFILE")"

# Node/NPM
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
# export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc" # Uncomment if you move your npmrc

# --- Wayland / Sway Specifics ---
export MOZ_ENABLE_WAYLAND=1
export _JAVA_AWT_WM_NONREPARENTING=1
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_TYPE=wayland

# --- Environment Variables ---
export EDITOR='vim'
export VISUAL='nvim'
export TERM='screen-256color'
export JAVA_HOME="/usr/lib/jvm/java-21-openjdk"
export PYENV_ROOT="$HOME/.pyenv"
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup

# --- PATH Construction ---
_add_to_path() {
    if [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH="$PATH:$1"
    fi
}

_add_to_path "$HOME/.local/bin"
_add_to_path "$HOME/.scripts"
_add_to_path "$GOPATH/bin"
_add_to_path "$PYENV_ROOT/bin"
unset -f _add_to_path

# --- Session Logic ---

# Weekend Fun Script (Login only)
case $(date +%u) in
    4|5|6)
        FLAG_FILE="$XDG_STATE_HOME/bash/weekend_fun_run"
        mkdir -p "$(dirname "$FLAG_FILE")"
        if [[ ! -f "$FLAG_FILE" ]]; then
            if [[ -f "$HOME/.dotfiles/Scripts/.scripts/weekendFun.sh" ]]; then
                # Run in background to not block login
                "$HOME/.dotfiles/Scripts/.scripts/weekendFun.sh" &
            fi
            touch "$FLAG_FILE"
        fi
        ;;
    *)
        rm -f "$XDG_STATE_HOME/bash/weekend_fun_run"
        ;;
esac

# Load interactive settings
[[ -f ~/.bashrc ]] && . ~/.bashrc
. "/home/tiago/.local/share/bob/env/env.sh"
