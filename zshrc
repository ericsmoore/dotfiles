HISTFILE=~/.cache/zsh/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
SHELL_SESSIONS_DISABLE=1
setopt SHARE_HISTORY

autoload -Uz compinit
compinit -d "$HOME/.cache/zsh/zcompdump"
zstyle ':completion:*' matcher-list \
  'm:{a-z}={A-Z}' \
  'm:{A-Z}={a-z}' \
  'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '[%b] '
precmd() { vcs_info }
setopt PROMPT_SUBST

PROMPT='%~ %F{242}${vcs_info_msg_0_}%f: '

setopt AUTO_CD
export CLICOLOR=1

bindkey -v
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^H' backward-delete-char
export KEYTIMEOUT=1

alias _='sudo'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias ls='ls --color=auto'
alias l='ls -l'
alias la='ls -la'
alias lh='ls -ld .*'

alias gst='git status'
alias ga='git add'
alias gc='git commit'
alias gch='git checkout'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'

alias md='mkdir'
alias grep='grep -E --color=auto'

alias cloud='~/Library/Mobile\ Documents/com~apple~CloudDocs'

alias mvenv='python3 -m venv .venv'
alias activate='source .venv/bin/activate'
alias processing='/Applications/Processing.app/Contents/MacOS/Processing cli'
alias tec='tectonic'

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  alias bat='acpi'
  alias p='wl-paste'
  alias y='wl-paste'
  alias tmux='TERM=xterm-256color tmux'
  alias wifion='nmcli radio wifi on'
  alias wifioff='nmcli radio wifi off'
  alias info='fastfetch'
fi

eval "$(zoxide init zsh --cmd c)"

if [[ -z "$TMUX" ]]; then
  fastfetch
fi
