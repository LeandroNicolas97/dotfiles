# Arch Linux Dotfiles

Configuración personal de Arch Linux con Hyprland + Waybar + Kitty.

## 🎨 Configuraciones incluidas

### Window Manager y Compositing
- **Hyprland**: Window manager dinámico para Wayland con animaciones y efectos
- **Pyprland**: Plugin manager para Hyprland con funcionalidades extra
- **hyprland-plugin-hyprexpo**: Plugin para Hyprland con vista expo de workspaces

### Interfaz de Usuario
- **Waybar**: Barra de estado customizable con tema Dracula
- **Rofi**: Launcher de aplicaciones y menús con múltiples temas
- **Mako**: Sistema de notificaciones para Wayland
- **Wlogout**: Menú de logout/shutdown elegante
- **Swaylock-effects**: Lockscreen con efectos y blur

### Terminal y Shell
- **Kitty**: Terminal emulator con GPU acceleration y transparencia
- **Zsh**: Shell avanzado con Oh-My-Zsh framework
- **Starship**: Prompt minimalista y personalizable

### Utilidades de Sistema
- **Btop**: Monitor de recursos del sistema (CPU, RAM, red, procesos)
- **Fastfetch**: Información del sistema con estilo
- **Ranger**: File manager para terminal con preview de archivos
- **Neovim**: Editor de texto modal altamente configurable

### Temas y Apariencia
- **Dracula GTK Theme**: Tema Dracula para aplicaciones GTK
- **Dracula Icons**: Iconos con tema Dracula
- **SDDM Astronaut Theme**: Tema para display manager SDDM
- **Papirus Icon Theme**: Pack de iconos alternativo

### CLI Tools y Productividad
- **Bat**: Clon de `cat` con syntax highlighting
- **Eza**: Reemplazo moderno de `ls` con colores y git integration
- **Lsd**: Otro alternativa a `ls` con iconos
- **Fzf**: Fuzzy finder para terminal
- **Ripgrep**: Búsqueda de texto ultra-rápida (grep alternativo)
- **Lazygit**: TUI para Git con interfaz intuitiva
- **Gum**: Utilidad para crear shell scripts con estilo

### Multimedia
- **Pipewire**: Servidor de audio moderno
- **Pavucontrol**: Control de volumen gráfico
- **Playerctl**: Control de reproductores multimedia
- **Grim + Slurp**: Captura de pantalla para Wayland

## 📦 Instalación en nuevo sistema

### 1. Clonar repositorio
```bash
git clone git@github.com:LeandroNicolas97/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 2. Instalar paquetes
```bash
chmod +x install-packages.sh
./install-packages.sh
```

### 3. Crear symlinks (configuraciones)
```bash
chmod +x setup-symlinks.sh
./setup-symlinks.sh
```

### 4. Reiniciar sesión
```bash
# Cerrar sesión y volver a entrar
# o reiniciar Hyprland
```

## ✏️ Workflow diario

### Editar configuraciones

Se deben editar los archivos en `~/.config/`:
```bash
# Window manager y UI
nano ~/.config/hypr/hyprland.conf
nano ~/.config/waybar/config
nano ~/.config/rofi/config.rasi
nano ~/.config/mako/config

# Terminal y shell
nano ~/.config/kitty/kitty.conf
nano ~/.zshrc
nano ~/.config/starship.toml

# Otras utilidades
nano ~/.config/btop/btop.conf
nano ~/.config/ranger/rc.conf
nano ~/.config/nvim/init.lua
```

Los cambios se aplican inmediatamente y se sincronizan automáticamente con `~/dotfiles/`.

### Usar Rofi
```bash
# Launcher de aplicaciones (distintos estilos)
~/.config/rofi/launchers/type-1/launcher.sh

# Power menu
~/.config/rofi/powermenu/type-1/powermenu.sh

# Applets (volumen, brillo, etc)
~/.config/rofi/applets/bin/volume.sh
~/.config/rofi/applets/bin/brightness.sh
```

### Subir cambios a GitHub
```bash
cd ~/dotfiles

# Ver cambios
git status
git diff

# Commit y push
git add .
git commit -m "Descripción de cambios"
git push origin main
```

### Actualizar lista de paquetes
```bash
cd ~/dotfiles

# Actualizar listas
pacman -Qqe > packages.txt
pacman -Qqm > packages-aur.txt

# Push
git add packages*.txt
git commit -m "Update package list"
git push origin main
```

## 📁 Estructura
```
dotfiles/
├── hyprland/              # Hyprland configs
│   ├── hyprland.conf
│   ├── pyprland.toml
│   ├── random-wallpaper.sh
│   ├── workspace-switcher.sh
│   └── scripts/
├── waybar/                # Waybar configs
│   ├── config
│   ├── style.css
│   └── scripts/
├── rofi/                  # Rofi launcher configs
│   ├── config.rasi
│   ├── launchers/         # Múltiples estilos de launcher
│   ├── powermenu/         # Menús de apagado
│   ├── applets/           # Applets (volumen, brillo, etc)
│   └── colors/            # Temas de color
├── mako/                  # Notificaciones
│   └── config
├── btop/                  # Monitor de sistema
│   └── themes/
├── kitty/                 # Kitty terminal
│   └── kitty.conf
├── fastfetch/             # Fastfetch config
│   └── config.jsonc
├── ranger/                # Ranger file manager
│   ├── rc.conf
│   ├── rifle.conf
│   └── scope.sh
├── nvim/                  # Neovim config
│   ├── init.lua
│   └── lua/
├── zsh/                   # Zsh configs
│   ├── .zshrc
│   └── history
├── starship/              # Starship prompt
│   └── starship.toml
├── packages.txt           # Paquetes oficiales
├── packages-aur.txt       # Paquetes AUR
├── setup-symlinks.sh      # Script de symlinks
├── install-packages.sh    # Script de instalación
├── arch-install.md        # Guía de instalación de Arch
└── README.md
```

## 🎹 Atajos útiles (Hyprland)

Configurados en `~/.config/hypr/hyprland.conf`:
```
SUPER + Q          - Cerrar ventana
SUPER + Return     - Abrir terminal (Kitty)
SUPER + D          - Rofi launcher
SUPER + Shift + E  - Power menu
SUPER + L          - Lockscreen (swaylock)
SUPER + [1-9]      - Cambiar a workspace
SUPER + B          - Toggle waybar
SUPER + F          - Fullscreen
SUPER + V          - Toggle floating
SUPER + Mouse      - Mover/redimensionar ventanas
Print              - Screenshot (grim + slurp)
```

## 📝 Notas

- Las configuraciones se mantienen sincronizadas automáticamente via symlinks
- Los backups se crean como `.backup` antes de crear symlinks
- Se debe actualizar `packages.txt` periódicamente para mantener sincronizadas ambas máquinas
- Las aplicaciones recargan configuraciones automáticamente (excepto Hyprland, requiere reinicio)
- Rofi incluye múltiples temas y estilos, editables en `~/.config/rofi/`
- Mako muestra notificaciones en la esquina superior derecha
- Btop se puede abrir con el comando `btop` en terminal
- Los scripts de Hyprland están en `~/.config/hypr/scripts/`

## 🔐 SSH en nuevo sistema

Para clonar en un sistema nuevo, se debe configurar SSH:
```bash
ssh-keygen -t ed25519 -C "leandroatero97@gmail.com"
cat ~/.ssh/id_ed25519.pub
# Agregar la clave a: https://github.com/settings/keys
```
