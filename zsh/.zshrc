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
if [ -f /etc/profile.d/fzf.zsh ]; then
  source /etc/profile.d/fzf.zsh
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
export TERM=xterm-kitty

# Activar entorno virtual de Python automáticamente
if [ -f "$HOME/git/oxycontroller/.venv/bin/activate" ]; then
    source "$HOME/git/oxycontroller/.venv/bin/activate"
fi

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export LANG=es_CL.UTF-8
export LC_ALL=es_CL.UTF-8
export ZEPHYR_SDK_INSTALL_DIR=~/zephyr-sdk-0.16.8
export ESP_IDF_PATH=~/git/oxycontroller/deps/esp-idf
export ZEPHYR_SDK_INSTALL_DIR=~/zephyr-sdk-0.16.8
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

export PATH=$PATH:/opt/ba2-toolchain/bin

# Fastfetch con logo aleatorio
if command -v fastfetch &> /dev/null; then
    RANDOM_LOGO=$(~/.config/fastfetch/random-logo.sh)
    fastfetch --logo "$RANDOM_LOGO" --logo-type kitty-direct --logo-width 50 --logo-height 25
fi
