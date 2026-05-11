#!/bin/bash

echo "=== Creando symlinks de dotfiles ==="

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
cd "$SCRIPT_DIR"

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

backup_and_link "$PWD/waybar"    "$HOME/.config/waybar"
backup_and_link "$PWD/hyprland"  "$HOME/.config/hypr"
backup_and_link "$PWD/kitty"     "$HOME/.config/kitty"
backup_and_link "$PWD/fastfetch" "$HOME/.config/fastfetch"
backup_and_link "$PWD/ranger"    "$HOME/.config/ranger"
backup_and_link "$PWD/nvim"      "$HOME/.config/nvim"
backup_and_link "$PWD/rofi"      "$HOME/.config/rofi"
backup_and_link "$PWD/wofi"      "$HOME/.config/wofi"
backup_and_link "$PWD/mako"      "$HOME/.config/mako"
[ -d "$PWD/btop" ] && backup_and_link "$PWD/btop" "$HOME/.config/btop"
backup_and_link "$PWD/starship/starship.toml" "$HOME/.config/starship.toml"
backup_and_link "$PWD/zsh/.zshrc" "$HOME/.zshrc"

[ -f "$PWD/git/.gitconfig" ]      && backup_and_link "$PWD/git/.gitconfig"      "$HOME/.gitconfig"
[ -f "$PWD/git/.gitconfig-work" ] && backup_and_link "$PWD/git/.gitconfig-work" "$HOME/.gitconfig-work"

echo ""
echo "=== Symlinks creados ==="
echo "Ahora edita tus configs en ~/.config/ como siempre"
echo "Los cambios se sincronizarán automáticamente con ~/dotfiles/"
