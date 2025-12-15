#!/bin/bash

###############################################################################
# Script de Instalación Completa de Dotfiles
# Arch Linux + Hyprland
###############################################################################

set -e  # Salir si hay errores

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Funciones
print_step() {
    echo -e "\n${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}▶ $1${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
}

print_error() {
    echo -e "${RED}✗ Error: $1${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

# Verificar que estamos en el directorio correcto
if [ ! -f "install.sh" ]; then
    print_error "Ejecuta este script desde el directorio ~/dotfiles"
    exit 1
fi

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

# Verificar que estamos en Arch
if [ ! -f /etc/arch-release ]; then
    print_error "Este script es solo para Arch Linux"
    exit 1
fi

# Verificar yay/paru
if ! command -v yay &> /dev/null && ! command -v paru &> /dev/null; then
    print_warning "yay/paru no está instalado. Instalando yay..."
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --needed --noconfirm
    cd -
    print_success "yay instalado"
fi

print_success "Pre-requisitos verificados"

# ============================================================================
# PASO 1: Actualizar mirrors y sistema
# ============================================================================

print_step "Actualizando mirrors y sistema base"

# Backup del mirrorlist
sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup.$(date +%Y%m%d)

# Actualizar mirrorlist
print_warning "Esto actualizará los mirrors. Puede tomar unos minutos..."
if command -v reflector &> /dev/null; then
    sudo reflector --country Chile --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
else
    print_warning "Reflector no instalado, usando mirrors por defecto"
fi

# Actualizar base de datos
sudo pacman -Syy

print_success "Mirrors actualizados"

# ============================================================================
# PASO 2: Instalar paquetes oficiales
# ============================================================================

print_step "Instalando paquetes oficiales de Arch"

# Leer paquetes desde packages.txt, ignorando líneas vacías y comentarios
OFFICIAL_PACKAGES=$(grep -v '^#' packages.txt | grep -v '^$' | tr '\n' ' ')

# Instalar en lotes para mejor manejo de errores
print_warning "Instalando paquetes oficiales (esto puede tardar varios minutos)..."
sudo pacman -S --needed --noconfirm $OFFICIAL_PACKAGES || {
    print_warning "Algunos paquetes fallaron. Intentando individualmente..."

    while IFS= read -r package; do
        # Ignorar comentarios y líneas vacías
        [[ "$package" =~ ^#.*$ ]] && continue
        [[ -z "$package" ]] && continue

        if ! pacman -Qi "$package" &>/dev/null; then
            echo "→ Instalando $package..."
            sudo pacman -S --needed --noconfirm "$package" 2>&1 | grep -v "warning: setlocale" || {
                print_warning "Falló: $package (se puede instalar después)"
            }
        fi
    done < packages.txt
}

print_success "Paquetes oficiales instalados"

# ============================================================================
# PASO 3: Instalar paquetes AUR
# ============================================================================

print_step "Instalando paquetes de AUR"

# Determinar qué helper usar
if command -v yay &> /dev/null; then
    AUR_HELPER="yay"
elif command -v paru &> /dev/null; then
    AUR_HELPER="paru"
fi

print_warning "Instalando paquetes AUR con $AUR_HELPER (esto puede tardar bastante)..."

# Leer paquetes AUR
AUR_PACKAGES=$(grep -v '^#' packages-aur.txt | grep -v '^$' | tr '\n' ' ')

# Instalar paquetes AUR
$AUR_HELPER -S --needed --noconfirm $AUR_PACKAGES 2>&1 | grep -v "warning: setlocale" || {
    print_warning "Algunos paquetes AUR fallaron"
}

print_success "Paquetes AUR instalados"

# ============================================================================
# PASO 4: Configurar symlinks
# ============================================================================

print_step "Configurando symlinks de dotfiles"

# Función para crear symlinks con backup
create_symlink() {
    local source="$1"
    local target="$2"

    # Crear directorio padre si no existe
    mkdir -p "$(dirname "$target")"

    # Backup si existe y no es symlink
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        backup="$target.backup.$(date +%Y%m%d_%H%M%S)"
        echo "  Backup: $target -> $backup"
        mv "$target" "$backup"
    elif [ -L "$target" ]; then
        rm "$target"
    fi

    # Crear symlink
    ln -sf "$source" "$target"
    echo "  ✓ $target → $source"
}

# Crear symlinks
create_symlink "$PWD/waybar" "$HOME/.config/waybar"
create_symlink "$PWD/hyprland" "$HOME/.config/hypr"
create_symlink "$PWD/kitty" "$HOME/.config/kitty"
create_symlink "$PWD/fastfetch" "$HOME/.config/fastfetch"
create_symlink "$PWD/ranger" "$HOME/.config/ranger"
create_symlink "$PWD/nvim" "$HOME/.config/nvim"
create_symlink "$PWD/rofi" "$HOME/.config/rofi"
create_symlink "$PWD/mako" "$HOME/.config/mako"
create_symlink "$PWD/btop" "$HOME/.config/btop"
create_symlink "$PWD/starship/starship.toml" "$HOME/.config/starship.toml"
create_symlink "$PWD/zsh/.zshrc" "$HOME/.zshrc"

print_success "Symlinks configurados"

# ============================================================================
# PASO 5: Configuraciones adicionales
# ============================================================================

print_step "Aplicando configuraciones adicionales"

# Generar locale si falta
if ! locale -a | grep -q "es_CL.UTF-8"; then
    print_warning "Generando locale es_CL.UTF-8..."
    sudo sed -i 's/^#es_CL.UTF-8/es_CL.UTF-8/' /etc/locale.gen
    sudo locale-gen
fi

# Hacer scripts ejecutables
chmod +x hyprland/random-wallpaper.sh
chmod +x hyprland/workspace-switcher.sh
chmod +x hyprland/scripts/*.sh 2>/dev/null || true
chmod +x waybar/*.sh 2>/dev/null || true
chmod +x rofi/launchers/*/*.sh 2>/dev/null || true
chmod +x rofi/powermenu/*/*.sh 2>/dev/null || true
chmod +x rofi/applets/bin/*.sh 2>/dev/null || true

print_success "Configuraciones aplicadas"

# ============================================================================
# PASO 6: Resumen final
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
echo "  1. Cierra sesión y vuelve a entrar"
echo "  2. O recarga Hyprland: Super + Shift + R"
echo ""
echo "🎮 Atajos principales:"
echo "  Super + Return    - Terminal"
echo "  Super + D         - Rofi launcher"
echo "  Super + TAB       - Exposé (pyprland)"
echo "  Super + Q         - Cerrar ventana"
echo ""
echo "📚 Documentación completa: ~/dotfiles/README.md"
echo ""
