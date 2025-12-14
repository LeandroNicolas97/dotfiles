#!/bin/bash

# Script para obtener iconos de ventanas activas en cada workspace

get_window_icon() {
    local class="$1"

    case "$class" in
        *firefox*|*Firefox*) echo "" ;;
        *chrom*|*Chrome*) echo "" ;;
        *kitty*|*alacritty*|*terminal*) echo "" ;;
        *code*|*Code*|*VSCode*) echo "󰨞" ;;
        *spotify*|*Spotify*) echo "" ;;
        *discord*|*Discord*) echo "󰙯" ;;
        *telegram*|*Telegram*) echo "" ;;
        *thunar*|*nautilus*|*dolphin*) echo "" ;;
        *gimp*|*inkscape*) echo "" ;;
        *vlc*|*mpv*) echo "󰕼" ;;
        *steam*|*Steam*) echo "󰓓" ;;
        *obs*|*OBS*) echo "󰑋" ;;
        "") echo "" ;;
        *) echo "" ;;
    esac
}

# Obtener información de workspaces de Hyprland
hyprctl workspaces -j | jq -r '.[] | "\(.id)|\(.windows)"' | while IFS='|' read -r id windows; do
    if [ "$windows" -gt 0 ]; then
        # Obtener la clase de la primera ventana en el workspace
        class=$(hyprctl clients -j | jq -r --arg id "$id" '.[] | select(.workspace.id == ($id|tonumber)) | .class' | head -n1)
        icon=$(get_window_icon "$class")
        echo "$id:$icon"
    fi
done
