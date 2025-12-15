#!/bin/sh

# Priorizar Spotify si está disponible, sino usar cualquier reproductor excepto navegadores
if playerctl -l 2>/dev/null | grep -q spotify; then
    player_status=$(playerctl -p spotify status 2>/dev/null)
    artist=$(playerctl -p spotify metadata artist 2>/dev/null)
    title=$(playerctl -p spotify metadata title 2>/dev/null)
else
    # Usar cualquier reproductor excepto navegadores (brave, firefox, chromium)
    player_status=$(playerctl -i brave,firefox,chromium status 2>/dev/null)
    artist=$(playerctl -i brave,firefox,chromium metadata artist 2>/dev/null)
    title=$(playerctl -i brave,firefox,chromium metadata title 2>/dev/null)
fi

# Si hay metadata disponible, mostrarla con el icono apropiado
if [ -n "$artist" ] && [ -n "$title" ]; then
    if [ "$player_status" = "Playing" ]; then
        echo "󰐊 $artist - $title"
    elif [ "$player_status" = "Paused" ]; then
        echo "󰏤 $artist - $title"
    else
        # Para estado Stopped o cualquier otro, mostrar sin icono de estado
        echo "󰝚 $artist - $title"
    fi
else
    echo ""
fi
