ZSH_PLUGINS="${HOME}/.zsh/plugins"

function add_plugin() {
  source "${ZSH_PLUGINS}/$1/$1.plugin.zsh"
}

# Faster loading of files
add_plugin evalcache

# Suggestion on cmdline
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion)
add_plugin zsh-autosuggestions

# Additional ZSH completions
add_plugin zsh-completions

# Fzf history search
add_plugin zsh-fzf-history-search

# Rich syntax highlighting
add_plugin fast-syntax-highlighting

# History substring search
add_plugin zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
