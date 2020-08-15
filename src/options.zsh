# Shell options
set -o noclobber

# Keybindings

## Shift-Tab to accept auto-suggestion
bindkey '^[[Z' autosuggest-execute

# Paging
PAGER=$(command -v less)
LESS='-XRF'
