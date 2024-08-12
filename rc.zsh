# Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Oh-my-zsh configuration
export ZSH=$HOME/.zsh/oh-my-zsh
HYPHEN_INSENSITIVE="true"
zstyle ':omz:update' mode reminder  # just remind me to update when it's time
DISABLE_UNTRACKED_FILES_DIRTY="true"
ZSH_CUSTOM=$HOME/.zsh/custom
ZSH_AUTOSUGGEST_STRATEGY=(history match_prev_cmd)
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
VI_MODE_DISABLE_CLIPBOARD=true

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"
source ~/.zsh/p10k.zsh

# fzf
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

# Syntax highlighting
fast-theme -q ~/.zsh/syntax-theme.ini

# Zoxide
function add_cdpath_to_zoxide() {
  local pths = ()
  for pth in $cdpath ; do
    [[ -d "$pth" ]] && pths += ("${pth}"/*(/N))
  done
  if [[ ${#pths[@]} -gt 0 ]]; then
    zoxide add "${pths[@]}"
  fi
}
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
