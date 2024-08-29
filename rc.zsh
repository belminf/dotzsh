# Oh-my-zsh configuration
export ZSH=$HOME/.zsh/oh-my-zsh
HYPHEN_INSENSITIVE="true"
zstyle ':omz:update' mode reminder # just remind me to update when it's time
DISABLE_UNTRACKED_FILES_DIRTY="true"
ZSH_CUSTOM=$HOME/.zsh/custom
ZSH_AUTOSUGGEST_STRATEGY=(history match_prev_cmd)
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
ZSH_THEME=""

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='
  --color=fg:#cdd6f4,fg+:#d0d0d0,bg:#000000,bg+:#262626
  --color=hl:#89b4fa,hl+:#5fd7ff,info:#f5e0dc,marker:#94e2d5
  --color=prompt:#cba6f7,spinner:#af5fff,pointer:#af5fff,header:#94e2d5
  --color=gutter:#1e1e2e,border:#313244,separator:#313244,scrollbar:#b4befe
  --color=preview-bg:#313244,label:#aeaeae,query:#cdd6f4,disabled:#842626
  --preview-window="border-block" --prompt=" " --marker=">" --pointer="◆"
  --separator="" --scrollbar="│" --layout="reverse"'

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
  fzf
  fzf-tab
  terraform
  copyfile
  copypath
  kitchen
  colored-man-pages
  # Must be last, except for zsh-history-substring-search
  fast-syntax-highlighting
)
fpath+=${ZSH_CUSTOM}/plugins/zsh-completions/src
source $ZSH/oh-my-zsh.sh

# fzf zsh-completion
zstyle ':completion:*:git-checkout:*' sort false
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
# zstyle ':fzf-tab:*' switch-group '<' '>'

# Syntax highlighting
fast-theme -q ~/.zsh/syntax-theme.ini

# Personal configuration
source ~/.zsh/src/options.zsh
source ~/.zsh/src/colors.zsh
source ~/.zsh/src/aliases.zsh
source ~/.zsh/src/ssh_agent.zsh
# Disabling temporarily
# source ~/.zsh/src/bash_completion.zsh
source ~/.zsh/src/ruby.zsh
source ~/.zsh/src/k8s.zsh

# Local config
source ~/.zsh/src/local.zsh 2>/dev/null

# OMP  prompt
_evalcache oh-my-posh init zsh --config "$HOME/.zsh/omp.yaml"
