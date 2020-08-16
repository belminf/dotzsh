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
antigen bundle vi-mode

antigen bundle timer
TIMER_PRECISION=2
TIMER_FORMAT="[%d] "

# Must be after vi-mode
# Ref: https://wiki.archlinux.org/index.php/Fzf
antigen bundle fzf

antigen bundle colorize
ZSH_COLORIZE_CHROMA_FORMATTER='terminal256'


antigen bundle zsh-users/zsh-autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=(history match_prev_cmd)
ZSH_AUTOSUGGEST_USE_ASYNC=1

antigen bundle zsh-users/zsh-completions

# Must be last plugin sourced (except for history-substring-search)
# Ref: https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md
antigen bundle zsh-users/zsh-syntax-highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Must be after syntax-highlighting
# Ref: https://github.com/zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-history-substring-search

antigen apply

source ~/.zsh/src/theme.zsh
source ~/.zsh/src/options.zsh
source ~/.zsh/src/aliases.zsh
source ~/.zsh/src/ssh_agent.zsh
