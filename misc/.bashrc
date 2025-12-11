#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Created by `pipx` on 2025-12-08 13:41:45
export PATH="$PATH:/home/leandro/.local/bin"
eval "$(fzf --bash)"
export TERM=xterm-kitty
export TERM=xterm-kitty
