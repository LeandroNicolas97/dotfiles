#!/bin/bash

###############################################################################
# Script de Instalación Completa de Dotfiles
# Arch Linux + Hyprland
###############################################################################

set -e

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# País para reflector (cambiar si se instala fuera de Chile)
REFLECTOR_COUNTRY="${REFLECTOR_COUNTRY:-Chile}"

# Resolver directorio del script y posicionarse ahí
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
cd "$SCRIPT_DIR"

print_step() {
    echo -e "\n${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}▶ $1${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
}

print_error()   { echo -e "${RED}✗ Error: $1${NC}"; }
print_success() { echo -e "${GREEN}✓ $1${NC}"; }
print_warning() { echo -e "${YELLOW}⚠ $1${NC}"; }

echo -e "${BLUE}"
cat << "EOF"
╔═══════════════════════════════════════════════════════════════╗
║                                                               ║
║        Instalador de Dotfiles - Arch Linux + Hyprland        ║
║                                                               ║
╚═══════════════════════════════════════════════════════════════╝
EOF
echo -e "${NC}"

# ============================================================================
# PASO 0: Pre-requisitos
# ============================================================================

print_step "Verificando pre-requisitos"

if [ ! -f /etc/arch-release ]; then
    print_error "Este script es solo para Arch Linux"
    exit 1
fi

if [ "$EUID" -eq 0 ]; then
    print_error "No ejecutes este script como root. Usa un usuario con sudo."
    exit 1
fi

# Mantener sudo vivo durante la instalación
sudo -v
( while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done ) 2>/dev/null &
SUDO_KEEPALIVE_PID=$!
trap 'kill $SUDO_KEEPALIVE_PID 2>/dev/null || true' EXIT

# yay o paru
if ! command -v yay &> /dev/null && ! command -v paru &> /dev/null; then
    print_warning "yay/paru no está instalado. Instalando yay..."
    sudo pacman -S --needed --noconfirm git base-devel
    tmpdir=$(mktemp -d)
    git clone https://aur.archlinux.org/yay.git "$tmpdir/yay"
    (cd "$tmpdir/yay" && makepkg -si --needed --noconfirm)
    rm -rf "$tmpdir"
    print_success "yay instalado"
fi

print_success "Pre-requisitos verificados"

# ============================================================================
# PASO 1: Actualizar mirrors y sistema
# ============================================================================

print_step "Actualizando mirrors y sistema base"

sudo cp /etc/pacman.d/mirrorlist "/etc/pacman.d/mirrorlist.backup.$(date +%Y%m%d)"

if command -v reflector &> /dev/null; then
    print_warning "Actualizando mirrors con reflector (país: $REFLECTOR_COUNTRY)..."
    sudo reflector --country "$REFLECTOR_COUNTRY" --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
else
    print_warning "Reflector no instalado, se omite actualización de mirrors"
fi

sudo pacman -Syy

print_success "Mirrors actualizados"

# ============================================================================
# PASO 2: Drivers de GPU (opcional)
# ============================================================================

print_step "Detectando GPU"

GPU_INFO=$(lspci 2>/dev/null | grep -Ei 'vga|3d|display' || true)
echo "$GPU_INFO"

GPU_PKGS=""
if echo "$GPU_INFO" | grep -qi intel; then
    GPU_PKGS="mesa intel-media-driver vulkan-intel libva-intel-driver"
elif echo "$GPU_INFO" | grep -qi amd; then
    GPU_PKGS="mesa xf86-video-amdgpu vulkan-radeon libva-mesa-driver"
elif echo "$GPU_INFO" | grep -qi nvidia; then
    print_warning "GPU NVIDIA detectada. Instala manualmente: nvidia nvidia-utils nvidia-settings"
fi

if [ -n "$GPU_PKGS" ]; then
    print_warning "Instalando drivers: $GPU_PKGS"
    sudo pacman -S --needed --noconfirm $GPU_PKGS || print_warning "Algún driver no se pudo instalar"
fi

# ============================================================================
# PASO 3: Instalar paquetes oficiales
# ============================================================================

print_step "Instalando paquetes oficiales de Arch"

OFFICIAL_PACKAGES=$(grep -v '^#' packages.txt | grep -v '^$' | tr '\n' ' ')

print_warning "Instalando paquetes oficiales (esto puede tardar varios minutos)..."
sudo pacman -S --needed --noconfirm $OFFICIAL_PACKAGES || {
    print_warning "Algunos paquetes fallaron. Intentando individualmente..."
    while IFS= read -r package; do
        [[ "$package" =~ ^#.*$ ]] && continue
        [[ -z "$package" ]] && continue
        if ! pacman -Qi "$package" &>/dev/null; then
            echo "→ Instalando $package..."
            sudo pacman -S --needed --noconfirm "$package" 2>&1 | grep -v "warning: setlocale" || \
                print_warning "Falló: $package (se puede instalar después)"
        fi
    done < packages.txt
}

print_success "Paquetes oficiales instalados"

# ============================================================================
# PASO 4: Instalar paquetes AUR
# ============================================================================

print_step "Instalando paquetes de AUR"

if command -v yay &> /dev/null; then
    AUR_HELPER="yay"
elif command -v paru &> /dev/null; then
    AUR_HELPER="paru"
fi

print_warning "Instalando paquetes AUR con $AUR_HELPER..."

AUR_PACKAGES=$(grep -v '^#' packages-aur.txt | grep -v '^$' | tr '\n' ' ')
$AUR_HELPER -S --needed --noconfirm $AUR_PACKAGES 2>&1 | grep -v "warning: setlocale" || \
    print_warning "Algunos paquetes AUR fallaron"

print_success "Paquetes AUR instalados"

# ============================================================================
# PASO 5: Oh-My-Zsh y plugins
# ============================================================================

print_step "Instalando Oh-My-Zsh y plugins"

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c \
        "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    print_success "Oh-My-Zsh instalado"
else
    print_success "Oh-My-Zsh ya estaba instalado"
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# Cambiar shell por defecto a zsh
if [ "$SHELL" != "/usr/bin/zsh" ] && [ "$SHELL" != "/bin/zsh" ]; then
    print_warning "Cambiando shell por defecto a zsh (requiere contraseña)..."
    chsh -s /usr/bin/zsh "$USER" || print_warning "No se pudo cambiar shell automáticamente"
fi

print_success "Zsh configurado"

# ============================================================================
# PASO 6: Configurar symlinks
# ============================================================================

print_step "Configurando symlinks de dotfiles"

create_symlink() {
    local source="$1"
    local target="$2"
    mkdir -p "$(dirname "$target")"
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        backup="$target.backup.$(date +%Y%m%d_%H%M%S)"
        echo "  Backup: $target -> $backup"
        mv "$target" "$backup"
    elif [ -L "$target" ]; then
        rm "$target"
    fi
    ln -sf "$source" "$target"
    echo "  ✓ $target → $source"
}

create_symlink "$PWD/waybar"            "$HOME/.config/waybar"
create_symlink "$PWD/hyprland"          "$HOME/.config/hypr"
create_symlink "$PWD/kitty"             "$HOME/.config/kitty"
create_symlink "$PWD/fastfetch"         "$HOME/.config/fastfetch"
create_symlink "$PWD/ranger"            "$HOME/.config/ranger"
create_symlink "$PWD/nvim"              "$HOME/.config/nvim"
create_symlink "$PWD/rofi"              "$HOME/.config/rofi"
create_symlink "$PWD/wofi"              "$HOME/.config/wofi"
create_symlink "$PWD/mako"              "$HOME/.config/mako"
[ -d "$PWD/btop" ] && create_symlink "$PWD/btop" "$HOME/.config/btop"
create_symlink "$PWD/starship/starship.toml" "$HOME/.config/starship.toml"
create_symlink "$PWD/zsh/.zshrc"        "$HOME/.zshrc"

# gitconfig (opcional — sobreescribe identidad global)
if [ -f "$PWD/git/.gitconfig" ]; then
    create_symlink "$PWD/git/.gitconfig" "$HOME/.gitconfig"
fi
if [ -f "$PWD/git/.gitconfig-work" ]; then
    create_symlink "$PWD/git/.gitconfig-work" "$HOME/.gitconfig-work"
fi

print_success "Symlinks configurados"

# ============================================================================
# PASO 7: Neovim (lazy.nvim)
# ============================================================================

print_step "Preparando Neovim (lazy.nvim)"

LAZY_DIR="$HOME/.local/share/nvim/lazy/lazy.nvim"
if [ ! -d "$LAZY_DIR" ]; then
    git clone --filter=blob:none --branch=stable https://github.com/folke/lazy.nvim.git "$LAZY_DIR"
    print_success "lazy.nvim clonado"
else
    print_success "lazy.nvim ya estaba instalado"
fi

# Dependencias LSP comunes
if command -v npm &>/dev/null; then
    sudo npm install -g neovim pyright typescript-language-server vscode-langservers-extracted 2>/dev/null || \
        print_warning "Algunos paquetes npm globales fallaron"
fi
if command -v pip &>/dev/null; then
    pip install --user --break-system-packages pynvim 2>/dev/null || \
        print_warning "No se pudo instalar pynvim"
fi

# ============================================================================
# PASO 8: Wallpapers y locales
# ============================================================================

print_step "Aplicando configuraciones adicionales"

# Directorio de wallpapers (random-wallpaper.sh lo necesita)
mkdir -p "$HOME/Pictures/Wallpapers"
if [ -z "$(ls -A "$HOME/Pictures/Wallpapers" 2>/dev/null)" ]; then
    print_warning "Directorio ~/Pictures/Wallpapers creado pero está vacío — agregá imágenes para que random-wallpaper.sh funcione"
fi

# Locale
if ! locale -a | grep -qi "es_CL.utf8"; then
    print_warning "Generando locale es_CL.UTF-8..."
    sudo sed -i 's/^#\s*es_CL.UTF-8/es_CL.UTF-8/' /etc/locale.gen
    sudo sed -i 's/^#\s*en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen
    sudo locale-gen
fi

# Scripts ejecutables
chmod +x hyprland/random-wallpaper.sh 2>/dev/null || true
chmod +x hyprland/workspace-switcher.sh 2>/dev/null || true
chmod +x hyprland/startup-update.sh 2>/dev/null || true
chmod +x hyprland/scripts/*.sh 2>/dev/null || true
chmod +x scripts/*.sh 2>/dev/null || true
chmod +x waybar/*.sh 2>/dev/null || true
chmod +x rofi/launchers/*/*.sh 2>/dev/null || true
chmod +x rofi/powermenu/*/*.sh 2>/dev/null || true
chmod +x rofi/applets/bin/*.sh 2>/dev/null || true

print_success "Configuraciones aplicadas"

# ============================================================================
# PASO 9: Servicios systemd
# ============================================================================

print_step "Habilitando servicios systemd"

enable_service() {
    if systemctl list-unit-files | grep -q "^$1"; then
        sudo systemctl enable "$1" && echo "  ✓ $1 habilitado"
    fi
}

enable_service "NetworkManager.service"
enable_service "bluetooth.service"
enable_service "sddm.service"

# Servicio opcional de actualización automática (presente en rama omen15)
if [ -f "$PWD/misc/pacman-update.service" ]; then
    sudo cp "$PWD/misc/pacman-update.service" /etc/systemd/system/
    sudo systemctl daemon-reload
    print_warning "pacman-update.service copiado. Habilitalo manualmente con: sudo systemctl enable pacman-update.service"
fi

# Servicios de usuario
systemctl --user enable pipewire.service wireplumber.service 2>/dev/null || true

print_success "Servicios habilitados"

# ============================================================================
# PASO 10: Resumen final
# ============================================================================

echo -e "\n${GREEN}"
cat << "EOF"
╔═══════════════════════════════════════════════════════════════╗
║                                                               ║
║              ✅ INSTALACIÓN COMPLETADA                        ║
║                                                               ║
╚═══════════════════════════════════════════════════════════════╝
EOF
echo -e "${NC}\n"

print_success "Dotfiles instalados correctamente"
echo ""
echo "📋 Próximos pasos:"
echo "  1. Cerrá sesión y volvé a entrar (o reiniciá) para usar zsh y SDDM"
echo "  2. Después del primer login en Hyprland, instalá el plugin Hyprspace:"
echo "       ./install-hyprspace.sh"
echo "  3. Agregá imágenes a ~/Pictures/Wallpapers/"
echo "  4. Abrí nvim para que lazy.nvim instale los plugins"
echo ""
echo "🎮 Atajos principales:"
echo "  Super + Return    - Terminal"
echo "  Super + D         - Wofi launcher"
echo "  Super + TAB       - Exposé (pyprland)"
echo "  Super + Q         - Cerrar ventana"
echo ""
echo "📚 Documentación completa: ~/dotfiles/README.md"
echo ""
