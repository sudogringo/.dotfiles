#
# ~/.bash_profile
#
[[ -f ~/.bashrc ]] && . ~/.bashrc
if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
  exec startx
fi
#if [ -f /etc/bash_completion ]; then
#    . /etc/bash_completion
#fi

# Created by `pipx` on 2024-12-09 22:52:18
export PATH="$PATH:/home/tiago/.local/bin"
