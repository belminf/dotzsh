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
alias cat='bat'

# Conditional aliases
if hash nvim 2>/dev/null; then
  alias v='nvim'
  alias vim='nvim'
  export EDITOR=nvim
else
  alias v='vim'
  export EDITOR=vim
fi

# GNU tool env vars
if hash gls 2>/dev/null; then
  export GNU_LS='gls'
else
  export GNU_LS='ls'
fi

if hash gwhich 2>/dev/null; then
  export GNU_WHICH='gwhich'
else
  export GNU_WHICH='which'
fi

# Shortcut functions
function mkcd() {
  mkdir -p "$@" && cd "$@" || return
}

function mkproj() {
  mkcd "${HOME}/projects/$1"
}

function cdtmp() {
  cd "$(mktemp -d)" || return
}

# vim functions
function vf() {
  nvim "$(rg --files -u | fzf -1 -q "$@")"
}

function vg() {
  nvim "$(rg -l "$@" | tr '\n' ' ')"
}

function vc() {
  nvim "$(git conflicted | tr '\n' ' ')"
}


# dotfile management
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

# clipboard
function copyfile {
  emulate -L zsh
  clipcopy "$1"
}

function copypath {
  # If no argument passed, use current directory
  local file="${1:-.}"

  # If argument is not an absolute path, prepend $PWD
  [[ $file = /* ]] || file="$PWD/$file"

  # Copy the absolute path without resolving symlinks
  # If clipcopy fails, exit the function with an error
  print -n "${file:a}" | clipcopy || return 1

  echo "${(%):-"%B${file:a}%b copied to clipboard."}"
}
