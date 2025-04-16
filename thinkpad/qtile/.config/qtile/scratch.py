from libqtile.config import Group, ScratchPad, DropDown, Key
from libqtile.lazy import lazy
from groups import groups
from keys import keys
from colors import colours
from layouts import layout_theme

dropdown_config = {
    'x': 0.10,
    'y': 0.05,
    'width': 0.8,
    'height': 0.9,
    'opacity': 0.95,
    'on_focus_lost_hide': False
}

groups.extend([
    ScratchPad("scratchpad", [
        # define a drop down terminal.
        DropDown("term", "alacritty", **dropdown_config),
        ]),
])

keys.extend([
  Key(["mod4"], 'F10', lazy.group['scratchpad'].dropdown_toggle('term')),
])
