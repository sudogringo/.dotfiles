# from colors import colours
from colors import colours, background, foreground, colour_focussed, colour_unfocussed
from libqtile import qtile, bar
# from libqtile import widget
from libqtile.lazy import lazy
from libqtile.config import Screen
# Make sure 'qtile-extras' is installed or this config will not work.
from qtile_extras import widget
from qtile_extras.widget.decorations import BorderDecoration
import subprocess

widget_defaults = dict(
    font="Ubuntu Mono",
    fontsize=16,
    padding=10,
    linewidth=1,
    foreground=foreground,
)

extension_defaults = widget_defaults.copy()

def open_calendar(qtile):
    qtile.spawn('firefox --new-window calendar.google.com')

class ClickClock(widget.Clock):
    defaults = [
        (
            "long_format",
            "%d/%m/%y | %H:%M",
            "Format to show when widget is clicked."
        )
    ]

    def __init__(self, **config):
        widget.Clock.__init__(self, **config)
        self.add_defaults(ClickClock.defaults)
        self.short_format = self.format
        self.add_callbacks(
            {
                #"Button1": open_calendar
            }
        )

    def changeFormat(self):
        lazy.spawn("alacritty")
        if self.format == self.short_format:
            self.format = self.long_format
        else:
            self.format = self.short_format

    def mouse_enter(self, *args, **kwargs):
        self.format = self.long_format
        self.bar.draw()

    def mouse_leave(self, *args, **kwargs):
        self.format = self.short_format
        self.bar.draw()

class ModdedBrightness(widget.Backlight):
    def __init__(self, **config):
        super().__init__(**config)
        self.update_interval = 5  # Update every 5 seconds

    def poll(self):
        try:
            percent = self._get_info() * 100
        except RuntimeError as e:
            return f"Error: {e}"

        return self.format.format(percent=percent)

class NcspotWidget(widget.GenPollText):
    def __init__(self, **config):
        super().__init__(**config)
        self.update_interval = 5  # Update every 5 seconds

    def poll(self):
        try:
            # Run the script to get the current song information
            result = subprocess.run(['/home/tiago/.config/qtile/scripts/get_ncspot_info.sh'], capture_output=True, text=True)
            song_info = result.stdout.strip()
            return song_info
        except Exception as e:
            return f"Error: {e}"

underline = 3

screens = [
    Screen(
        # wallpaper="$HOME/.dotfiles/Wallpapers/*",
        # layout, groups, title of active, spotify (cmus), caps, chord, volume, keyboard, ram, cpu, conexion, time
        # widget box [freeHD, updates, temp]
        top=bar.Bar([
            widget.GroupBox(
                padding=2,
                font="Ubuntu Mono",
                fontsize=16,
                linewidth=1,
                foreground=foreground,
                background=colours[13],
                highlight_method="line",
                highlight_color=[colours[1],colours[9]],
                this_current_screen_border=colours[0],
                inactive=colours[12],
                disable_drag=True,
            ), 
            widget.WindowName(
                **widget_defaults,
                mouse_callbacks={
                    "Button1":lazy.spawn("rofi -show window")
                },
            ),
            widget.CurrentLayoutIcon(
                scale=0.8,
                **widget_defaults,
            ),
            ModdedBrightness(
                **widget_defaults,
                # format='{(percent*100):.0f}',
                format='{percent:3.0f}',
                fmt = '󰃠  {}%',
                backlight_name='intel_backlight',
                brightness_file='actual_brightness',
                width=widget_defaults["fontsize"] * 5,
                mouse_callbacks={
                    "Button1":lazy.spawn("rson"),
                    "Button2":lazy.spawn("rsoff")
                },
                decorations=[
                     BorderDecoration(
                         colour = colours[9],
                         border_width = [0, 0, underline, 0],
                     )
                 ],
            ),
            widget.Wlan(
                **widget_defaults,
                interface='wlp4s0',
                format='{essid} {percent:2.0%}',
                decorations=[
                     BorderDecoration(
                         colour = colours[10],
                         border_width = [0, 0, underline, 0],
                     )
                 ],
            ),
            widget.KeyboardLayout(
                **widget_defaults,
                configured_keyboards=['us', 'es'],
                decorations=[
                     BorderDecoration(
                         colour = colours[11],
                         border_width = [0, 0, underline, 0],
                     )
                 ],
            ),
            widget.Memory(
                **widget_defaults,
                format='{MemPercent:>2.0f}',
                fmt = 'RAM: {} %',
                mouse_callbacks = {'Button1': lambda: qtile.spawn('alacritty -e htop')},
                decorations=[
                     BorderDecoration(
                         colour = colours[12],
                         border_width = [0, 0, underline, 0],
                     )
                 ],
            ),
            widget.CPU(
                **widget_defaults,
                #width=200,
                #padding=20,
                format='{load_percent:>2.0f}',
                fmt = 'CPU: {} %',
                decorations=[
                     BorderDecoration(
                         colour = colours[3],
                         border_width = [0, 0, underline, 0],
                     )
                 ],
            ),
            widget.BatteryIcon(
                **widget_defaults,
                scale=1.5,
                theme_path="/usr/share/icons/Papirus/16x16/panel",
                decorations=[
                     BorderDecoration(
                         colour = colours[14],
                         border_width = [0, 0, underline, 0],
                     )
                ],
            ),
            widget.Battery(
                **widget_defaults,
                format='[{char}] {percent:2.0%}',
                decorations=[
                     BorderDecoration(
                         colour = colours[14],
                         border_width = [0, 0, underline, 0],
                     )
                ],
            ),
            ClickClock(
                **widget_defaults,
                mouse_callbacks={
                    "Button3":lazy.function(open_calendar)
                    },
                decorations=[
                     BorderDecoration(
                         colour = colours[15],
                         border_width = [0, 0, underline, 0],
                     )
                ],
            ),
        ],
        size=28,
        background=[background],
        ),
    ),
]
