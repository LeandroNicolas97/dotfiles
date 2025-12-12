#!/bin/bash

echo "=== Creando symlinks de dotfiles ==="

# Backup de configs existentes
backup_and_link() {
    local source="$1"
    local target="$2"
    
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        echo "Backup: $target -> $target.backup"
        mv "$target" "$target.backup"
    elif [ -L "$target" ]; then
        echo "Removing old symlink: $target"
        rm "$target"
    fi
    
    mkdir -p "$(dirname "$target")"
    ln -sf "$source" "$target"
    echo "✓ Linked: $target -> $source"
}

# Crear symlinks
backup_and_link "$PWD/waybar" "$HOME/.config/waybar"
backup_and_link "$PWD/hyprland" "$HOME/.config/hypr"
backup_and_link "$PWD/kitty" "$HOME/.config/kitty"
backup_and_link "$PWD/fastfetch" "$HOME/.config/fastfetch"
backup_and_link "$PWD/ranger" "$HOME/.config/ranger"
backup_and_link "$PWD/nvim" "$HOME/.config/nvim"
backup_and_link "$PWD/starship/starship.toml" "$HOME/.config/starship.toml"
backup_and_link "$PWD/zsh/.zshrc" "$HOME/.zshrc"

echo ""
echo "=== Symlinks creados ==="
echo "Ahora edita tus configs en ~/.config/ como siempre"
echo "Los cambios se sincronizarán automáticamente con ~/dotfiles/"
