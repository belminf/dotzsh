# Load kubectl completion on first use (generating it costs ~100ms)
if (( $+commands[kubectl] )); then
  _kubectl_lazy() {
    unfunction _kubectl_lazy
    source <(kubectl completion zsh)
    _kubectl "$@"
  }
  compdef _kubectl_lazy kubectl
fi

GNU_AWK=${commands[gawk]:+gawk}
: ${GNU_AWK:=awk}

alias k='kubectl'
alias kg='kubectl get'
alias kga='kubectl get --all-namespaces'
alias kc='kubectx'
alias kn='kubens'

### Grep shortcuts
function __kgrep() {
  if [ "$#" -eq 1 ]; then
    echo >&2 "+${1}"
    eval "$1"
  elif [ "$#" -eq 2 ]; then
    echo >&2 "+${1}"
    eval "$1" | rg "$2"
  else
    return 1
  fi
}

function kpods() {
  __kgrep "kubectl get pods" "$1"
}

function kall() {
  __kgrep 'kubectl get all,secret,pvc,role,rolebinding,pv,clusterrole,clusterrolebinding --all-namespaces -o custom-columns=":.metadata.namespace,:.kind,:.metadata.name" | column -t' "$@"
}

function kimg() {
  __kgrep 'kubectl get pods --all-namespaces -o custom-columns="NAME:.metadata.name,STATUS:.status.phase,NODE:.status.hostIP,IMAGE:.spec.containers[*].image" | column -t' "$@"
}

### RBAC bindings
alias krbac="kubectl get rolebindings,clusterrolebindings --all-namespaces -o custom-columns='KIND:kind,NAMESPACE:metadata.namespace,NAME:metadata.name,GROUPS:subjects[?(@.kind==\"Group\")].name,SERVICE_ACCOUNTS:subjects[?(@.kind==\"ServiceAccount\")].name'"

### Bad pods and deployments
function kbad() {
  kubectl get pods --all-namespaces -o wide | $GNU_AWK '{ if ($1 == "NAMESPACE") { $1="PODS"; } else { $1=$1"/"$2 } }; { split($3, READY, "/"); if (($4 == "Running" && READY[1] != READY[2]) || $4 !~ /Running|Completed/) { print $1,$3,$4,$5,$6,$8}}' | column -t
  echo
  kubectl get deployments --all-namespaces | $GNU_AWK '{  if ($1 == "NAMESPACE") { $1="DEPLOYMENTS"; TARGET="TARGET"; UPDATED="UPDATED"; AVAIL="AVAIL" } else { $1=$1"/"$2; TARGET=$3; split($3,TARGET_A,"/"); UPDATED=$4; AVAIL=$5; }} $1=="DEPLOYMENTS" || !(($TARGET_A[1] == $TARGET_A[2]) && ($UPDATED == $TARGET_A[2]) && ($AVAIL == $TARGET_A[2])) { print $1,TARGET,UPDATED,AVAIL }' | column -t
}

### Decode secret
function ksecret() {
  local line ns secret key
  line=$(kubectl get secret --all-namespaces -o go-template='{{ range $i := .items }}{{ range $f,$v := .data }}{{ printf "%s %s %s\n" $i.metadata.namespace $i.metadata.name $f }}{{end}}{{end}}' | column -t | fzf ${1:+-q "$1"}) || return
  read -r ns secret key <<<"$line"

  echo "[${ns}/${secret}: ${key}]"
  echo ""
  kubectl get secret -n "$ns" "$secret" -o jsonpath --template="{.data.${key//./\\.}}" | base64 --decode
}
