#!/bin/bash

echo "=== Instalando paquetes de Arch ==="

# Paquetes oficiales
if [ -f "packages.txt" ]; then
    echo "Instalando paquetes oficiales..."
    sudo pacman -S --needed - < packages.txt
fi

# Paquetes AUR (requiere yay o paru)
if [ -f "packages-aur.txt" ]; then
    if command -v yay &> /dev/null; then
        echo "Instalando paquetes de AUR con yay..."
        yay -S --needed - < packages-aur.txt
    elif command -v paru &> /dev/null; then
        echo "Instalando paquetes de AUR con paru..."
        paru -S --needed - < packages-aur.txt
    else
        echo "Advertencia: No se encontró yay ni paru para instalar paquetes AUR"
        echo "Instala yay o paru manualmente primero"
    fi
fi

echo "=== Instalación de paquetes completada ==="
