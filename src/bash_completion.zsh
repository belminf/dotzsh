autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit

BASH_COMPLETIONS=()
if [ -f "${HOME}/.zsh/src/local-completions.zsh" ]; then
  source "${HOME}/.zsh/src/local-completions.zsh"
fi

for compfile in $BASH_COMPLETIONS; do
  source "$compfile"
done
