# Arch Linux Dotfiles

Configuración personal de Arch Linux con Hyprland + Waybar + Kitty, optimizada para sincronización entre múltiples máquinas.

## 🎨 Configuraciones incluidas

### Window Manager y Compositing
- **Hyprland**: Window manager dinámico para Wayland con animaciones y efectos
- **Pyprland**: Plugin manager con funcionalidad de exposé/overview
- **Swayidle** + **Swaylock-effects**: Gestión de bloqueo automático con efectos

### Interfaz de Usuario
- **Waybar**: Barra de estado customizable con tema Dracula y scripts personalizados
- **Rofi**: 7 tipos de launchers, 6 powermenus y múltiples applets (volumen, brillo, etc)
- **Mako**: Sistema de notificaciones con sonidos y estilos por urgencia
- **Wlogout**: Menú de logout/shutdown elegante
- **Swaybg**: Gestor de wallpapers para Wayland

### Terminal y Shell
- **Kitty**: Terminal emulator con GPU acceleration y transparencia
- **Zsh**: Shell avanzado con Oh-My-Zsh
- **Starship**: Prompt minimalista y personalizable

### Utilidades de Sistema
- **Btop**: Monitor de recursos (CPU, RAM, red, procesos)
- **Fastfetch**: Información del sistema
- **Ranger**: File manager para terminal
- **Neovim**: Editor modal con configuración Lua

### Temas y Apariencia
- **Dracula GTK Theme** + **Dracula Icons**: Tema consistente
- **SDDM Themes**: Astronaut y Silent
- **Papirus Icon Theme**: Pack de iconos alternativo
- **Nerd Fonts**: JetBrains Mono, FiraCode, Hack, Meslo

### CLI Tools y Productividad
- **Bat**: `cat` con syntax highlighting
- **Eza** + **Lsd**: Alternativas modernas a `ls`
- **Fzf**: Fuzzy finder para terminal
- **Ripgrep**: Búsqueda ultra-rápida
- **Lazygit**: TUI para Git
- **Gum**: Shell scripts con estilo
- **Cliphist**: Historial del portapapeles

### Multimedia
- **Pipewire** + **Wireplumber**: Audio moderno
- **Pavucontrol**: Control de volumen
- **VLC** + **Discord**: Aplicaciones multimedia
- **Grim** + **Slurp**: Screenshots para Wayland

---

## 📦 Instalación en Sistema Nuevo

### Opción 1: Instalación Automática (Recomendado)

```bash
# 1. Clonar repositorio
git clone https://github.com/LeandroNicolas97/dotfiles.git ~/dotfiles
cd ~/dotfiles

# 2. Ejecutar instalador completo
./install.sh
```

El script `install.sh` hace todo automáticamente:
- ✅ Actualiza mirrors de Arch
- ✅ Instala todos los paquetes (oficiales + AUR)
- ✅ Crea symlinks con backup automático
- ✅ Configura locales
- ✅ Da permisos de ejecución a scripts
- ✅ Maneja errores y dependencias rotas

### Opción 2: Instalación Manual (Paso a Paso)

```bash
# 1. Clonar repositorio
git clone https://github.com/LeandroNicolas97/dotfiles.git ~/dotfiles
cd ~/dotfiles

# 2. Actualizar sistema y mirrors (IMPORTANTE)
sudo pacman -Syy
sudo pacman -Syu

# 3. Instalar yay (si no está instalado)
cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ~/dotfiles

# 4. Instalar paquetes
./install-packages.sh

# 5. Configurar symlinks
./setup-symlinks.sh

# 6. Generar locale (si hay warnings)
sudo sed -i 's/^#es_CL.UTF-8/es_CL.UTF-8/' /etc/locale.gen
sudo locale-gen

# 7. Recargar Hyprland o cerrar sesión
```

---

## 🔄 Workflow: Sincronización entre Laptops

### Script de Sincronización

Usa `sync.sh` para mantener sincronizados tus dotfiles entre múltiples máquinas:

```bash
cd ~/dotfiles

# Ver estado actual
./sync.sh status

# Descargar cambios desde GitHub (desde otra laptop)
./sync.sh pull

# Subir cambios a GitHub (después de editar configs)
./sync.sh push

# Sincronización completa (pull + instalar faltantes + push)
./sync.sh sync
```

### Flujo de Trabajo Diario

**En Laptop A (donde haces cambios):**
```bash
# 1. Editar configuraciones
nvim ~/.config/hypr/hyprland.conf
nvim ~/.config/waybar/config

# 2. Probar cambios
hyprctl reload

# 3. Subir a GitHub cuando estés satisfecho
cd ~/dotfiles
./sync.sh push
```

**En Laptop B (para aplicar cambios):**
```bash
# 1. Descargar cambios
cd ~/dotfiles
./sync.sh pull

# 2. Si hay paquetes nuevos, instalarlos
./sync.sh sync

# 3. Recargar Hyprland
hyprctl reload
```

### Actualizar Lista de Paquetes

Cuando instalas software nuevo, actualiza la lista:

```bash
cd ~/dotfiles

# Actualizar automáticamente
pacman -Qqe > packages.txt
pacman -Qqm > packages-aur.txt

# Subir cambios
git add packages*.txt
git commit -m "Update package list"
git push origin main
```

---

## 🛠️ Troubleshooting

### Problema: Conflictos de Dependencias

```bash
# Solución: Actualizar sistema completo primero
sudo pacman -Syu

# Luego intentar instalar paquetes
cd ~/dotfiles
./install.sh
```

### Problema: Mirrors lentos o con errores 404

```bash
# Actualizar mirrors con reflector
sudo pacman -S reflector
sudo reflector --country Chile --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Syy
```

### Problema: Warnings de locale (setlocale)

```bash
# Generar locale español Chile
sudo sed -i 's/^#es_CL.UTF-8/es_CL.UTF-8/' /etc/locale.gen
sudo locale-gen
```

### Problema: Errores de "overview" en Hyprland

```bash
# Ya está solucionado en la última versión
# Si persiste, recargar config
hyprctl reload
```

### Problema: Paquetes AUR no se instalan

```bash
# Instalar yay primero
cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# Luego intentar de nuevo
cd ~/dotfiles
yay -S --needed - < packages-aur.txt
```

---

## 📁 Estructura del Repositorio

```
dotfiles/
├── hyprland/              # Hyprland config
│   ├── hyprland.conf      # Config principal
│   ├── pyprland.toml      # Config de pyprland (exposé)
│   ├── random-wallpaper.sh
│   ├── workspace-switcher.sh
│   └── scripts/
│       ├── zoom.sh        # Control de zoom del monitor
│       └── random-wallpaper.sh
├── waybar/                # Waybar
│   ├── config             # Configuración principal
│   ├── style.css          # Estilos Dracula
│   ├── get_distro_icon.sh
│   ├── hyprland-workspaces.sh
│   ├── workspace-icons.sh
│   └── mediaplayer.sh
├── rofi/                  # Rofi launchers y menus
│   ├── config.rasi
│   ├── theme.rasi
│   ├── launchers/         # 7 tipos de launchers
│   │   ├── type-1/        # 15 estilos cada uno
│   │   ├── type-2/
│   │   └── ...
│   ├── powermenu/         # 6 tipos de powermenus
│   ├── applets/           # Applets (volumen, brillo, etc)
│   │   └── bin/
│   │       ├── volume.sh
│   │       ├── brightness.sh
│   │       ├── screenshot.sh
│   │       └── ...
│   └── colors/            # 16 esquemas de color
├── mako/                  # Notificaciones
│   └── config             # Config con sonidos y estilos
├── kitty/                 # Terminal
│   └── kitty.conf
├── btop/                  # Monitor de sistema
│   └── themes/
├── nvim/                  # Neovim
│   ├── init.lua
│   └── lua/
├── zsh/                   # Shell
│   └── .zshrc
├── starship/              # Prompt
│   └── starship.toml
├── fastfetch/             # System info
│   └── config.jsonc
├── ranger/                # File manager
│   └── rc.conf
├── packages.txt           # Paquetes oficiales
├── packages-aur.txt       # Paquetes AUR
├── install.sh             # ⭐ Instalador automático
├── sync.sh                # ⭐ Sincronizador entre laptops
├── install-packages.sh    # Script de paquetes
├── setup-symlinks.sh      # Script de symlinks
├── check-installation.sh  # Verificador de instalación
├── fix-locale.sh          # Solucionador de locales
└── README.md              # Este archivo
```

---

## 🎹 Atajos de Teclado (Hyprland)

### Ventanas y Navegación
```
SUPER + Q              - Cerrar ventana
SUPER + V              - Toggle floating
SUPER + F              - Fullscreen
SUPER + P              - Pseudo (tiling especial)
SUPER + J/K/L/I        - Mover foco (vim keys)
SUPER + Shift + J/K/L  - Mover ventana
SUPER + Mouse izq      - Mover ventana
SUPER + Mouse der      - Redimensionar ventana
```

### Aplicaciones
```
SUPER + Return         - Terminal (Kitty)
SUPER + D              - Rofi launcher
SUPER + Shift + E      - Power menu
SUPER + L              - Lockscreen (swaylock)
SUPER + H              - Navegador
SUPER + S              - Spotify
```

### Workspaces
```
SUPER + [1-9]          - Cambiar a workspace
SUPER + Shift + [1-9]  - Mover ventana a workspace
SUPER + TAB            - Exposé (ver todos los workspaces)
SUPER + Mouse scroll   - Cambiar workspace
```

### Sistema
```
SUPER + B              - Toggle waybar
SUPER + N              - Recargar waybar
Print                  - Screenshot (grim + slurp)
SUPER + Shift + R      - Recargar Hyprland
```

---

## 📝 Editar Configuraciones

Las configuraciones están en `~/.config/` y se sincronizan automáticamente con `~/dotfiles/`:

```bash
# Window manager
nvim ~/.config/hypr/hyprland.conf
nvim ~/.config/hypr/pyprland.toml

# UI y apariencia
nvim ~/.config/waybar/config
nvim ~/.config/waybar/style.css
nvim ~/.config/rofi/config.rasi
nvim ~/.config/mako/config

# Terminal y shell
nvim ~/.config/kitty/kitty.conf
nvim ~/.zshrc
nvim ~/.config/starship.toml

# Otras herramientas
nvim ~/.config/btop/btop.conf
nvim ~/.config/nvim/init.lua
```

**Los cambios se aplican automáticamente** (excepto Hyprland que necesita `hyprctl reload`).

---

## 🎨 Personalización Rápida

### Cambiar Launcher de Rofi
```bash
# Probar diferentes estilos
~/.config/rofi/launchers/type-1/launcher.sh
~/.config/rofi/launchers/type-2/launcher.sh
# ... hasta type-7

# Cada tipo tiene múltiples estilos en style-1.rasi, style-2.rasi, etc
```

### Cambiar Tema de Color de Rofi
```bash
# Editar ~/.config/rofi/colors/ y seleccionar uno de:
# - dracula.rasi (actual)
# - catppuccin.rasi
# - nord.rasi
# - tokyonight.rasi
# - gruvbox.rasi
# ... 16 temas disponibles
```

### Cambiar Wallpaper
```bash
# Script de wallpaper aleatorio
~/.config/hypr/random-wallpaper.sh

# O configurar wallpaper fijo en hyprland.conf:
# exec-once = swaybg -i ~/Wallpapers/tu-imagen.jpg
```

---

## 🔐 Configuración SSH (Para Nuevo Sistema)

```bash
# Generar clave SSH
ssh-keygen -t ed25519 -C "tu-email@example.com"

# Copiar clave pública
cat ~/.ssh/id_ed25519.pub

# Agregar a GitHub: https://github.com/settings/keys
```

---

## 📚 Scripts Útiles

| Script | Descripción |
|--------|-------------|
| `install.sh` | Instalación completa automática |
| `sync.sh` | Sincronización entre laptops |
| `check-installation.sh` | Verificar qué paquetes están instalados |
| `fix-locale.sh` | Solucionar warnings de locale |
| `update-system.sh` | Actualizar sistema completo |

---

## 🌟 Características Destacadas

- ✅ **Instalación automatizada** con manejo de errores
- ✅ **Sincronización entre laptops** con un comando
- ✅ **Symlinks automáticos** con backup de configs existentes
- ✅ **Temas consistentes** (Dracula en todo el sistema)
- ✅ **Scripts robustos** que manejan dependencias rotas
- ✅ **Documentación completa** con troubleshooting
- ✅ **Configuración modular** fácil de personalizar

---

## 🤝 Contribuir

Este es un repositorio personal, pero si encuentras algo útil, siéntete libre de hacer fork y adaptarlo a tus necesidades.

## 📄 Licencia

MIT License - Uso libre
