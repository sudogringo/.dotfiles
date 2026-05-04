#!/bin/sh

# Wal config for wayland
wal-way() {
    wal -a 92 --backend colorz -n --cols16 -q -i "$@"
    awww img "$(< "${HOME}/.cache/wal/wal")" --transition-type center
}
