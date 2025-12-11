# Arch Linux Dotfiles

Mi configuración personal de Arch Linux con Hyprland.

## Configuraciones incluidas

- **Hyprland**: Window manager
- **Waybar**: Barra de estado
- **Kitty**: Terminal
- **Zsh**: Shell con Oh-My-Zsh
- **Starship**: Prompt personalizado
- **Git**: Configuración global

## Instalación rápida

### 1. Clonar repositorio
```bash
git clone git@github.com:TU_USUARIO/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 2. Instalar paquetes
```bash
./install-packages.sh
```

### 3. Aplicar configuraciones
```bash
./install.sh
```

### 4. Reiniciar terminal
```bash
exec zsh
```

## Instalación manual

Si prefieres instalar selectivamente:
```bash
# Solo Hyprland
ln -sf ~/dotfiles/hyprland/hyprland.conf ~/.config/hypr/

# Solo Waybar
ln -sf ~/dotfiles/waybar/config.jsonc ~/.config/waybar/
ln -sf ~/dotfiles/waybar/style.css ~/.config/waybar/

# Solo Kitty
ln -sf ~/dotfiles/kitty/kitty.conf ~/.config/kitty/

# Solo Zsh
ln -sf ~/dotfiles/zsh/.zshrc ~/.zshrc
```

## Estructura
```
dotfiles/
├── hyprland/          # Configuración de Hyprland
├── waybar/            # Configuración de Waybar
├── kitty/             # Configuración de Kitty
├── zsh/               # Configuración de Zsh
├── starship/          # Configuración de Starship
├── nvim/              # Configuración de Neovim
├── git/               # Configuración de Git
├── packages.txt       # Lista de paquetes oficiales
├── packages-aur.txt   # Lista de paquetes AUR
├── install.sh         # Script de instalación de dotfiles
└── install-packages.sh # Script de instalación de paquetes
```

## Actualizar dotfiles

Cuando hagas cambios en tu sistema:
```bash
cd ~/dotfiles

# Copiar cambios
cp ~/.config/hypr/hyprland.conf hyprland/
cp ~/.config/waybar/config.jsonc waybar/
# ... etc

# Actualizar lista de paquetes
pacman -Qqe > packages.txt
pacman -Qqm > packages-aur.txt

# Commit y push
git add .
git commit -m "Update: descripción de cambios"
git push origin main
```

## Notas

- Los archivos originales se respaldan con extensión `.backup`
- Se usan symlinks para mantener sincronización
- Actualiza `packages.txt` periódicamente con nuevos paquetes
