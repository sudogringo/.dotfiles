#!/bin/sh

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
#polybar-msg cmd quit
# Otherwise you can use the nuclear option:
killall -q polybar

# Launch bar1 and bar2
echo "---" | tee -a /tmp/polybar1.log
polybar --config=~/.config/polybar/config.ini & 
#polybar &

echo "Bar(s) launched..."
