# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
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

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
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

# Configuración de búsqueda en historial (Ctrl+R)
# Mejora la búsqueda con exact match para encontrar comandos específicos
export FZF_CTRL_R_OPTS="--exact"

# Usar fd en lugar de find (más rápido, opcional)
# Primero instala fd: sudo pacman -S fd
# export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
# export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Preview de archivos con bat (opcional)
# Primero instala bat: sudo pacman -S bat
# export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :500 {}'"

# Buscar en directorios con tree preview (opcional)
# export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
export TERM=xterm-kitty
export TERM=xterm-kitty

<<<<<<< HEAD
# Fastfetch con logo aleatorio
LOGO_DIR="$HOME/.config/fastfetch/logos"
RANDOM_LOGO=$(find "$LOGO_DIR" -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.webp" \) | shuf -n 1)

# Ejecutar fastfetch directamente con la imagen aleatoria
fastfetch --logo "$RANDOM_LOGO" --logo-type kitty --logo-width 35 --logo-height 20
=======
# Fastfetch
fastfetch

# Activar entorno virtual de Python automáticamente
if [ -f "$HOME/git/oxycontroller/.venv/bin/activate" ]; then
    source "$HOME/git/oxycontroller/.venv/bin/activate"
fi

>>>>>>> 36aca32 (Update terminal and shell configurations)
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
