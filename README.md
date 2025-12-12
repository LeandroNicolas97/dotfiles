# Arch Linux Dotfiles

Configuración personal de Arch Linux con Hyprland + Waybar + Kitty.

## 🎨 Configuraciones incluidas

- **Hyprland**: Window manager (Wayland)
- **Waybar**: Barra de estado con tema Dracula
- **Kitty**: Terminal con transparencia
- **Fastfetch**: Sistema de información del sistema
- **Ranger**: Gestor de archivos en terminal
- **Neovim**: Editor de texto
- **Zsh**: Shell con Oh-My-Zsh
- **Starship**: Prompt personalizado

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
nano ~/.config/waybar/config
nano ~/.config/kitty/kitty.conf
nano ~/.config/hypr/hyprland.conf
nano ~/.zshrc
```

Los cambios se aplican inmediatamente y se sincronizan automáticamente con `~/dotfiles/`.

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
│   └── hyprland.conf
├── waybar/                # Waybar configs
│   ├── config
│   └── style.css
├── kitty/                 # Kitty terminal
│   └── kitty.conf
├── fastfetch/             # Fastfetch config
│   └── config.jsonc
├── ranger/                # Ranger file manager
│   └── ...
├── nvim/                  # Neovim config
│   └── ...
├── zsh/                   # Zsh configs
│   ├── .zshrc
│   └── oh-my-zsh-custom/
├── starship/              # Starship prompt
│   └── starship.toml
├── packages.txt           # Paquetes oficiales
├── packages-aur.txt       # Paquetes AUR
├── setup-symlinks.sh      # Script de symlinks
├── install-packages.sh    # Script de instalación
└── README.md
```

## 📝 Notas

- Las configuraciones se mantienen sincronizadas automáticamente
- Los backups se crean como `.backup` antes de crear symlinks
- Se debe actualizar `packages.txt` periódicamente
- Las aplicaciones recargan configuraciones automáticamente (excepto Hyprland, requiere reinicio)

## 🔐 SSH en nuevo sistema

Para clonar en un sistema nuevo, se debe configurar SSH:
```bash
ssh-keygen -t ed25519 -C "leandroatero97@gmail.com"
cat ~/.ssh/id_ed25519.pub
# Agregar la clave a: https://github.com/settings/keys
```
