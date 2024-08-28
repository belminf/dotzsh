# Tool options
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias grep='grep --color'
alias egrep='egrep --color=auto'
alias rg='rg -S'
alias tree='tree -C -I "__pycache__|*.pyc"'
alias ll='eza -l -F auto --color=always --git --group-directories-first --all -all'
alias gs='git st'

# Watch with expansion
# Ref: https://unix.stackexchange.com/questions/25327/watch-command-alias-expansion
alias watch='watch '

# Conditional aliases
if hash nvim 2>/dev/null; then
  alias v='nvim'
  alias vim='nvim'
  export EDITOR=nvim
else
  alias v='vim'
  export EDITOR=vim
fi

if hash bat 2>/dev/null; then
  alias cat='bat'
fi

# GNU tool env vars
if hash gls 2>/dev/null; then
  GNU_LS='gls'
else
  GNU_LS='ls'
fi

if hash gwhich 2>/dev/null; then
  GNU_WHICH='gwhich'
else
  GNU_WHICH='which'
fi

function vf() {
  nvim "$(rg --files -u | fzf -1 -q "$@")"
}

function vg() {
  nvim "$(rg -l "$@" | fzf)"
}

function vga() {
  nvim $(rg -l "$@" | tr '\n' ' ')
}

function vc() {
  nvim $(git conflicted | tr '\n' ' ')
}

function mkcd() {
  mkdir -p "$@" && cd "$@" || return
}

function mkproj() {
  mkcd "${HOME}/projects/$1"
}

function cdtmp() {
  cd "$(mktemp -d)" || return
}

function dotfile() {
  case "$1" in
  pull)
    for dotfile in ~/.zsh ~/.tmux ~/.vim; do
      echo "$dotfile:"
      git -C $dotfile pull
      echo
    done
    ;;
  st | status)
    for dotfile in ~/.zsh ~/.tmux ~/.vim; do
      echo "$dotfile:"
      git -C $dotfile st
      echo
    done
    ;;
  *)
    echo "No such command"
    ;;
  esac
}
