# Background `git fetch --all` before the prompt, at most once per interval.
# Toggle per repo with `git-auto-fetch`.
zmodload zsh/datetime
zmodload -F zsh/stat b:zstat
: ${GIT_AUTO_FETCH_INTERVAL:=60}

_git_auto_fetch() {
  local dir; dir=$(command git rev-parse --git-dir 2>/dev/null) || return
  [[ -w $dir && ! -f $dir/NO_AUTO_FETCH ]] || return
  (( EPOCHSECONDS - $(zstat +mtime $dir/FETCH_LOG 2>/dev/null || echo 0) < GIT_AUTO_FETCH_INTERVAL )) && return
  GIT_SSH_COMMAND="command ssh -o BatchMode=yes" GIT_TERMINAL_PROMPT=0 \
    command git fetch --all --recurse-submodules=yes &>| $dir/FETCH_LOG &!
}

git-auto-fetch() {
  local guard; guard=$(command git rev-parse --git-dir 2>/dev/null)/NO_AUTO_FETCH || return
  if [[ -f $guard ]]; then rm $guard && echo "enabled"; else touch $guard && echo "disabled"; fi
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd _git_auto_fetch
