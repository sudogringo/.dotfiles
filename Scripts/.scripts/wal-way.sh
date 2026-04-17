#!/bin/sh

# Wal config for wayland
wal-way() {
    wal --backend colorz -n -q -i "$@"
    awww img "$(< "${HOME}/.cache/wal/wal")" --transition-type center
}
