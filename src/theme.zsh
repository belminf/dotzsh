# Gruvbox palette: the single source of truth for prompt, fzf and completion colors
typeset -gA C=(
  fg '#ebdbb2'  bright '#fbf1c7'  gray '#a89984'  dim '#665c54'  bg '#282828'  sel '#3c3836'
  red '#cc241d' aqua '#8ec07c'    blue '#83a698'  purple '#d3869b'
  yellow '#fabd2f' orange '#fe8019' green '#b8bb26'
)

source "${0:A:h}/prompt.zsh"

# fzf
export FZF_DEFAULT_OPTS="
  --color=fg:$C[fg],bg:-1,hl:$C[yellow],fg+:$C[bright],bg+:$C[sel],hl+:$C[yellow]
  --color=info:$C[gray],prompt:$C[purple],pointer:$C[purple],marker:$C[aqua]
  --color=spinner:$C[purple],header:$C[aqua],border:$C[dim],separator:$C[dim],scrollbar:$C[gray]
  --layout=reverse --prompt=' ' --marker='>' --pointer='◆' --separator='' --scrollbar='│'
  --preview-window=border-block"

# Man pages and less: bold orange headings, aqua flags, yellow search hits (24-bit gruvbox)
_rgb() { printf '\e[%s;2;%d;%d;%dm' "$1" $((16#${2[2,3]})) $((16#${2[4,5]})) $((16#${2[6,7]})) }
export LESS_TERMCAP_md=$'\e[1m'$(_rgb 38 $C[orange])      # bold  (headings)
export LESS_TERMCAP_us=$'\e[4m'$(_rgb 38 $C[aqua])        # underline (flags, args)
export LESS_TERMCAP_so=$(_rgb 38 $C[bg])$(_rgb 48 $C[yellow])  # search hits / status line
export LESS_TERMCAP_me=$'\e[0m' LESS_TERMCAP_ue=$'\e[0m' LESS_TERMCAP_se=$'\e[0m'
unfunction _rgb

# Completion menu
zstyle ':completion:*:descriptions' format "%F{$C[gray]}%d%f"
(( $+commands[dircolors] )) && eval "$(dircolors -b)"
zstyle ':completion:*:messages' format "%F{$C[gray]}%d%f"
zstyle ':completion:*:warnings' format "%F{$C[red]}no matches%f"
# Menu selection: highlight the current item with the palette's selection color
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" \
  "ma=48;2;$((16#${C[sel][2,3]}));$((16#${C[sel][4,5]}));$((16#${C[sel][6,7]}))"

# eza colors
#
# Ref: https://manpages.debian.org/testing/eza/eza_colors.5.en.html
#
# format code:
# 01 - bold
# 04 - underline
# 05 - flashing
# 07 -reverse
#
# Color codes: for i in {0..255}; do printf '\e[38;5;%dm%3d ' $i $i; (((i+3) % 18)) || printf '\e[0m\n'; done

EZA_COLORS="reset:"

# File date
EZA_COLORS+="da=38;5;151:"
# Punctuation
EZA_COLORS+="xx=38;5;240:"

# My user
EZA_COLORS+="uu=38;5;230:"
# Other user
EZA_COLORS+="un=38;5;224:"
# Root user
EZA_COLORS+="uR=38;5;225:"

# User RWX
EZA_COLORS+="ur=38;5;216:uw=38;5;216:ux=38;5;216:ue=38;5;216:"
# Group RWX
EZA_COLORS+="gr=38;5;215:gw=38;5;215:gx=38;5;215:"
# Others RWX
EZA_COLORS+="tr=38;5;209:tw=38;5;209:tx=38;5;209:"
# Size <1KB
EZA_COLORS+="nb=38;5;243:"
# Size < 1MB
EZA_COLORS+="nk=38;5;248:"
# Size <GB
EZA_COLORS+="nm=38;5;250:"
# Size <1TB
EZA_COLORS+="ng=38;5;255:"
# Size > 1TB
EZA_COLORS+="nt=38;5;255:"

# Git
EZA_COLORS+="ga=38;5;105:gm=38;5;105:gd=38;5;105:gv=38;5;105:gt=38;5;105:gi=38;5;105:gc=38;5;105:"

# Directory
EZA_COLORS+="di=38;5;75:"
# Regular files
EZA_COLORS+="fi=38;5;253:"
# Temporary files
EZA_COLORS+="tm=38;5;247:cm=38;5;247:.*=38;5;247:"
# Scripts and code
EZA_COLORS+="co=38;5;121:ex=38;5;121:*.sh=38;5;121:*.zsh=38;5;121:"
# Named pipes
EZA_COLORS+="pi=01;38;5;34:"
# Block devices
EZA_COLORS+="bd=01;38;5;87:"
# Character device
EZA_COLORS+="cd=01;38;5;117:"
# Symlinks
EZA_COLORS+="ln=04;38;5;87:or=04;38;5;87:"
# # Broken symlink
EZA_COLORS+="bO=07;01;38;5;124:"

export EZA_COLORS
