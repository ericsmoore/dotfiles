#!/usr/bin/env bash

[[ -n $PS1 ]] || return

export HISTFILE="$HOME/.cache/bash/.bash_history"
export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTCONTROL=ignoredups

bind "set completion-ignore-case on"

_git_branch() {
  local branch
  branch=$(git symbolic-ref --short HEAD 2>/dev/null) && echo "[$branch] "
}

PS1='\w \[\e[38;5;242m\]$(_git_branch)\[\e[0m\]; '

set -o vi
bind -m vi-insert '"\C-?": backward-delete-char'

export EZA_CONFIG_DIR='/Users/ericmoore/.config/eza/'

source "$HOME/.config/shell/aliases.sh" 

eval "$(zoxide init bash --cmd cd)"
