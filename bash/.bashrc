#                                    
# ,,                ,,               
# ||      _         ||               
# ||/|,  < \,  _-_, ||/\\ ,._-_  _-_ 
# || ||  /-|| ||_.  || ||  ||   ||   
# || |' (( ||  ~ || || ||  ||   ||   
# \\/    \/\\ ,-_-  \\ |/  \\,  \\,/ 
#                     _/             
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# --- History Config (XDG Compliant) ---
export HISTFILE="$XDG_STATE_HOME/bash/history"
mkdir -p "$(dirname "$HISTFILE")"
export HISTCONTROL=ignoreboth
export HISTSIZE=10000
export HISTFILESIZE=20000
shopt -s histappend
PROMPT_COMMAND='history -a'

# --- Shell Options ---
shopt -s autocd        # Type a directory name to cd into it
shopt -s cdspell       # Fix minor typos in cd commands
shopt -s checkwinsize  # Update LINES and COLUMNS after each command
shopt -s globstar      # Use ** to search recursively

# --- Prompt ---
_GREEN=$(tput setaf 2)
_BLUE=$(tput setaf 4)
_RESET=$(tput sgr0)
_RED=$(tput setaf 1)
_YELLOW=$(tput setaf 3)
_BOLD=$(tput bold)
export PS1="\[$_BOLD\][\[$_RESET\]\[$_GREEN\]\u\[$_BLUE\]@\[$_RED\]\h\[$_RESET\]\[$_BOLD\]\w]\[$_RESET\]\[$_YELLOW\]\$ \[$_RESET\]"

# --- External Tool Integration ---
# Wal
[[ -f ~/.cache/wal/sequences ]] && (cat ~/.cache/wal/sequences &)
[[ -f ~/.cache/wal/colors-tty.sh ]] && source ~/.cache/wal/colors-tty.sh
[[ -f "$HOME/.scripts/wal-way.sh" ]] && source "$HOME/.scripts/wal-way.sh"

# FZF
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash
eval "$(fzf --bash)"
export FZF_DEFAULT_COMMAND='fd . --hidden --exclude ".git, .cache"'

# Pyenv
if command -v pyenv >/dev/null; then
    eval "$(pyenv init -)"
fi

# --- Aliases ---
alias c='clear'
alias h='history'
alias cl='clear;ls'
alias ..='cd ..'
alias ...='cd ..; cd ..'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias cp="cp -i"
alias df='df -h'
alias vimrc='nvim ~/.vimrc'
alias bashrc='nvim ~/.bashrc'
alias loadbash='source ~/.bashrc'

# Function for immediate navigation + listing
cs() {
    builtin cd "$@" && ls -la
}

# Journal Aliases
alias journalSys='journalctl -f --system'
alias journalUser='journalctl -f --user'
alias journalBoot='journalctl -r -p 7 -b 0 --system'

# Networking
alias ipv4="ip addr show | grep 'inet ' | grep -v '127.0.0.1' | cut -d' ' -f6 | cut -d/ -f1"

# Wayland / Sway scripts
alias wifi="$HOME/.scripts/rofi-wifi-menu.sh"
alias wall="$HOME/.scripts/rofi-pywall.sh"
alias asd='$HOME/.scripts/tmux-sessionizer.sh'
