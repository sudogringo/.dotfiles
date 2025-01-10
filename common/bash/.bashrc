#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
#export PATH=$PATH:~/.local/bin/oh-my-posh

#PS1='[\u@\h \W]\$ '
_GREEN=$(tput setaf 2)
_BLUE=$(tput setaf 4)
_RESET=$(tput sgr0)
_RED=$(tput setaf 1)
_YELLOW=$(tput setaf 3)
_BOLD=$(tput bold)
#eval "$(oh-my-posh init bash --config ~/.config/oh-my-posh/half-life.omp.json)"
export PS1="\[$_BOLD\][\[$_RESET\]\[$_GREEN\]\u\[$_BLUE\]@\[$_RED\]\h\[$_RESET\]\[$_BOLD\]\w]\[$_RESET\]\[$_YELLOW\]\$ \[$_RESET\]"
#Bash Config
PROMPT_COMMAND='history -a'	# Immediatly persist commands
export HISTCONTROL=ignoreboth	# ignore duplicate and commands that start with space
#Exports
export EDITOR=vim
export VISUAL=nvim
export TERM=xterm-256color
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash

#Aliases
alias q='exit'
alias c='clear'
alias h='history'
alias cl='clear;ls'

#Navigation
alias home='cd ~'
alias root='cd /'
alias ..='cd ..'
alias ...='cd ..; cd ..'
alias ....='cd ..; cd ..; cd ..'
alias .....='cd ..; cd ..; cd ..; cd ..'
alias l.="ls -a | grep '^\.'"
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias cs='cs_func'
alias termhere='alacritty & disown'
alias okularhere='okular * & disown'

cs_func() {
    builtin cd "$@" && ls -la
}
#New files
alias new="/usr/bin/ls -lth | head -15"

#Journals
alias jornalSys='journalctl -f --system' #follow system journal

alias jornalUser='journalctl -f --user' #follow user journal

alias jornalBoot='journalctl -r -p 7 -b 0 --system' #this boot system problems

alias jornalBootPrior='journalctl -r -p 7 -b -1 --system' #this boot system problems

alias jornalBootUser='journalctl -r -p 7 -b 0 --user' #this boot my problems but just as a user on this computer. this wont list my deep-seated, life-crippling, psychological problems yet.

#Python
alias py='python3'

#Yay
alias yayupdate="yay -Syu --noconfirm"
alias pkglist='pacman -Qs --color=always | less -R'

#Adding flags
alias cp="cp -i"	#Confirm before overwrite
alias df='df -h'	#Human readable format

#Shutdown and Reboot
alias shtdwn="sudo shutdown now"
alias rbt="sudo reboot"

# Shortcuts to vimrc and bashrc
alias vimrc='nvim ~/.dotfiles/common/vim/.vimrc'
alias bashrc='nvim ~/.dotfiles/common/bash/.bashrc'
alias loadbash='source ~/.bashrc'

# Rofi
alias emoji='rofi -modi emoji -show emoji -emoji-mode copy'
alias wifi='/home/tiago/external/rofi-wifi-menu/rofi-wifi-menu.sh'

# Networking
 alias ipv4="ip addr show | grep 'inet ' | grep -v '127.0.0.1' | cut -d' ' -f6 | cut -d/ -f1"
alias ipv6="ip addr show | grep 'inet6 ' | cut -d ' ' -f6 | sed -n '2p'" 

# Created by `pipx` on 2024-12-09 22:52:18
export PATH="$PATH:/home/tiago/.local/bin"
