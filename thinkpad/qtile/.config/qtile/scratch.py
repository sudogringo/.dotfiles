from libqtile.config import Group, ScratchPad, DropDown, Key
from libqtile.lazy import lazy
from groups import groups
from keys import keys
from colors import colours
from layouts import layout_theme

dropdown_config = {
    'x': 0.10,
    'y': 0.2,
    'width': 0.8,
    'height': 0.6,
    'opacity': 0.9,
    'on_focus_lost_hide': True
}

groups.extend([
    ScratchPad("scratchpad", [
        # define a drop down terminal.
        DropDown("term", "alacritty", **dropdown_config),
        DropDown("Spotify", "alacritty -e ncspot", **dropdown_config),
        DropDown("ranger", "alacritty -t Ranger -e ranger", **dropdown_config),
        DropDown("Volume", "pwvucontrol", **dropdown_config),
        ]),
])

keys.extend([
  Key([], 'F9', lazy.group['scratchpad'].dropdown_toggle('Spotify')),
  Key([], 'F10', lazy.group['scratchpad'].dropdown_toggle('term')),
  Key([], 'F11', lazy.group['scratchpad'].dropdown_toggle('ranger')),
  Key([], 'F12', lazy.group['scratchpad'].dropdown_toggle('Volume')),
])
