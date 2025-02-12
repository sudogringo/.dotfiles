from libqtile.config import Key, Click, Drag
from libqtile.lazy import lazy

mod = "mod4"
alt = "mod1"
terminal = "alacritty"
browser = "firefox"
privatebrowser = "firefox --private-window"

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
    Key([mod], "w", lazy.spawn(browser), desc="Launch " + browser),
    Key([mod, "shift"], "w", lazy.spawn(privatebrowser), desc="Launch private" + browser),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([alt], "f4", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod, "control"],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    Key([mod], "f", lazy.window.bring_to_front(), desc="Bring to front"),

    # Qtile commands
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),

    # Rofi launch
    Key([mod, "control"], "Return", lazy.spawn('rofi -show drun'), desc="Spawn a command using a prompt widget"),
    
    # Brightness controls
    Key([], "XF86MonBrightnessUp", lazy.spawn("xbacklight +10"), desc="Raise Brightness"),
    Key([], "XF86MonBrightnessDown", lazy.spawn("xbacklight -10"), desc="Lower Brightness"),
    
    # Volume Controls
    Key([], "XF86AudioMicMute", lazy.spawn("wpctl set-mute @DEFAULT_SOURCE@ toggle"), desc="Mute audio"),
    Key([], "XF86AudioMute", lazy.spawn("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), desc="Mute audio"),
    Key([], "XF86AudioLowerVolume", lazy.spawn("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 10%-"), desc="Lower volume by 10%",),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 10%+"), desc="Raise volume by 10%",),

    # Display controls
    Key([mod], "XF86Display", lazy.spawn("arandr"), desc="Start Arandr for GUI display control.",),
    # want to add in the future auto switching of displays

    # Screenshot
    Key([], "Print", lazy.spawn("ksnip -r"), desc="Ksnip (screenshot) rectangle"),

    # Media controls
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause"), desc="Play/Pause player"),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next"), desc="Skip to next"),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous"), desc="Skip to previous"),

    # Display controls
    Key([mod], "XF86WLAN", lazy.spawn("home/tiago/external/rofi-wifi-menu/rofi-wifi-menu.sh'"), desc="Rofi wifi menu",),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

