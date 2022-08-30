source ~/.zsh/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle gitfast
antigen bundle git-auto-fetch
antigen bundle aws
antigen bundle knife
antigen bundle git-prompt
antigen bundle kube-ps1
antigen bundle ripgrep
antigen bundle golang
antigen bundle direnv

ZSH_COLORIZE_CHROMA_FORMATTER='terminal256'
antigen bundle colorize

ZSH_AUTOSUGGEST_STRATEGY=(history match_prev_cmd)
ZSH_AUTOSUGGEST_USE_ASYNC=1
antigen bundle zsh-users/zsh-autosuggestions

# fzf must be after vi-mode
# Ref: https://wiki.archlinux.org/index.php/Fzf
antigen bundle vi-mode
export FZF_BASE="/opt/homebrew/opt/fzf"
antigen bundle fzf

antigen bundle zsh-users/zsh-completions

# Must be last plugin sourced (except for history-substring-search)
# Ref: https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
antigen bundle zsh-users/zsh-syntax-highlighting

# Must be after syntax-highlighting
# Ref: https://github.com/zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-history-substring-search

antigen apply

#zstyle ':vcs_info:*' enable "NONE"

source ~/.zsh/src/timer.zsh
source ~/.zsh/src/theme.zsh
source ~/.zsh/src/options.zsh
source ~/.zsh/src/aliases.zsh
source ~/.zsh/src/ssh_agent.zsh
source ~/.zsh/src/bash_completion.zsh
source ~/.zsh/src/ruby.zsh
source ~/.zsh/src/k8s.zsh

# Local config
source ~/.zsh/src/local.zsh 2>/dev/null
