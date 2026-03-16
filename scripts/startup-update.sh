#!/bin/bash
# Script de inicio del sistema - se ejecuta al arrancar Hyprland

DISCORD_FLAGS="--enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform=wayland"

# Lanzar Discord
discord $DISCORD_FLAGS &
