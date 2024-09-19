# Environment
export MANPATH="/usr/local/man:$MANPATH"
export ARCHFLAGS="-arch $(uname -m)"
export PAGER="$(command -v less)"
export LESS='-XRF'

# Shell options
set -o noclobber
setopt extendedglob
setopt nomatch
setopt interactive_comments

# PATHS
typeset -U cdpath
cdpath+=("${HOME}/projects" "$HOME")
path+=("${HOME}/.local/bin")
export PATH="/opt/homebrew/bin:$PATH"

# vi mode
autoload -U edit-command-line
zle -N edit-command-line
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

# Push line
bindkey '^q' push-line-or-edit

# Disable CTRL-S
stty stop undef
stty start undef

# CTRL-B for buffer copy
function copybuffer {
  if builtin which clipcopy &>/dev/null; then
    printf "%s" "$BUFFER" | clipcopy
  else
    zle -M "clipcopy not found. Please make sure you have Oh My Zsh installed correctly."
  fi
}

zle -N copybuffer

bindkey -M viins "^B" copybuffer
bindkey -M vicmd "^B" copybuffer
