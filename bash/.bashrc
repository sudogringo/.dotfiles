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
export FZF_ALT_C_OPTS="
  --walker-skip .cache,.local,.git,.wine,.cargo,node_modules,target
  --preview 'tree -C {}'"

export FZF_CTRL_T_OPTS="
  --walker-skip .cache,.local,.git,.wine,.cargo,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# Pyenv
if command -v pyenv >/dev/null; then
    eval "$(pyenv init -)"
fi

# --- Aliases ---
alias c='clear'
alias h='history'
alias cl='clear;ls'

# Navigation
alias ..='cd ..'
alias ...='cd ..; cd ..'
alias ....='cd ..; cd ..; cd ..'
alias .....='cd ..; cd ..; cd ..; cd ..'
alias home='cd ~'
alias root='cd /'
alias l.="ls -a | grep '^\.'"
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias cp="cp -i"
alias df='df -h'
alias termhere='alacritty & disown'
alias okularhere='okular * & disown'

# New files
alias new="/usr/bin/ls -lth | head -15"

# Shortcuts to vimrc and bashrc
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
alias journalBootPrior='journalctl -r -p 7 -b -1 --system'
alias journalBootUser='journalctl -r -p 7 -b 0 --user'

# Networking
alias ipv4="ip addr show | grep 'inet ' | grep -v '127.0.0.1' | cut -d' ' -f6 | cut -d/ -f1"
alias ipv6="ip addr show | grep 'inet6 ' | cut -d ' ' -f6 | sed -n '2p'"
alias wake="wol dc:0e:a1:8a:32:da"

# Wayland / Sway scripts
alias wifi="$HOME/.scripts/rofi-wifi-menu.sh"
alias wall="$HOME/.scripts/rofi-pywall.sh"
alias emoji='rofi -modi emoji -show emoji -emoji-mode copy'

# Tmux
alias asd='$HOME/.scripts/tmux-sessionizer.sh'
alias tn='$HOME/.scripts/tmux-commandiner.sh'
alias music='tmux new-session -A -s Music "ncspot"'
alias devme='$HOME/.scripts/dev_sesh.sh'
alias dev='$HOME/.scripts/tmux-dev.sh'

# Other
alias py='python3'
alias yayupdate="yay -Syu --noconfirm"
alias pkglist='pacman -Qs --color=always | less -R'
alias rsauto="redshift -l -34.5:-68.5 -o"
alias rsoff="redshift -l -34.5:-68.5 -x"
alias rson="redshift -l -34.5:-68.5 -O 4500K"
alias shtdwn="sudo shutdown now"
alias rbt="sudo reboot"

# Prevent gentle-ai from self-updating (OPSX fork)
export GENTLE_AI_NO_SELF_UPDATE=1
