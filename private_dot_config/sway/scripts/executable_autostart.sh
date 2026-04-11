#!/bin/bash

# Autostart script for Frutiger Aero theme

# Environment
systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

# Variables
LOCK_SCRIPT="$HOME/.config/sway/scripts/lock.sh"

# Swaylock / Idle
swayidle -w \
    timeout 180 "$LOCK_SCRIPT" \
    timeout 300 'swaymsg "output * dpms off"' \
    resume 'swaymsg "output * dpms on"' \
    before-sleep "$LOCK_SCRIPT" \
    after-resume 'swaymsg "output * dpms on"' &

# Mako (Notifications)
mako &

# eww
$HOME/.config/sway/scripts/launch_eww.sh &

# Polkit
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Theme settings
gsettings set org.gnome.desktop.interface gtk-theme 'Windows Longhorn Plex'
gsettings set org.gnome.desktop.interface color-scheme 'default'

# Misc
brightnessctl -d "platform::micmute" set 0
