export SSH_AUTH_SOCK="${HOME}/.ssh/.ssh_agent"

if ! pgrep -f "ssh-agent -a $SSH_AUTH_SOCK" >/dev/null || [ ! -S "$SSH_AUTH_SOCK" ]; then
  rm -f "$SSH_AUTH_SOCK"
  eval "$(ssh-agent -a "$SSH_AUTH_SOCK")"
fi
