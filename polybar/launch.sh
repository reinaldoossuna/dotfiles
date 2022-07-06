#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if  [ $(xrandr --query | grep " connected" | cut -d" " -f1 | wc -l) = 2 ]; then
  # Get the last monitor
  # Normally Virtual1 or HDMI
  MONITOR=$(xrandr --query | grep " connected" | cut -d" " -f1 | tail -n 1)
  polybar --reload main &
  polybar --reload side &
else
  # Get the first monitor
  # Normally eDP1
  MONITOR=$(xrandr --query | grep " connected" | cut -d" " -f1 | head -n 1)
  polybar --reload main &
fi
 
echo "Bars launched..."
