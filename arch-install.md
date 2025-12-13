# Guía Completa de Instalación de Arch Linux + Hyprland

Guía paso a paso para instalar Arch Linux con Hyprland desde cero, usando systemd-boot como bootloader minimalista.

## Tabla de Contenidos
- [Pre-instalación](#pre-instalación)
- [Instalación Base](#instalación-base)
- [Configuración del Sistema](#configuración-del-sistema)
- [Instalación de Hyprland](#instalación-de-hyprland)
- [Configuración Post-instalación](#configuración-post-instalación)
- [Solución de Problemas](#solución-de-problemas)

---

## Pre-instalación

### Preparar USB de instalación
1. Descargar ISO de Arch Linux desde [archlinux.org](https://archlinux.org/download/)
2. Crear USB booteable con Rufus, Etcher o `dd`
3. Arrancar desde USB y seleccionar: **"Arch Linux install medium (x86_64, UEFI)"**

### Configurar teclado
```bash
loadkeys la-latin1
```

---

## Instalación Base

### PASO 1: Verificar modo UEFI
```bash
ls /sys/firmware/efi/efivars
```

### PASO 2: Conectar a Internet

**WiFi:**
```bash
iwctl
```

Dentro de iwctl:
```bash
device list
station wlan0 scan
station wlan0 get-networks
station wlan0 connect "NombreRed"
exit
```

**Verificar conexión:**
```bash
ping -c 3 archlinux.org
```

### PASO 3: Actualizar reloj del sistema
```bash
timedatectl set-ntp true
```

### PASO 4: Identificar discos
```bash
lsblk
```

### PASO 5: Particionar el disco

```bash
cfdisk /dev/nvme0n1
```

**Esquema recomendado:**
1. **EFI**: 1GB - Tipo: `EFI System`
2. **Swap**: 8GB - Tipo: `Linux swap`
3. **Root**: Resto - Tipo: `Linux filesystem`

Acciones en cfdisk:
- `Delete` para eliminar particiones
- `New` para crear particiones
- `Type` para cambiar tipo
- `Write` → `yes` → `Quit`

### PASO 6: Formatear particiones

```bash
mkfs.fat -F32 /dev/nvme0n1p1
mkswap /dev/nvme0n1p2
swapon /dev/nvme0n1p2
mkfs.ext4 /dev/nvme0n1p3
```

### PASO 7: Montar particiones

```bash
mount /dev/nvme0n1p3 /mnt
mkdir -p /mnt/boot
mount /dev/nvme0n1p1 /mnt/boot
```

### PASO 8: Instalar sistema base

```bash
pacstrap /mnt base linux linux-firmware
```

### PASO 9: Generar fstab

```bash
genfstab -U /mnt >> /mnt/etc/fstab
```

### PASO 10: Entrar al sistema

```bash
arch-chroot /mnt
```

---

## Configuración del Sistema

### PASO 11: Configurar zona horaria

```bash
ln -sf /usr/share/zoneinfo/Region/Ciudad /etc/localtime
hwclock --systohc
```

Ejemplos:
- Chile: `America/Santiago`
- México: `America/Mexico_City`
- Argentina: `America/Argentina/Buenos_Aires`

### PASO 12: Configurar idioma

```bash
nano /etc/locale.gen
```

Descomentar (quitar `#`):
```
es_CL.UTF-8 UTF-8
en_US.UTF-8 UTF-8
```

Generar:
```bash
locale-gen
echo "LANG=es_CL.UTF-8" > /etc/locale.conf
echo "KEYMAP=la-latin1" > /etc/vconsole.conf
```

### PASO 13: Configurar red

```bash
echo "arch-nombre" > /etc/hostname
nano /etc/hosts
```

Agregar:
```
127.0.0.1    localhost
::1          localhost
127.0.1.1    arch-nombre.localdomain arch-nombre
```

### PASO 14: Contraseña de root

```bash
passwd
```

### PASO 15: Instalar paquetes esenciales

```bash
pacman -S base-devel linux-headers networkmanager nano vim git sudo
```

### PASO 16: Instalar systemd-boot

```bash
bootctl install
```

**Crear entrada de boot:**
```bash
nano /boot/loader/entries/arch.conf
```

Contenido:
```
title   Arch Linux
linux   /vmlinuz-linux
initrd  /initramfs-linux.img
options root=/dev/nvme0n1p3 rw quiet loglevel=0 systemd.show_status=false rd.udev.log_level=0 vt.global_cursor_default=0
```

**Configurar loader:**
```bash
nano /boot/loader/loader.conf
```

Contenido:
```
default arch.conf
timeout 0
console-mode max
editor no
```

**Habilitar actualizaciones automáticas:**
```bash
systemctl enable systemd-boot-update.service
```

### PASO 17: Habilitar NetworkManager

```bash
systemctl enable NetworkManager
```

### PASO 18: Crear usuario

```bash
useradd -m -G wheel -s /bin/bash usuario
passwd usuario
```

**Dar permisos sudo:**
```bash
EDITOR=nano visudo
```

Descomentar:
```
%wheel ALL=(ALL:ALL) ALL
```

### PASO 19: Reiniciar

```bash
exit
umount -R /mnt
reboot
```

---

## Instalación de Hyprland

### PASO 1: Conectar WiFi
```bash
nmtui
```

### PASO 2: Actualizar sistema
```bash
sudo pacman -Syu
```

### PASO 3: Instalar driver de video

**Intel:**
```bash
sudo pacman -S mesa intel-media-driver vulkan-intel
```

**NVIDIA:**
```bash
sudo pacman -S nvidia nvidia-utils nvidia-settings
```

**AMD:**
```bash
sudo pacman -S mesa xf86-video-amdgpu vulkan-radeon
```

### PASO 4: Instalar yay

```bash
sudo pacman -S --needed git base-devel
cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ~
```

### PASO 5: Instalar Hyprland

```bash
sudo pacman -S hyprland kitty waybar wofi dunst \
  polkit-kde-agent qt5-wayland qt6-wayland \
  xdg-desktop-portal-hyprland pipewire wireplumber \
  grim slurp wl-clipboard cliphist brightnessctl \
  network-manager-applet bluez bluez-utils blueman \
  pavucontrol pamixer alsa-utils swaybg swayidle swaylock mako
```

### PASO 6: Instalar fuentes

```bash
sudo pacman -S ttf-dejavu ttf-liberation noto-fonts \
  noto-fonts-emoji ttf-firacode-nerd ttf-jetbrains-mono-nerd \
  ttf-hack-nerd ttf-meslo-nerd
```

### PASO 7: Instalar Zsh y utilidades

```bash
sudo pacman -S zsh starship eza bat fzf lsd
```

### PASO 8: Instalar Neovim

```bash
sudo pacman -S neovim nodejs npm python python-pip ripgrep fd
```

### PASO 9: Instalar aplicaciones

```bash
sudo pacman -S firefox thunar gvfs ranger htop btop \
  fastfetch vlc mpv tree tmux unzip wget curl
```

### PASO 10: Instalar Oh-My-Zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

**Plugins:**
```bash
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

### PASO 11: Cambiar shell

```bash
chsh -s /usr/bin/zsh
```

### PASO 12: Clonar dotfiles

```bash
git clone https://github.com/TU_USUARIO/dotfiles.git ~/dotfiles
```

### PASO 13: Aplicar dotfiles

```bash
sudo pacman -S stow
cd ~/dotfiles
./setup-symlinks.sh
```

### PASO 14: Instalar paquetes AUR adicionales

```bash
yay -S brave-bin dracula-gtk-theme dracula-icons-git
```

### PASO 15: Habilitar servicios

```bash
systemctl --user enable pipewire wireplumber
sudo systemctl enable bluetooth
```

---

## Configuración Post-instalación

### Configurar Neovim (LazyVim)

**Instalar lazy.nvim:**
```bash
git clone --filter=blob:none https://github.com/folke/lazy.nvim.git \
  --branch=stable ~/.local/share/nvim/lazy/lazy.nvim
```

**Symlink de config:**
```bash
rm -rf ~/.config/nvim
ln -sf ~/dotfiles/nvim ~/.config/nvim
```

**Dependencias LSP:**
```bash
sudo pacman -S ripgrep fd tree-sitter lazygit
npm install -g neovim pyright typescript-language-server vscode-langservers-extracted
pip install pynvim --break-system-packages
```

**Abrir Neovim:**
```bash
nvim
```

### Auto-inicio de Hyprland

**Editar .zprofile:**
```bash
nano ~/.zprofile
```

Agregar:
```bash
if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec Hyprland
fi
```

**Autologin:**
```bash
sudo mkdir -p /etc/systemd/system/getty@tty1.service.d/
sudo nano /etc/systemd/system/getty@tty1.service.d/autologin.conf
```

Contenido:
```
[Service]
ExecStart=
ExecStart=-/sbin/agetty -o '-p -f -- \\u' --noclear --autologin usuario %I $TERM
```

### Configurar locales correctamente

```bash
sudo nano /etc/locale.gen
```

Descomentar locales necesarios, luego:
```bash
sudo locale-gen
sudo localectl set-locale LANG=es_CL.UTF-8
echo 'export LANG=es_CL.UTF-8' >> ~/.zshrc
echo 'export LC_ALL=es_CL.UTF-8' >> ~/.zshrc
```

### Iniciar Hyprland

```bash
Hyprland
```

---

## Solución de Problemas

### Waybar no muestra la hora

Error de locale. Solución:
```bash
sudo locale-gen
sudo localectl set-locale LANG=es_CL.UTF-8
echo 'export LANG=es_CL.UTF-8' >> ~/.zshrc
source ~/.zshrc
pkill waybar && waybar &
```

### Neovim sin configuración

Lazy.nvim no instalado:
```bash
rm -rf ~/.local/share/nvim/lazy/lazy.nvim
git clone --filter=blob:none https://github.com/folke/lazy.nvim.git \
  --branch=stable ~/.local/share/nvim/lazy/lazy.nvim
nvim
```

### Sin internet después de instalar

```bash
sudo systemctl start NetworkManager
sudo systemctl enable NetworkManager
nmtui
```

### Yay se rompe después de actualizar

```bash
cd /tmp
rm -rf yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

### Usar SSH desde otro equipo

En Arch:
```bash
sudo pacman -S openssh
sudo systemctl start sshd
ip a
```

Desde otro PC:
```bash
ssh usuario@IP_DE_ARCH
```

---

## Stack Tecnológico

**Sistema:**
- OS: Arch Linux
- Bootloader: systemd-boot
- Window Manager: Hyprland (Wayland)

**Terminal:**
- Terminal: Kitty
- Shell: Zsh
- Prompt: Starship
- Framework: Oh-My-Zsh

**Desarrollo:**
- Editor: Neovim (LazyVim)
- LSP: Python, TypeScript, etc.

**Utilidades:**
- Bar: Waybar
- Launcher: Wofi
- Notificaciones: Mako/Dunst
- File Manager: Thunar, Ranger
- Browser: Firefox, Brave

---

## Referencias

- [Arch Wiki](https://wiki.archlinux.org/)
- [Hyprland Wiki](https://wiki.hyprland.org/)
- [LazyVim](https://www.lazyvim.org/)
- [systemd-boot](https://wiki.archlinux.org/title/Systemd-boot)

---

**Notas:**
- Guía para instalación UEFI en sistemas single-boot
- Ajustar drivers de video según GPU
- Configurar zona horaria y locales según región
- Los dotfiles requieren personalización

---

*Última actualización: Diciembre 2025*
