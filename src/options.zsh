# Environment
export MANPATH="/usr/local/man:$MANPATH"
export ARCHFLAGS="-arch $(uname -m)"

# Shell options
set -o noclobber

# Paging
export PAGER="$(command -v less)"
export LESS='-XRF'

# PATHS
typeset -U cdpath
setopt auto_cd
cdpath+=("${HOME}/projects" "$HOME")
path+=("${HOME}/.local/bin")
export PATH="/opt/homebrew/bin:$PATH"

# Push line
bindkey '^q' push-line-or-edit

# ls colors
export LS_COLORS="$(vivid generate snazzy)"
EZA_COLORS+="da=36:"
EZA_COLORS+="ur=0:uw=0:ux=0:ue=0:"
EZA_COLORS+="gr=0:gw=0:gx=0:"
EZA_COLORS+="tr=0:tw=0:tx=0:"
EZA_COLORS+="xa=0:"
EZA_COLORS+="xx=38;5;240:"
EZA_COLORS+="nb=38;5;240:"
EZA_COLORS+="nk=0:"
EZA_COLORS+="nm=37:"
EZA_COLORS+="ng=38;5;250:"
EZA_COLORS+="nt=38;5;255:"
EZA_COLORS+="do=32:*.md=32:"
EZA_COLORS+="co=35:*.zip=35:"
EZA_COLORS+="tm=38;5;242:cm=38;5;242:.*=38;5;242:"
export EZA_COLORS
