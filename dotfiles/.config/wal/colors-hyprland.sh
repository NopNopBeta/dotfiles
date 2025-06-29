#!/bin/sh

# Generate colors
wal -i "$1" -n -q -t

# Reload Hyprland, Hyprpanel, and Hyprlock
hyprctl reload
pkill hyprpanel
hyprpanel &