autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit

BASH_COMPLETIONS=()
source "${HOME}/.zsh/src/local-completions.zsh"

for compfile in $BASH_COMPLETIONS; do
    source "$compfile"
done
