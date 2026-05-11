#!/bin/bash

pkill swaybg

WALLPAPERS_DIR=~/dotfiles/wallpapers
VERTICAL_DIR=~/dotfiles/wallpapers/vertical

pick_random() {
    find "$1" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | shuf -n 1
}

WP_LAPTOP=$(pick_random "$WALLPAPERS_DIR")
WP_GEAR=$(pick_random "$WALLPAPERS_DIR")

# Samsung vertical: usa subcarpeta vertical/ si existe, si no cae al directorio principal
if [ -d "$VERTICAL_DIR" ] && [ -n "$(ls -A "$VERTICAL_DIR" 2>/dev/null)" ]; then
    WP_SAMSUNG=$(find "$VERTICAL_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | shuf -n 1)
else
    WP_SAMSUNG=$(pick_random "$WALLPAPERS_DIR")
fi

# DP-1 en Lenovo, DP-2 en desktop
SAMSUNG_OUTPUT=$(hyprctl monitors | grep -oE 'DP-[0-9]+' | head -1)
SAMSUNG_OUTPUT=${SAMSUNG_OUTPUT:-DP-2}

swaybg \
    -o eDP-1             -i "$WP_LAPTOP"  -m fill \
    -o HDMI-A-1          -i "$WP_GEAR"   -m fill \
    -o "$SAMSUNG_OUTPUT" -i "$WP_SAMSUNG" -m fill &
