#!/bin/sh

# Wal config for wayland
wal-way() {
    wal -n -i "$@"
    swww img "$(< "${HOME}/.cache/wal/wal")" --transition-type center
}
