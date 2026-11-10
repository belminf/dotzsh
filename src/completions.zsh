# Completions
fpath=(~/.zsh/plugins/zsh-completions/src /opt/homebrew/share/zsh/site-functions $fpath)
autoload -Uz compinit
# Full check once a day, otherwise trust the dump
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi
# Compile the dump in the background for next time
[[ ~/.zcompdump -nt ~/.zcompdump.zwc ]] && zcompile ~/.zcompdump &!
zmodload -i zsh/complist

zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*'  # ignore case, complete after . _ -
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/compcache"
[[ -d ${XDG_CACHE_HOME:-$HOME/.cache}/zsh ]] || mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=1;31'
setopt auto_menu complete_in_word always_to_end
_comp_options+=(globdots)

# Shift-tab reverses in the menu
bindkey -M menuselect '^[[Z' reverse-menu-complete

# fzf (Ctrl-T files, Ctrl-R history, Alt-C cd) using fd for candidates
_fzf_compgen_path() { fd --hidden --follow --exclude ".git" . "$1" }
_fzf_compgen_dir()  { fd --type d --hidden --follow --exclude ".git" . "$1" }
(( $+commands[fzf] )) && source <(fzf --zsh)

# Tab on a new word opens the fzf file picker (Ctrl-T) on an empty line or after a
# file-oriented command; everywhere else it completes as usual (git, kubectl, ssh, cd ...)
typeset -ga TAB_FILE_CMDS=(v vi vim nvim cat bat less head tail rm cp mv ls ll eza tree)
_tab_or_files() {
  local -a words=(${(z)LBUFFER})
  if (( $+widgets[fzf-file-widget] )) &&
     [[ -z $LBUFFER || ( $LBUFFER == *[[:space:]] && ${TAB_FILE_CMDS[(Ie)$words[1]]} -gt 0 ) ]]; then
    zle fzf-file-widget
  else
    zle ${${widgets[fzf-completion]:+fzf-completion}:-expand-or-complete}
  fi
}
zle -N _tab_or_files
bindkey -M viins '^I' _tab_or_files

# Application specific
source "${CLOUDSDK_ROOT_DIR:-/opt/homebrew/share/google-cloud-sdk}/completion.zsh.inc" 2>/dev/null
if (( $+commands[aws_completer] )); then
  autoload -Uz bashcompinit && bashcompinit
  complete -C aws_completer aws
fi
