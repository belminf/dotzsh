# clipcopy / clippaste for the platforms in use
if (( $+commands[pbcopy] )); then
  clipcopy()  { pbcopy < "${1:-/dev/stdin}" }
  clippaste() { pbpaste }
elif [[ -n $WAYLAND_DISPLAY ]] && (( $+commands[wl-copy] )); then
  clipcopy()  { wl-copy < "${1:-/dev/stdin}" }
  clippaste() { wl-paste --no-newline }
elif [[ -n $DISPLAY ]] && (( $+commands[xclip] )); then
  clipcopy()  { xclip -selection clipboard -in < "${1:-/dev/stdin}" &>/dev/null }
  clippaste() { xclip -selection clipboard -out }
elif [[ -n $TMUX ]]; then
  clipcopy()  { tmux load-buffer "${1:--}" }
  clippaste() { tmux save-buffer - }
fi
