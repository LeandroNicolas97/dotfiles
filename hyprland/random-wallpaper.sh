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

GEAR_OUTPUT=$(hyprctl monitors -j | jq -r '.[].name' | grep -E '^DP-[0-9]+$' | head -1)
GEAR_OUTPUT=${GEAR_OUTPUT:-DP-2}

swaybg \
    -o eDP-1      -i "$WP_LAPTOP"  -m fill \
    -o HDMI-A-1   -i "$WP_SAMSUNG" -m fill \
    -o "$GEAR_OUTPUT" -i "$WP_GEAR" -m fill &
