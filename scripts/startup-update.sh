#!/bin/bash
# Script de actualización al inicio del sistema
# Se ejecuta al arrancar Hyprland

LOG="/tmp/startup-update.log"
DISCORD_FLAGS="--enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform=wayland"

notify() {
    notify-send -a "Sistema" "$1" "$2" -i "$3" 2>/dev/null || true
}

# Actualizar el sistema (incluye AUR)
notify "Actualizando sistema..." "Ejecutando yay -Syu" "system-software-update"

yay -Syu --noconfirm >> "$LOG" 2>&1
EXIT_CODE=$?

if [ $EXIT_CODE -eq 0 ]; then
    notify "Sistema actualizado" "Actualización completada correctamente" "emblem-ok-symbolic"
else
    notify "Error en actualización" "Revisa $LOG para más detalles" "dialog-error"
fi

# Lanzar Discord después de actualizar
discord $DISCORD_FLAGS &
