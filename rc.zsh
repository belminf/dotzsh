source ~/.zsh/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle gitfast
antigen bundle vi-mode
antigen bundle command-not-found
antigen bundle colorize
antigen bundle aws
antigen bundle knife
antigen bundle git-prompt
antigen bundle kube-ps1
antigen bundle fzf

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-history-substring-search

antigen apply

source ~/.zsh/theme.zsh
source ~/.zsh/options.zsh
source ~/.zsh/aliases.zsh
