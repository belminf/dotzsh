export SSH_AUTH_SOCK="${HOME}/.ssh/.ssh_agent"

if [ ! -S "$SSH_AUTH_SOCK" ] || ! pgrep -f "ssh-agent -a $SSH_AUTH_SOCK" >/dev/null; then
  rm -f "$SSH_AUTH_SOCK"
  eval "$(ssh-agent -a "$SSH_AUTH_SOCK")"
fi
