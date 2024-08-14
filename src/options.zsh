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
#
# Ref: https://manpages.debian.org/testing/eza/eza_colors.5.en.html
#
# format code:
# 01 - bold
# 04 - underline
# 05 - flashing
# 07 -reverse
#
# Color codes: for i in {0..255}; do printf '\e[38;5;%dm%3d ' $i $i; (((i+3) % 18)) || printf '\e[0m\n'; done

LS_COLORS=""
EZA_COLORS="reset:"

# File date
EZA_COLORS+="da=38;5;151:"
# My user
EZA_COLORS+="uu=38;5;230:"
# Root user
EZA_COLORS+="uR=38;5;228:"
# User RWX
EZA_COLORS+="ur=38;5;106:uw=38;5;106:ux=38;5;106:ue=38;5;106:"
# Group RWX
EZA_COLORS+="gr=38;5;228:gw=38;5;228:gx=38;5;228:"
# Others RWX
EZA_COLORS+="tr=38;5;125:tw=38;5;125:tx=38;5;125:"
# Punctuation
EZA_COLORS+="xx=38;5;240:"
# Size <1KB
EZA_COLORS+="nb=38;5;243:"
# Size < 1MB
EZA_COLORS+="nk=38;5;248:"
# Size <GB
EZA_COLORS+="nm=38;5;250:"
# Size <1TB
EZA_COLORS+="ng=38;5;255:"
# Size > 1TB
EZA_COLORS+="nt=38;5;255:"
# Git
EZA_COLORS+="ga=38;5;105:gm=38;5;105:gd=38;5;105:gv=38;5;105:gt=38;5;105:gi=38;5;105:gc=38;5;105:"

# Directory
EZA_COLORS+="di=38;5;39:"
# Temporary files
EZA_COLORS+="tm=38;5;242:cm=38;5;242:.*=38;5;242:"
# Scripts and code
EZA_COLORS+="co=38;5;121:ex=38;5;121:*.sh=38;5;121:*.zsh=38;5;121:"
# Named pipes
EZA_COLORS+="pi=01;38;5;34:"
# Block devices
EZA_COLORS+="bd=01;38;5;87:"
# Character device
EZA_COLORS+="cd=01;38;5;117:"
# Symlinks
EZA_COLORS+="ln=04;38;5;87:or=04;38;5;87:"
# # Broken symlink
EZA_COLORS+="bO=07;01;38;5;124:"

export EZA_COLORS
