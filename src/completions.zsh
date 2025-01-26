# Load completions
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C
zmodload -i zsh/complist

# Use menu instead of blind completion
zstyle ':completion:*' menu select

# Submit on first enter
bindkey -M menuselect '^M' .accept-line

# Complete options
setopt menu_complete
setopt complete_in_word
setopt always_to_end
_comp_options+=(globdots)

# Enable shift tab on completion
bindkey -M menuselect '^[[Z' reverse-menu-complete

# fzf
export FZF_DEFAULT_OPTS='
  --color=fg:#cdd6f4,fg+:#d0d0d0,bg:#000000,bg+:#262626
  --color=hl:#89b4fa,hl+:#5fd7ff,info:#f5e0dc,marker:#94e2d5
  --color=prompt:#cba6f7,spinner:#af5fff,pointer:#af5fff,header:#94e2d5
  --color=gutter:#1e1e2e,border:#313244,separator:#313244,scrollbar:#b4befe
  --color=preview-bg:#313244,label:#aeaeae,query:#cdd6f4,disabled:#842626
  --preview-window="border-block" --prompt=" " --marker=">" --pointer="◆"
  --separator="" --scrollbar="│" --layout="reverse"'

# Use fd for generating path candidates
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}
_evalcache fzf --zsh

# Application specific

# GCP
source "${CLOUDSDK_ROOT_DIR:-/opt/homebrew/share/google-cloud-sdk}/completion.zsh.inc" 2>/dev/null

# AWS
# Ref: https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-completion.html
autoload bashcompinit && bashcompinit
complete -C 'aws_completer' aws
