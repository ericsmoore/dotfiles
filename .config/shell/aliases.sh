alias ls='eza -X --no-user'
alias lsa='ls -Ga'
alias l='ls -l'
alias la='ls -la'

alias gst='git status'
alias ga='git add'
alias gc='git commit'
alias gch='git checkout'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'
alias gd='git diff'

alias md='mkdir -p'

alias mvenv='python3 -m venv .venv'
alias activate='source .venv/bin/activate'

alias tec='tectonic'

alias info='fastfetch'
alias cinfo='clear && info'

if [[ "$OSTYPE" == 'linux-gnu'* ]]; then
  alias batt='acpi'
  alias p='wl-paste'
  alias y='wl-copy'
  alias tmux='TERM=xterm-256color tmux'
  alias wifion='nmcli radio wifi on'
  alias wifioff='nmcli radio wifi off'

  if [[ -z "$TMUX" ]]; then
    fastfetch
  fi
elif [[ "$OSTYPE" == 'darwin'* ]]; then
  alias cloud='~/Library/Mobile\ Documents/com~apple~CloudDocs'
  alias processing='/Applications/Processing.app/Contents/MacOS/Processing cli'
fi
