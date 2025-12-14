#!/bin/bash

# Kill any existing swaybg instances
pkill swaybg

# Get a random image from Downloads
WALLPAPER=$(find ~/Downloads -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | shuf -n 1)

# Set the wallpaper using swaybg
if [ -n "$WALLPAPER" ]; then
    swaybg -i "$WALLPAPER" -m fill &
fi
