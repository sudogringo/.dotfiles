#!/bin/sh
# change wallpaper and colors with pywal

source ${HOME}/.scripts/wal-way.sh

WALLPAPERDIR=/home/tiago/.dotfiles/common/Wallpapers/Pictures/Wallpapers/

if [ -z "$@" ]; then
    # Use Rofi to select a wallpaper
    THEME=$(PREVIEW=true rofi -theme wallpaper.rasi -show filebrowser -filebrowser-command 'echo' -filebrowser-directory ${WALLPAPERDIR})

    if [ -n "$THEME" ]; then
        wal-way "$THEME"
    fi
else
    THEMES=$@
    if [ "current" = "${THEMES}" ]
    then
	exit 0
        # wal -i `cat ~/.cache/wal/wal` > /dev/null #Allows you to just stay with current theme
    elif [ -n "${THEMES}" ]
    then
        wal-way "${THEMES}"
    fi
fi

