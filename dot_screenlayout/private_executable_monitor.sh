#!/bin/sh

n=$(xrandr --query | grep " connected" | wc -l)

if (( n == 2 )); # using hdmi monitor
then
xrandr \
    --output HDMI-0 --primary --mode 1366x768 --pos 1600x0 --rotate normal \
    --output eDP-1-1 --noprimary --mode 1600x900 --pos 0x0 --rotate normal \
    --output DP-1-1 --off \
    --output HDMI-1-2 --off \
    --output DP-1-2 --off \
    --output HDMI-1-3 --off \
    --output DP-1-3 --off \
    --output HDMI-1-4 --off
else # using only the laptop monitor
xrandr      \
    --output HDMI-0 --off   \
    --output eDP-1-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal   \
    --output DP-1-1 --off   \
    --output HDMI-1-2 --off     \
    --output DP-1-2 --off   \
    --output HDMI-1-3 --off     \
    --output DP-1-3 --off   \
    --output HDMI-1-4 --off
fi
