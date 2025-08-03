# Tool options
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias grep='grep --color'
alias egrep='egrep --color=auto'
alias rg='rg -S'
alias tree='tree -C -I "__pycache__|*.pyc"'
alias ll='eza -l -F auto --color=always --git --group-directories-first --all -all'
alias gs='git st'

export BAT_STYLE="changes,snip"
alias cat='bat'

# Conditional aliases
if hash nvim 2>/dev/null; then
  alias v='nvim'
  alias vim='nvim'
  export EDITOR=nvim
else
  alias v='vim'
  export EDITOR=vim
fi

# GNU tool env vars
if hash gls 2>/dev/null; then
  export GNU_LS='gls'
else
  export GNU_LS='ls'
fi

if hash gwhich 2>/dev/null; then
  export GNU_WHICH='gwhich'
else
  export GNU_WHICH='which'
fi
