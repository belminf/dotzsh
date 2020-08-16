# Colors
PS_COLOR_PRIMARY="%F{12}"
PS_COLOR_SECONDARY="%F{144}"
PS_COLOR_FAINT="%F{239}"
PS_COLOR_GOOD="%F{35}"
PS_COLOR_BAD="%F{124}"
PS_COLOR_SOSO="%F{117}"
PS_COLOR_RHS="%F{74}"

# Prompt variables
PROMPT='
${PS_COLOR_PRIMARY}%* ${PS_COLOR_SECONDARY}%3~ ${PS_COLOR_FAINT}%h%{$reset_color%}
%{%(?.${PS_COLOR_PRIMARY}.${PS_COLOR_BAD})%}$%{$reset_color%} '
PROMPT2='${PS_COLOR_PRIMARY}>%{$reset_color%} '
RPROMPT='%{$(echotc UP 1)%}$(__rprompt)%{$(echotc DO 1)%}'
RPROMPT_SEP="${PS_COLOR_FAINT}⸗"

# Git
# NOTE: Assumes git-prompt plugin
ZSH_THEME_GIT_PROMPT_BEHIND="%{↓%G%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{↑%G%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{⇵%G%}"

function __git_info_prompt() {
  precmd_update_git_vars
  if [ -n "$__CURRENT_GIT_STATUS" ]; then
    local git_status

    # Color
    if [ "$GIT_CHANGED" -ne "0"  ] || [ "$GIT_CONFLICTS" -ne "0" ] || [ "$GIT_UNTRACKED" -ne "0" ]; then
      git_status="$PS_COLOR_BAD"
    elif [ "$GIT_STAGED" -ne "0" ]; then
      git_status="$PS_COLOR_GOOD"
    else
      git_status="$PS_COLOR_SOSO"
    fi

    # Symbol(s)
    if [ "$GIT_BEHIND" -ne "0" ]; then
	git_status="${git_status}${ZSH_THEME_GIT_PROMPT_BEHIND}${GIT_BEHIND}"
    fi

    if [ "$GIT_AHEAD" -ne "0" ]; then
	git_status="${git_status}${ZSH_THEME_GIT_PROMPT_AHEAD}${GIT_AHEAD}"
    fi

    if [ "$GIT_BEHIND" -eq "0" ] && [ "$GIT_AHEAD" -eq "0" ]; then
	git_status="${git_status}${ZSH_THEME_GIT_PROMPT_CLEAN}"
    fi

    echo "$git_status ${PS_COLOR_RHS}${GIT_BRANCH}%{${reset_color}%}"
  fi
}

# K8s
# NOTE: Assumes kube-ps1 plugin
KUBE_PS1_PREFIX=""
KUBE_PS1_SUFFIX=""
KUBE_PS1_SEPARATOR=""
KUBE_PS1_DIVIDER=""
KUBE_PS1_NS_COLOR=""
KUBE_PS1_CTX_COLOR=""
KUBE_PS1_SYMBOL_COLOR=""
KUBE_PS1_SYMBOL_DEFAULT="${PS_COLOR_GOOD}k8s/"

function __k8s_cluster_short() {
  echo "${PS_COLOR_RHS}${1}" | sed 's/gke_\([^_]*_\)\{2\}//'
}
KUBE_PS1_CLUSTER_FUNCTION=__k8s_cluster_short

function __k8s_ns_short() {
  local k8s_ns="$1"
  if [ -n "$k8s_ns" ] && [ "$k8s_ns" != "default" ]; then
    echo -n "${PS_COLOR_FAINT}:${PS_COLOR_RHS}${k8s_context}"
  fi
}
KUBE_PS1_NAMESPACE_FUNCTION=__k8s_ns_short

function __k8s_info_prompt() {
  kube_ps1
}

# AWS
function __aws_info_prompt() {
  if [ -n "$AWS_DEFAULT_PROFILE"  ]; then
    echo -n "${PS_COLOR_GOOD}aws/${PS_COLOR_RHS}${AWS_DEFAULT_PROFILE}"
  elif [ -n "$AWS_PROFILE"  ]; then
    echo -n "${PS_COLOR_GOOD}aws/${PS_COLOR_RHS}${AWS_PROFILE}"
  fi
}

# vi mode
MODE_INDICATOR="${PS_COLOR_GOOD}⏏%{${reset_color}%}"
function __vi_info_prompt() {
  vi_mode_prompt_info
}

# Right prompt
function __rprompt {
  local current_sep=""
  local rprompt=""

  for info_prompt in 'vi' 'git' 'k8s' 'aws'; do
    current_info_prompt="$(__${info_prompt}_info_prompt)"
    if [ -n "$current_info_prompt" ]; then
      [ -n "$rprompt" ] && rprompt="$rprompt $RPROMPT_SEP "
      rprompt="${rprompt}${current_info_prompt}"
    fi
  done

  echo "$rprompt"
}

# Theming for plugins
ZSH_COLORIZE_CHROMA_FORMATTER='terminal256'
