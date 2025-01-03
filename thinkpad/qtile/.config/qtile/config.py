"""
qtile Config
By Tiago 'Yankee' Cunto
"""

from libqtile import bar, layout, qtile, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from libqtile.widget import Battery, Backlight, volume
from libqtile.widget.battery import Battery, BatteryState
#from libqtile.widget.backlight import ChangeDirection
import os
import sys
import subprocess

@hook.subscribe.startup
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.Popen([home])

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostartOnce.sh')
    subprocess.Popen([home])

defMargin = 10
mod = "mod4"
alt = "mod1"
terminal = "alacritty"
browser = "firefox"
icon_font_size = 22

# Colours
theme = dict(
    foreground="#CFCCD6",
    background="#0C1F20",
    color0="#030405",
    color8="#1f1c32",
    color1="#8742a5",
    color9="#9a5eb3",
    color2="#406794",
    color10="#5fd75f",
    color3="#653c21",
    color11="#6e9fcd",
    color4="#8f4ff0",
    color12="#BBC2E2",
    color5="#5d479d",
    color13="#998dd1",
    color6="#3e3e73",
    color14="#9a9dcc",
    color7="#495068",
    color15="#e1e1e4",
)

colours = [theme[f"color{n}"] for n in range(16)]
background = theme["background"]
foreground = theme["foreground"]
colour_focussed = "#6fa3e0"
colour_unfocussed = "#0e101c"
inner_gaps = 8
outer_gaps = 0

# https://coolors.co/1b2021-cfccd6-bbc2e2-b7b5e4-847979


#bklight =
keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    Key([mod, "shift"], "space", lazy.layout.previous(), desc="Move window focus to previous window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "i", lazy.spawn(browser), desc="Launch " + browser),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([alt], "f4", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawn('rofi -show combi "window,drun"'), desc="Spawn a command using a prompt widget"),
    #Key([mod], "f6", lazy.widget["Backlight"].change_backlight(backlight.ChangeDirection.UP), desc="Raise Brightness"),
    #Key([mod], "f5", lazy.widget["Backlight"].change_backlight(backlight.ChangeDirection.DOWN), desc="Lower Brightness"),
    
    # Brightness controls
    Key([], "XF86MonBrightnessUp", lazy.spawn("xbacklight +10"), desc="Raise Brightness"),
    Key([], "XF86MonBrightnessDown", lazy.spawn("xbacklight -10"), desc="Lower Brightness"),
    
    # Volume Controls
    Key([], "XF86AudioMicMute", lazy.spawn("pactl set-source-mute @DEFAULT_SOURCE@ toggle"), "Mute audio"),
    Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle"), "Mute audio"),
    Key(
        [],
        "XF86AudioLowerVolume",
        lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -10%"), "Lower volume by 10%",
    ),
    Key(
        [],
        "XF86AudioRaiseVolume",
        lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +10%"), "Raise volume by 10%",
    ),

    # Display controls
    Key([mod], "XF86Display", lazy.spawn("arandr"), "Start Arandr for GUI display control.",),
    #Key([], "XF86Display", lazy.spawn("arandr"), "Start Arandr for GUI display control.",),
    
    # screenshot
    Key([mod], "Print", lazy.spawn("ksnip -r"), desc="Screenshot"),
    Key([mod, "control"], "Print", lazy.spawn("ksnip -f"), desc="Screenshot"),
]

# Add key bindings to switch VTs in Wayland.
# We can't check qtile.core.name in default config as it is loaded before qtile is started
# We therefore defer the check until the key binding is run by using .when(func=...)
for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )


groups = [Group(i) for i in "12345"]

for i in groups:
    keys.extend(
        [
            # mod + group number = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod + shift + group number = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod + shift + group number = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

layouts = [
    #layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4),
    layout.Columns(),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    layout.MonadTall(margin=defMargin),
    layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    layout.Zoomy(margin=defMargin),
]

widget_defaults = dict(
    font="Terminess Nerd Font",
    fontsize=16,
    padding=20,
)

screens = [
    Screen(
        #top=bar.Bar([],18,),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# xcursor theme (string or None) and size (integer) for Wayland backend
wl_xcursor_theme = None
wl_xcursor_size = 24

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
