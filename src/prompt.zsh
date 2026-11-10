# Minimal prompt: pure zsh, no oh-my-posh. The git segment is filled in asynchronously,
# so the prompt appears instantly and the branch/status shows up a moment later.
#
#   ~/.zsh  master +!⇡ 1.2s
#   ❯
#
# git: branch (or @sha), + staged, ? untracked / ! modified, ⇣ behind, ⇡ ahead, ≡ stash
# Colors come from the palette in theme.zsh ($C).

zmodload zsh/datetime
setopt prompt_subst
autoload -Uz add-zsh-hook add-zle-hook-widget

typeset -g _prompt_dir _prompt_start _prompt_time _prompt_local _prompt_git_seg _prompt_fd
typeset -gi _prompt_ret=0

_prompt_preexec() { _prompt_start=$EPOCHREALTIME }

# Prints one line: the git segment (empty outside a repo). Runs in a background subshell.
_prompt_git() {
  local out line ab branch oid X Y
  local -i ahead=0 behind=0 stash=0 staged=0 dirty=0 untracked=0
  out=$(command git status --porcelain=v2 --branch --show-stash 2>/dev/null) || return

  for line in "${(@f)out}"; do
    case $line in
      '# branch.oid '*)  oid=${line#\# branch.oid } ;;
      '# branch.head '*) branch=${line#\# branch.head } ;;
      '# branch.ab '*)   ab=${line#\# branch.ab }; ahead=${${ab%% *}#+}; behind=${ab##* -} ;;
      '# stash '*)       stash=${line#\# stash } ;;
      '?'*)              untracked=1 ;;
      [12u]\ *)          X=${line[3]} Y=${line[4]}
                         [[ $X != . ]] && staged=1
                         [[ $Y != . ]] && dirty=1 ;;
    esac
  done

  [[ $branch == '(detached)' ]] && branch="@${oid[1,7]}" || branch=${branch[1,25]}
  local s=
  (( staged ))    && s+="%F{$C[green]}+%f"
  (( untracked )) && s+="%F{$C[red]}?%f" || { (( dirty )) && s+="%F{$C[yellow]}!%f" }
  (( behind ))    && s+="%F{$C[orange]}⇣%f"
  (( ahead ))     && s+="%F{$C[aqua]}⇡%f"
  (( stash ))     && s+="%F{$C[gray]}≡%f"
  print -r -- "%B%F{$C[purple]}${branch//\%/%%}%f%b${s:+ $s} "
}

# PROMPT only *references* these variables (single quotes), so prompt_subst never
# re-expands their contents: a branch or directory named '$(cmd)' stays inert.
_prompt_render() {
  local arrow=$C[bright]; (( _prompt_ret )) && arrow=$C[red]
  PROMPT=$'\n${_prompt_dir} ${_prompt_git_seg}${_prompt_local}${_prompt_time}\n'"%B%F{$arrow}❯%f%b "
  PROMPT2="%F{$arrow}❯❯%f "
}

# Start the git status in the background; _prompt_git_done runs when it has output.
_prompt_git_start() {
  if [[ -n $_prompt_fd ]]; then     # drop a stale job from the previous prompt
    zle -F $_prompt_fd
    exec {_prompt_fd}<&-
    _prompt_fd=
  fi
  exec {_prompt_fd}< <(_prompt_git)
  zle -F $_prompt_fd _prompt_git_done
}

_prompt_git_done() {
  local fd=$1
  read -r -u $fd _prompt_git_seg
  zle -F $fd
  exec {fd}<&-
  _prompt_fd=
  _prompt_render
  zle reset-prompt
}

_prompt_precmd() {
  _prompt_ret=$?   # must be first: this hook is moved to the front below

  _prompt_time=
  if [[ -n $_prompt_start ]]; then
    local -i ms=$(( (EPOCHREALTIME - _prompt_start) * 1000 ))
    (( ms >= 1000 )) && _prompt_time="%F{$C[gray]}$(( ms / 1000 )).$(( ms % 1000 / 100 ))s%f"
    _prompt_start=
  fi
  _prompt_local=
  [[ -x ~/.zsh/local-prompt.sh ]] && _prompt_local="%F{$C[blue]}$(~/.zsh/local-prompt.sh 2>/dev/null)%f "
  _prompt_git_seg=
  _ctx_seg= _ctx_word=

  # Dim parent directories, bright bold current directory
  local p=${(%):-%~}; p=${p//\%/%%}
  if [[ $p == */* ]]; then
    _prompt_dir="%F{$C[gray]}${p%/*}/%f%B%F{$C[bright]}${p##*/}%f%b"
  else
    _prompt_dir="%B%F{$C[bright]}${p}%f%b"
  fi

  _prompt_render
  _prompt_git_start
}

# Transient prompt: collapse the finished prompt to "HH:MM:SS❯"
_prompt_transient() {
  local c=$C[fg]; (( _prompt_ret )) && c=$C[red]
  PROMPT=$'\n'"%F{$c}%D{%H:%M:%S}❯%f "
  zle reset-prompt
}

# Right-side context, only for relevant commands. Cached per first word so typing is fork-free.
typeset -g _ctx_word _ctx_seg
RPROMPT='${_ctx_seg}'
_prompt_context() {
  local w=${BUFFER%% *}
  [[ $w == $_ctx_word ]] && return
  _ctx_word=$w
  local ctx=
  case $w in
    k|kubectl) ctx=$(kubectl config current-context 2>/dev/null) ;;
    aws|terraform) ctx=$AWS_PROFILE ;;
  esac
  _ctx_seg=${ctx:+"%F{$C[aqua]}${ctx//\%/%%}%f"}
  zle reset-prompt
}

add-zsh-hook preexec _prompt_preexec
add-zsh-hook precmd  _prompt_precmd
precmd_functions=(_prompt_precmd ${precmd_functions:#_prompt_precmd})
add-zle-hook-widget zle-line-finish _prompt_transient
add-zle-hook-widget zle-line-pre-redraw _prompt_context
