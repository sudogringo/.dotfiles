"""
 ________  _________  ___  ___       _______               
|\   __  \|\___   ___\\  \|\  \     |\  ___ \              
\ \  \|\  \|___ \  \_\ \  \ \  \    \ \   __/|             
 \ \  \\\  \   \ \  \ \ \  \ \  \    \ \  \_|/__           
  \ \  \\\  \   \ \  \ \ \  \ \  \____\ \  \_|\ \          
   \ \_____  \   \ \__\ \ \__\ \_______\ \_______\         
    \|___| \__\   \|__|  \|__|\|_______|\|_______|         
          \|__|                                            
                                                           
                                                           
 ________  ________  ________   ________ ___  ________     
|\   ____\|\   __  \|\   ___  \|\  _____\\  \|\   ____\    
\ \  \___|\ \  \|\  \ \  \\ \  \ \  \__/\ \  \ \  \___|    
 \ \  \    \ \  \\\  \ \  \\ \  \ \   __\\ \  \ \  \  ___  
  \ \  \____\ \  \\\  \ \  \\ \  \ \  \_| \ \  \ \  \|\  \ 
   \ \_______\ \_______\ \__\\ \__\ \__\   \ \__\ \_______\
    \|_______|\|_______|\|__| \|__|\|__|    \|__|\|_______|
                                                           
By Tiago 'Yankee' Cunto

Check integrity of config: qtile check
config ACTIVE location: $HOME/.config/qtile/config.py
logfile: ~/.local/share/qtile/qtile.log
"""

from libqtile import bar, qtile, widget, hook
from libqtile.lazy import lazy
from keys import keys, mod, mouse
from groups import groups
from layouts import layouts, floating_layout
from scratch import groups, keys
from screen import screens
import os
import subprocess
"""
@hook.subscribe.startup
def autostart():
    home = os.path.expanduser('~/.config/qtile/scripts/autostart.sh')
    subprocess.Popen([home])

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/scripts/autostartOnce.sh')
    subprocess.Popen([home])
"""
icon_font_size = 22

def floating_to_front(qtile):
# if focus switches to floating window you just bring it to the front
    w = qtile.current_window
    if w.floating:
        w.bring_to_front() 

auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

wmname = "Qtile"
