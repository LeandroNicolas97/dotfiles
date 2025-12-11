# Arch Linux Dotfiles

Mi configuración personal de Arch Linux con Hyprland + Waybar + Kitty.

## 🎨 Configuraciones incluidas

- **Hyprland**: Window manager (Wayland)
- **Waybar**: Barra de estado con tema Dracula
- **Kitty**: Terminal con transparencia
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

Edita tus archivos como siempre en `~/.config/`:
```bash
nano ~/.config/waybar/config.jsonc
nano ~/.config/kitty/kitty.conf
nano ~/.config/hypr/hyprland.conf
nano ~/.zshrc
```

Los cambios se aplican inmediatamente y **se sincronizan automáticamente** con `~/dotfiles/`.

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
│   ├── config.jsonc
│   └── style.css
├── kitty/                 # Kitty terminal
│   └── kitty.conf
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

## 🔗 Cómo funcionan los symlinks

Los archivos en `~/.config/` son enlaces simbólicos a `~/dotfiles/`:
```
~/.config/waybar  -> ~/dotfiles/waybar
~/.config/hypr    -> ~/dotfiles/hyprland
~/.config/kitty   -> ~/dotfiles/kitty
~/.zshrc          -> ~/dotfiles/zsh/.zshrc
```

Esto significa:
- ✅ Editas en `~/.config/` como siempre
- ✅ Los cambios están automáticamente en git
- ✅ No necesitas sincronizar manualmente

## 🔧 Solución de problemas

### Verificar symlinks
```bash
ls -la ~/.config/ | grep -E "waybar|hypr|kitty"
```

Deberías ver `->` indicando symlinks.

### Recrear symlinks
```bash
cd ~/dotfiles
./setup-symlinks.sh
```

### Conflicto de archivos

Si hay conflictos, los originales se respaldan como `.backup`:
```bash
ls ~/.config/*.backup
```

## 📝 Notas

- Las configuraciones se mantienen sincronizadas automáticamente
- Los backups se crean como `.backup` antes de crear symlinks
- Actualiza `packages.txt` periódicamente
- Las apps recargan configs automáticamente (excepto Hyprland, usa `Mod+Shift+R`)

## 🔐 SSH en nuevo sistema

Para clonar en un sistema nuevo, necesitas configurar SSH:
```bash
ssh-keygen -t ed25519 -C "leandroatero97@gmail.com"
cat ~/.ssh/id_ed25519.pub
# Agregar la clave a: https://github.com/settings/keys
```
