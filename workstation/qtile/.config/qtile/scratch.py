from libqtile.config import Group, ScratchPad, DropDown, Key
from libqtile.lazy import lazy
from groups import groups
from keys import keys
from colors import colours
from layouts import layout_theme

dropdown_config = {
    'x': 0.10,
    'y': 0.1,
    'width': 0.8,
    'height': 0.8,
    'opacity': 0.95,
    'on_focus_lost_hide': True
}

groups.extend([
    ScratchPad("scratchpad", [
        # define a drop down terminal.
        DropDown("term", "alacritty", **dropdown_config),
        DropDown("Spotify", "alacritty -e ncspot", **dropdown_config),
        # DropDown("ranger", "alacritty -t Ranger -e ranger", **dropdown_config),
        DropDown("Volume", "pwvucontrol", **dropdown_config),
        ]),
])

keys.extend([
  Key(["mod4"], 'F9', lazy.group['scratchpad'].dropdown_toggle('Spotify')),
  Key(["mod4"], 'F10', lazy.group['scratchpad'].dropdown_toggle('term')),
  # Key(["mod4"], 'F11', lazy.group['scratchpad'].dropdown_toggle('ranger')),
  Key(["mod4"], 'F12', lazy.group['scratchpad'].dropdown_toggle('Volume')),
])
