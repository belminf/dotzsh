export SSH_AUTH_SOCK="${HOME}/.ssh/.ssh_agent"

# ssh-add exits 2 when it cannot reach an agent
ssh-add -l &>/dev/null
if (( $? == 2 )); then
  rm -f "$SSH_AUTH_SOCK"
  eval "$(ssh-agent -a "$SSH_AUTH_SOCK")" >/dev/null
fi
