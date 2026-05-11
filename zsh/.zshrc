# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
    git
    sudo
    command-not-found
    zsh-autosuggestions
    zsh-syntax-highlighting
    fzf
)
source $ZSH/oh-my-zsh.sh

# User configuration

# ============================================
# HISTORIAL
# ============================================
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history

# No guardar comandos que empiezan con # (comentarios) en el historial
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

eval "$(starship init zsh)"

# ============================================
# FZF CONFIGURATION
# ============================================

# Cargar keybindings de fzf (Ctrl+R para historial, Ctrl+T para archivos, Alt+C para directorios)
if command -v fzf &>/dev/null; then
  eval "$(fzf --zsh)"
fi

# Configuración de FZF
export FZF_DEFAULT_OPTS="
--height 40%
--layout=default
--border
--inline-info
--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9
--color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9
--color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6
--color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4"

export FZF_CTRL_R_OPTS="--exact"

export TERM=xterm-kitty

# Activar entorno virtual de Python automáticamente
if [ -f "$HOME/git/oxycontroller/.venv/bin/activate" ]; then
    source "$HOME/git/oxycontroller/.venv/bin/activate"
fi

export PATH="$HOME/.local/bin:$PATH"
#export LANG=es_CL.UTF-8
#export LC_ALL=es_CL.UTF-8
export ZEPHYR_SDK_INSTALL_DIR=~/zephyr-sdk-0.16.8
export ESP_IDF_PATH=~/git/oxycontroller/deps/esp-idf

export PATH=$PATH:/opt/ba2-toolchain/bin

# Fastfetch con logo aleatorio
if command -v fastfetch &> /dev/null; then
    RANDOM_LOGO=$(~/.config/fastfetch/random-logo.sh)
    fastfetch --logo "$RANDOM_LOGO" --logo-type kitty-direct --logo-width 50 --logo-height 25
fi
if [ -d "$HOME/.pyenv" ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi
export PATH="$HOME/.cargo/bin:$PATH"

# opencode
export PATH=/home/leandro/.opencode/bin:$PATH

# ZMK cornev3
_ZMK_DIR="$HOME/leandro-git/cornev3-firmware"
_ZMK_CFG="$_ZMK_DIR/config"

# BLE (split inalambrico)
zmk-left()         { west build -s zmk/app -b nice_nano/nrf52840/zmk -d "$_ZMK_DIR/build/cornev3_left"        -- -DSHIELD="cornev3_left"                                 -DZMK_CONFIG="$_ZMK_CFG"; }
zmk-right()        { west build -s zmk/app -b nice_nano/nrf52840/zmk -d "$_ZMK_DIR/build/cornev3_right"       -- -DSHIELD="cornev3_right nice_view_adapter nice_view"     -DZMK_CONFIG="$_ZMK_CFG"; }
zmk-both()         { zmk-left && zmk-right; }

# Wired (split TRRS/UART)
zmk-left-wired()   { west build -s zmk/app -b nice_nano/nrf52840/zmk -d "$_ZMK_DIR/build/cornev3_left_wired"  -- -DSHIELD="cornev3_left_wired"                            -DZMK_CONFIG="$_ZMK_CFG"; }
zmk-right-wired()  { west build -s zmk/app -b nice_nano/nrf52840/zmk -d "$_ZMK_DIR/build/cornev3_right_wired" -- -DSHIELD="cornev3_right_wired nice_view_adapter nice_view" -DZMK_CONFIG="$_ZMK_CFG"; }
zmk-both-wired()   { zmk-left-wired && zmk-right-wired; }

zmk-flash() {
    local side=${1:-right}
    local uf2="$_ZMK_DIR/build/cornev3_${side}/zephyr/zmk.uf2"
    [[ ! -f "$uf2" ]] && echo "UF2 no encontrado: $uf2" && return 1
    local dev=$(lsblk -o NAME,LABEL -rn | awk '/NICENANO/{print "/dev/"$1}')
    [[ -z "$dev" ]] && echo "NICENANO no encontrado. Hacé doble tap en reset." && return 1
    udisksctl mount -b "$dev" 2>/dev/null
    cp "$uf2" /run/media/leandro/NICENANO/ && echo "Flasheado: $side"
}
export PATH="$HOME/.npm-global/bin:$PATH"

# Config específica de esta máquina (no commiteado)
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
