# Shell options
set -o noclobber

# Keybindings

## Alt-Space to accept auto-suggestion
bindkey '^[ ' autosuggest-execute

## Up and down for history substring search
bindkey '\eOA' history-substring-search-up
bindkey '\eOB' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Paging
export PAGER="$(command -v less)"
export LESS='-XRF'

# PATHS
typeset -U cdpath
setopt auto_cd
cdpath+=("${HOME}/projects")
path+=("${HOME}/.local/bin")
export PATH
