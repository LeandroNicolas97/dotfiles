#!/bin/bash

echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║          VERIFICACIÓN DE INSTALACIÓN - Dotfiles              ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

installed=0
missing=0

check_package() {
    if pacman -Qi "$1" &>/dev/null; then
        echo -e "${GREEN}✓${NC} $1"
        ((installed++))
        return 0
    else
        echo -e "${RED}✗${NC} $1"
        ((missing++))
        return 1
    fi
}

check_command() {
    if command -v "$1" &>/dev/null; then
        echo -e "${GREEN}✓${NC} $1 $(command -v $1)"
        return 0
    else
        echo -e "${RED}✗${NC} $1 (no encontrado)"
        return 1
    fi
}

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  🎨 COMPONENTES PRINCIPALES DE HYPRLAND"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
check_package "hyprland"
check_package "waybar"
check_package "rofi"
check_package "wofi"
check_package "mako"
check_package "kitty"
check_package "swaybg"
check_package "swayidle"
check_package "swaylock-effects"
check_package "wlogout"
check_package "pyprland"
check_package "sddm"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  📱 APLICACIONES"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
check_package "discord"
check_package "firefox"
check_package "vlc"
check_package "mpv"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  🛠️  HERRAMIENTAS CLI"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
check_package "btop"
check_package "bat"
check_package "eza"
check_package "fzf"
check_package "lazygit"
check_package "ripgrep"
check_package "tmux"
check_package "neovim"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  🔤 FUENTES NERD FONTS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
check_package "ttf-jetbrains-mono-nerd"
check_package "ttf-firacode-nerd"
check_package "ttf-hack-nerd"
check_package "ttf-meslo-nerd"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  🎨 TEMAS E ICONOS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
check_package "dracula-gtk-theme"
check_package "dracula-icons-git"
check_package "papirus-icon-theme"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  🔗 SYMLINKS DE CONFIGURACIÓN"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

check_symlink() {
    if [ -L "$2" ]; then
        target=$(readlink -f "$2")
        if [[ "$target" == *"$1"* ]]; then
            echo -e "${GREEN}✓${NC} $2 → $target"
            return 0
        else
            echo -e "${YELLOW}⚠${NC} $2 → $target (apunta a lugar incorrecto)"
            return 1
        fi
    else
        echo -e "${RED}✗${NC} $2 (no es un symlink)"
        return 1
    fi
}

check_symlink "dotfiles/waybar" "$HOME/.config/waybar"
check_symlink "dotfiles/hyprland" "$HOME/.config/hypr"
check_symlink "dotfiles/kitty" "$HOME/.config/kitty"
check_symlink "dotfiles/rofi" "$HOME/.config/rofi"
check_symlink "dotfiles/wofi" "$HOME/.config/wofi"
check_symlink "dotfiles/mako" "$HOME/.config/mako"
check_symlink "dotfiles/nvim" "$HOME/.config/nvim"
check_symlink "dotfiles/fastfetch" "$HOME/.config/fastfetch"
check_symlink "dotfiles/zsh/.zshrc" "$HOME/.zshrc"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  📊 RESUMEN"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Paquetes instalados: ${GREEN}$installed${NC}"
echo "Paquetes faltantes:  ${RED}$missing${NC}"
echo ""

# Verificar total de paquetes faltantes
total_missing=$(comm -23 <(sort packages.txt) <(pacman -Qq | sort) | wc -l)
echo "Total de paquetes en packages.txt faltantes: $total_missing"

echo ""
if [ $missing -eq 0 ] && [ $total_missing -eq 0 ]; then
    echo -e "${GREEN}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║              ✅ TODO INSTALADO CORRECTAMENTE                  ║${NC}"
    echo -e "${GREEN}╚═══════════════════════════════════════════════════════════════╝${NC}"
else
    echo -e "${YELLOW}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${YELLOW}║        ⚠️  FALTAN PAQUETES POR INSTALAR                       ║${NC}"
    echo -e "${YELLOW}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo "Para instalar los paquetes faltantes:"
    echo "  ./install-step-by-step.sh"
fi
echo ""
