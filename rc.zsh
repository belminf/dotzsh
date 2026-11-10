SRC="$HOME/.zsh/src"

for f in history options completions clipboard functions aliases ssh_agent ruby k8s git-auto-fetch theme plugins; do
  source "$SRC/$f.zsh"
done

for f in "$SRC"/local*.zsh(N); do source "$f"; done
