#!/bin/bash

ZOOM_FILE="/tmp/hyprland_zoom_level"

# Inicializar si no existe
if [ ! -f "$ZOOM_FILE" ]; then
    echo "1.0" > "$ZOOM_FILE"
fi

CURRENT=$(cat "$ZOOM_FILE")

case $1 in
    in)
        NEW=$(echo "$CURRENT + 0.1" | bc)
        ;;
    out)
        NEW=$(echo "$CURRENT - 0.1" | bc)
        if (( $(echo "$NEW < 0.5" | bc -l) )); then
            NEW="0.5"
        fi
        ;;
    reset)
        NEW="1.0"
        ;;
esac

echo "$NEW" > "$ZOOM_FILE"

# Aplicar zoom usando la escala del monitor
hyprctl keyword monitor ,preferred,auto,$NEW
