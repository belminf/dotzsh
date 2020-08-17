# Tool options
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias grep='grep --color'
alias egrep='egrep --color=auto'
alias rg='rg -S'
alias tree='tree -C -I "__pycache__|*.pyc"'

# Git
alias ga='git add'
alias gap='git add -p'
alias gs='git st'
alias gp='git push'
alias gpu='git pull'
alias gpf='git push -f'
alias gc='git commit -m'
alias gca='git commit -a -m'
alias gcm='git commend'
alias gcmm='git commend -m'
alias gl='git lg'
alias gd='git diff'
alias gdc='git diff --cached'

# Watch with expansion
# Ref: https://unix.stackexchange.com/questions/25327/watch-command-alias-expansion
alias watch='watch '

# Conditional aliases
if hash nvim 2>/dev/null; then
  alias v='nvim'
  alias vim='nvim'
else
  alias v='vim'
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

# Functions
function ll() {
  LC_COLLATE=C $GNU_LS -lahF --group-directories-first --color=tty --hide="*.pyc" --hide="__pycache__" "$@"
}
unalias ll

function vf() {
  nvim "$(rg --files -u | fzf -1 -q "$@")"
}

function vg() {
  nvim "$(rg -l "$@" | fzf)"
}

function vga() {
  nvim $(rg -l "$@" | tr '\n' ' ')
}

function clip() {

  # x11 - Arch
  if hash xclip 2>/dev/null; then
    xclip -selection clipboard <"$1"

  # macOS
  else
    pbcopy <"$1"
  fi
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
