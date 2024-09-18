HISTFILE="${HOME}/.zsh_history"
HISTSIZE=50000
SAVEHIST="$HISTSIZE"

setopt extended_history
setopt hist_reduce_blanks
setopt inc_append_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_save_no_dups
