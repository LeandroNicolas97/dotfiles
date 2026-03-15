#!/bin/bash
# Script de actualización al inicio del sistema
# Se ejecuta al arrancar Hyprland

LOG="/tmp/startup-update.log"

notify() {
    notify-send -a "Sistema" "$1" "$2" -i "$3" 2>/dev/null || true
}

# Actualizar el sistema
notify "Actualizando sistema..." "Ejecutando pacman -Syu" "system-software-update"

sudo pacman -Syu --noconfirm >> "$LOG" 2>&1
EXIT_CODE=$?

if [ $EXIT_CODE -eq 0 ]; then
    notify "Sistema actualizado" "Actualización completada correctamente" "emblem-ok-symbolic"
else
    notify "Error en actualización" "Revisa $LOG para más detalles" "dialog-error"
fi
