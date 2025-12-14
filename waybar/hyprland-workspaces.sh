#!/bin/bash

# Mapeo de clases a iconos
get_icon() {
    case "$1" in
        *firefox*|*Firefox*) echo "" ;;
        *chrom*|*Chrome*|*Brave*) echo "" ;;
        *kitty*|*Alacritty*|*foot*) echo "" ;;
        *code*|*Code*|*codium*) echo "󰨞" ;;
        *nvim*|*vim*) echo "" ;;
        *spotify*|*Spotify*) echo "" ;;
        *discord*|*Discord*|*vesktop*) echo "󰙯" ;;
        *telegram*|*Telegram*) echo "" ;;
        *thunar*|*nautilus*|*dolphin*|*pcmanfm*) echo "" ;;
        *gimp*|*inkscape*|*krita*) echo "" ;;
        *vlc*|*mpv*) echo "󰕼" ;;
        *steam*|*Steam*) echo "󰓓" ;;
        *obs*|*OBS*) echo "󰑋" ;;
        *thunderbird*) echo "" ;;
        *libreoffice*) echo "" ;;
        "") echo "" ;;
        *) echo "" ;;
    esac
}

# Crear JSON para waybar
workspaces=$(hyprctl workspaces -j | jq -c 'sort_by(.id)')
active_workspace=$(hyprctl activeworkspace -j | jq -r '.id')

output='{"text":"'

for i in {1..9}; do
    # Verificar si el workspace existe y tiene ventanas
    ws_info=$(echo "$workspaces" | jq -r --arg id "$i" '.[] | select(.id == ($id|tonumber))')

    if [ -n "$ws_info" ]; then
        windows=$(echo "$ws_info" | jq -r '.windows')

        if [ "$windows" -gt 0 ]; then
            # Obtener la clase de la primera ventana
            class=$(hyprctl clients -j | jq -r --arg id "$i" '.[] | select(.workspace.id == ($id|tonumber)) | .class' | head -n1)
            icon=$(get_icon "$class")
        else
            icon="$i"
        fi
    else
        icon="$i"
    fi

    # Marcar workspace activo
    if [ "$i" -eq "$active_workspace" ]; then
        output+="<span foreground='#3D2817' background='#D2B48C' size='large'> $icon </span> "
    else
        output+="<span foreground='#9B8268' size='large'> $icon </span> "
    fi
done

output+='"}'
echo "$output"
