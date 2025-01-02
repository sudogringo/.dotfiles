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

