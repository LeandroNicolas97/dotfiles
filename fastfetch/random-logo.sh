#!/bin/bash

# Directorio con las imágenes (ajustado a tu estructura)
LOGO_DIR="$HOME/dotfiles/fastfetch/logo"

# Seleccionar una imagen aleatoria
RANDOM_IMAGE=$(find "$LOGO_DIR" -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.gif" \) | shuf -n 1)

# Si no encuentra imágenes, usa una por defecto
if [ -z "$RANDOM_IMAGE" ]; then
    echo "arch"  # Logo de texto por defecto
else
    echo "$RANDOM_IMAGE"
fi
