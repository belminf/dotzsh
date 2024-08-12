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
VI_MODE_DISABLE_CLIPBOARD=true

# Set up fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_ALT_C_OPTS=" --walker-skip .git,node_modules,target --preview 'tree -C {}'"
export FZF_CTRL_T_OPTS=" --walker-skip .git,node_modules,target --preview 'bat -n --color=always {}' --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export FZF_COMPLETION_OPTS='--border --info=inline'
export FZF_DEFAULT_OPTS='
  --color=fg:#d0d0d0,fg+:#d0d0d0,bg:-1,bg+:#262626
  --color=hl:#5f87af,hl+:#5fd7ff,info:#afaf87,marker:#87ff00
  --color=prompt:#d7005f,spinner:#af5fff,pointer:#af5fff,header:#87afaf
  --color=border:#262626,label:#aeaeae,query:#d9d9d9
  --border="thinblock" --border-label="" --preview-window="border-double" --prompt="> "
  --marker=">" --pointer="◆" --separator="─" --scrollbar="│"
  --layout="reverse" --info="right"'

_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

plugins=(
  evalcache
  aws
  gcloud
  gitfast
  git-auto-fetch
  knife
  kubectl
  golang
  direnv
  vi-mode
  fzf
  terraform
  copyfile
  copypath
  kitchen
  colored-man-pages
  zsh-interactive-cd
  zsh-autosuggestions
  # Must be last, except for zsh-history-substring-search 
  fast-syntax-highlighting
)
fpath+=${ZSH_CUSTOM}/plugins/zsh-completions/src
source $ZSH/oh-my-zsh.sh

# Staship prompt configuration
export STARSHIP_CONFIG="$HOME/.zsh/starship.toml"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_CTYPE=UTF-8
eval "$(PATH="$PATH:/opt/homebrew/bin/" starship init zsh)"

# Syntax highlighting
fast-theme -q ~/.zsh/syntax-theme.ini

# Zoxide
_evalcache zoxide init zsh --cmd cd

# Personal configuration
source ~/.zsh/src/options.zsh
source ~/.zsh/src/aliases.zsh
source ~/.zsh/src/ssh_agent.zsh
# Disabling temporarily
# source ~/.zsh/src/bash_completion.zsh
source ~/.zsh/src/ruby.zsh
source ~/.zsh/src/k8s.zsh

# Local config
source ~/.zsh/src/local.zsh 2>/dev/null
