function __get_current_time() {
  perl -MTime::HiRes=time -e'print time'
}

function __timer_preexec() {
  local current_time="$(__get_current_time)"
  timer="${timer:-$current_time}"
  export TIMER_LAST_DURATION=""
}
preexec_functions+=(__timer_preexec)

function __timer_precmd() {
  [ $timer ] || return

  local current_time="$(__get_current_time)"
  local timer_diff="$((current_time - timer))"
  [ -n "$TTY" ] && export TIMER_LAST_DURATION="$timer_diff"
  unset timer
}
precmd_functions+=(__timer_precmd)

function timer_last_duration_print() {
  [ -n "$TIMER_LAST_DURATION" ] || return

  local mins=$(printf '%.0f' $((TIMER_LAST_DURATION / 60)))
  local secs=$(printf "%.1f" $((TIMER_LAST_DURATION - 60 * mins)))
  [ "$mins" -gt 0 ] && echo "${mins}m${secs}s" || echo "${secs}s"
  unset TIMER_LAST_DURATION
}
