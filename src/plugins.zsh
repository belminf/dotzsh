# Order matters: highlighting wraps widgets, substring-search must come after it.
# zsh-completions is added to fpath in completions.zsh.
_plugin() { source "$HOME/.zsh/plugins/$1/${2:-$1.plugin.zsh}" }

ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion)
_plugin zsh-autosuggestions

_plugin fast-syntax-highlighting
fast-theme -q ~/.zsh/syntax-theme.ini

_plugin zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
