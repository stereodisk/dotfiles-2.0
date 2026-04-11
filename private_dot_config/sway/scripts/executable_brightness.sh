#!/bin/bash

# Brightness control for Frutiger Aero theme

case $1 in
    up)
        brightnessctl set +5%
        ;;
    down)
        brightnessctl set 5%-
        ;;
esac

# Get current percentage directly
VAL=$(brightnessctl -m | cut -d, -f4 | tr -d '%')

# Send notification
notify-send -a "System" "Brillo" \
    -h string:x-dunst-stack-tag:bright \
    -u low "󰃠  ${VAL}%"
