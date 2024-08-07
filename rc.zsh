# Oh-my-zsh configuration
export ZSH=$HOME/.zsh/oh-my-zsh
ZSH_THEME=""
HYPHEN_INSENSITIVE="true"
zstyle ':omz:update' mode reminder  # just remind me to update when it's time
DISABLE_UNTRACKED_FILES_DIRTY="true"
ZSH_CUSTOM=$HOME/.zsh/custom
ZSH_AUTOSUGGEST_STRATEGY=(history match_prev_cmd)
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Set up fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_ALT_C_OPTS=" --walker-skip .git,node_modules,target --preview 'tree -C {}'"
export FZF_CTRL_T_OPTS=" --walker-skip .git,node_modules,target --preview 'bat -n --color=always {}' --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export FZF_COMPLETION_OPTS='--border --info=inline'
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

plugins=(
  aws
  gcloud
  gitfast
  git-auto-fetch
  knife
  golang
  direnv
  colorize
  vi-mode
  fzf
  terraform
  tldr
  copyfile
  copypath
  kitchen
  zsh-interactive-cd
  zsh-autosuggestions
  # Must be last, except for zsh-history-substring-search 
  zsh-syntax-highlighting 
)
fpath+=${ZSH_CUSTOM}/plugins/zsh-completions/src
source $ZSH/oh-my-zsh.sh


# Staship prompt configuration
export STARSHIP_CONFIG="$HOME/.zsh/starship.toml"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_CTYPE=UTF-8
eval "$(PATH="$PATH:/opt/homebrew/bin/" starship init zsh)"

# Personal configuration
source ~/.zsh/src/options.zsh
source ~/.zsh/src/aliases.zsh
source ~/.zsh/src/ssh_agent.zsh
source ~/.zsh/src/bash_completion.zsh
source ~/.zsh/src/ruby.zsh
source ~/.zsh/src/k8s.zsh

# Local config
source ~/.zsh/src/local.zsh 2>/dev/null
