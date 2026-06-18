mkdir -p "$XDG_CACHE_HOME/zsh"
HISTFILE="$XDG_CACHE_HOME/zsh/history"
HISTSIZE=10000
SAVEHIST=10000
bindkey -v
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^y' autosuggest-accept
bindkey '^n' fzf-tab-complete

# zstyle :compinstall filename '/home/tiago/.zshrc'

# load modules
zmodload zsh/complist
autoload -U compinit && compinit
autoload -U colors && colors

# cmp opts
zstyle ':completion:*' menu select # tab opens cmp menu
zstyle ':completion:*' special-dirs true # force . and .. to show in cmp menu
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} ma=0\;33 # colorize cmp menu
# zstyle ':completion:*' file-list true # more detailed list
zstyle ':completion:*' squeeze-slashes false # explicit disable to allow /*/ expansion

# main opts
setopt append_history inc_append_history share_history # better history
setopt hist_ignore_dups hist_ignore_space # no consecutive dupes, ignore cmds starting with space
setopt auto_menu menu_complete # autocmp first menu match
setopt autocd # type a dir to cd
setopt auto_param_slash # when a dir is completed, add a / instead of a trailing space
setopt no_case_glob no_case_match # make cmp case insensitive
setopt globdots # include dotfiles
setopt extended_glob # match ~ # ^
setopt interactive_comments # allow comments in shell
setopt prompt_subst # allow command substitution in prompt
unsetopt prompt_sp # don't autoclean blanklines
# stty stop undef # disable accidental ctrl s

# binds
# bindkey "^a" beginning-of-line
# bindkey "^e" end-of-line
# bindkey "^k" kill-line
# bindkey "^j" backward-word
# bindkey "^k" forward-word
# bindkey "^H" backward-kill-word
# # ctrl J & K for going up and down in prev commands
# bindkey "^J" history-search-forward
# bindkey "^K" history-search-backward
# bindkey '^R' fzf-history-widget


# fzf setup
source <(fzf --zsh) # allow for fzf history widget

# zoxide
eval "$(zoxide init zsh)"

# set up prompt
NEWLINE=$'\n'
_vim_mode_indicator() {
    if [[ $KEYMAP == vicmd ]]; then
        echo "%F{19}[N]%f"
    else
        echo "%F{3}[I]%f"
    fi
}
zle-keymap-select() { zle reset-prompt }
zle-line-init() { zle reset-prompt }
zle -N zle-keymap-select
zle -N zle-line-init
PROMPT="%K{18}%F{7} %n %K{19} %1~ %f%k \$(_vim_mode_indicator) ❯ "

# fzf-tab (must be sourced before autosuggestions and syntax-highlighting)
# requires fzf-tab
source /usr/share/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh
zstyle ':fzf-tab:*' fzf-bindings 'ctrl-y:accept' 'ctrl-space:toggle+down'

# autosuggestions
# requires zsh-autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# syntax highlighting
# requires zsh-syntax-highlighting package
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# pywal
source "${HOME}/.scripts/wal-way.sh"
(cat ~/.cache/wal/sequences &)
source ~/.cache/wal/colors-tty.sh

# fzf
export FZF_DEFAULT_COMMAND='fd . --hidden --exclude ".git" --exclude ".cache"'
export FZF_ALT_C_OPTS="
  --walker-skip .cache,.local,.git,node_modules,target
  --preview 'tree -C {}'"
export FZF_CTRL_T_OPTS="
  --walker-skip .cache,.local,.git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# aliases
alias c='clear'
alias h='history'
alias cl='clear;ls'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias cp='cp -i'
alias df='df -h'

# navigation
alias ..='cd ..'
alias ...='cd ../..';
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias l.="ls -a | grep '^\\.'"

cs_func() { builtin cd "$@" && ls -la }
alias cs='cs_func'
alias termhere='alacritty & disown'

# files
alias new="/usr/bin/ls -lth | head -15"

# journals
alias journalSys='journalctl -f --system'
alias journalUser='journalctl -f --user'
alias journalBoot='journalctl -r -p 7 -b 0 --system'
alias journalBootPrior='journalctl -r -p 7 -b -1 --system'
alias journalBootUser='journalctl -r -p 7 -b 0 --user'

# python
alias py='python3'

# yay
alias yayupdate='yay -Syu --noconfirm'
alias pkglist='pacman -Qs --color=always | less -R'

# power
alias shtdwn='sudo shutdown now'
alias rbt='sudo reboot'

# config shortcuts
alias vimrc='nvim ~/.vimrc'
alias zshrc="nvim \${ZDOTDIR:-\$HOME}/.zshrc"
alias loadzsh="source \${ZDOTDIR:-\$HOME}/.zshrc"

# rofi
alias emoji='rofi -modi emoji -show emoji -emoji-mode copy'
alias wifi="${HOME}/.scripts/rofi-wifi-menu.sh"
alias wall="${HOME}/.scripts/rofi-pywall.sh"

# networking
alias ipv4="ip addr show | grep 'inet ' | grep -v '127.0.0.1' | cut -d' ' -f6 | cut -d/ -f1"
alias ipv6="ip addr show | grep 'inet6 ' | cut -d ' ' -f6 | sed -n '2p'"
alias wake='wol dc:0e:a1:8a:32:da'

# tmux
alias asd="${HOME}/.scripts/tmux-sessionizer.sh"
alias tn="${HOME}/.scripts/tmux-commandiner.sh"
alias music='tmux new-session -A -s Music "ncspot"'
alias devme="${HOME}/.scripts/dev_sesh.sh"
alias dev="${HOME}/.scripts/tmux-dev.sh"
