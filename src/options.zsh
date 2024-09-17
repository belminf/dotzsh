# Environment
export MANPATH="/usr/local/man:$MANPATH"
export ARCHFLAGS="-arch $(uname -m)"

# vi mode
bindkey -v
bindkey -M vicmd v edit-command-line
export KEYTIMEOUT=1

# Cursor management
# Ref: https://gist.github.com/LukeSmithxyz/e62f26e55ea8b0ed41a65912fbebbe52
function zle-keymap-select {

  # Cursor for command mode
  if [[ ${KEYMAP} == vicmd ]] ||
    [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'

  # Everything else
  elif [[ ${KEYMAP} == main ]] ||
    [[ ${KEYMAP} == viins ]] ||
    [[ ${KEYMAP} = '' ]] ||
    [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
  zle -K viins
  echo -ne "\e[5 q"
}
zle -N zle-line-init

# Shell options
set -o noclobber

# Paging
export PAGER="$(command -v less)"
export LESS='-XRF'

# PATHS
typeset -U cdpath
cdpath+=("${HOME}/projects" "$HOME")
path+=("${HOME}/.local/bin")
export PATH="/opt/homebrew/bin:$PATH"

setopt auto_cd
setopt extendedglob
setopt nomatch
setopt interactive_comments

# Push line
bindkey '^q' push-line-or-edit

# Disable CTRL-S
stty stop undef
stty start undef
