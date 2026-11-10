# Environment
export MANPATH="/usr/local/man:$MANPATH"
export ARCHFLAGS="-arch $CPUTYPE"
export PAGER="$(command -v less)"
export LESS='-XRF'

# Shell options
set -o noclobber
setopt extendedglob
setopt nomatch
setopt interactive_comments

# PATHS
typeset -U cdpath path
cdpath=("." "${HOME}/projects" "$HOME")
path=("${HOME}/.local/bin" /opt/homebrew/bin(N) $path)

# vi mode
autoload -U edit-command-line
zle -N edit-command-line
bindkey -v
bindkey -M vicmd v edit-command-line
export KEYTIMEOUT=1

# Cursor: block in normal mode, beam in insert mode
# Ref: https://gist.github.com/LukeSmithxyz/e62f26e55ea8b0ed41a65912fbebbe52
autoload -Uz add-zle-hook-widget
_cursor_shape() { [[ $KEYMAP == vicmd ]] && print -n '\e[1 q' || print -n '\e[5 q' }
_line_init() { zle -K viins; _cursor_shape }
add-zle-hook-widget zle-keymap-select _cursor_shape
add-zle-hook-widget zle-line-init _line_init

# Push line
bindkey '^q' push-line-or-edit

# Disable CTRL-S
[[ -t 0 ]] && stty stop undef start undef

# CTRL-B for buffer copy
function copybuffer {
  if (( $+functions[clipcopy] )); then
    printf "%s" "$BUFFER" | clipcopy
  else
    zle -M "clipcopy not found"
  fi
}

zle -N copybuffer

bindkey -M viins "^B" copybuffer
bindkey -M vicmd "^B" copybuffer
