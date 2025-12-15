#!/bin/bash

# Array de caracteres para las barras (de vacío a lleno)
bar_chars=("▁" "▂" "▃" "▄" "▅" "▆" "▇" "█")

# Ejecutar cava y procesar su salida
cava -p ~/.config/waybar/cava-config | while IFS=';' read -ra values; do
    # Verificar si hay música reproduciéndose
    # Priorizar Spotify si está disponible, sino usar cualquier reproductor excepto navegadores
    if playerctl -l 2>/dev/null | grep -q spotify; then
        player_status=$(playerctl -p spotify status 2>/dev/null)
    else
        player_status=$(playerctl -i brave,firefox,chromium status 2>/dev/null)
    fi

    if [ "$player_status" = "Playing" ]; then
        output=""
        # Convertir cada número en el carácter de barra correspondiente
        for val in "${values[@]}"; do
            if [[ "$val" =~ ^[0-7]$ ]]; then
                output="${output}${bar_chars[$val]}"
            fi
        done
        echo "$output"
    else
        # Si no está reproduciendo, no mostrar nada
        echo ""
    fi
done
