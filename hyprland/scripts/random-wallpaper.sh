#!/bin/bash
# Directorio con las imágenes
WALLPAPER_DIR="/home/leandro/Pictures/Wallpapers"

# Array con los wallpapers disponibles
WALLPAPERS=(
    "$WALLPAPER_DIR/casa-kame-de-dragon-ball-3963.jpg"
    "$WALLPAPER_DIR/goku-en-paisaje-atardecer_5120x2880_xtrafondos.com.jpg"
)

# Seleccionar wallpaper aleatorio
RANDOM_WALLPAPER="${WALLPAPERS[$RANDOM % ${#WALLPAPERS[@]}]}"

# Matar proceso anterior de swaybg si existe
pkill swaybg

# Iniciar swaybg con el wallpaper aleatorio
swaybg -i "$RANDOM_WALLPAPER" -m fill &
