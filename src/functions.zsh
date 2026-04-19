# Shortcut functions
function mkcd() {
  mkdir -p "$@" && cd "$@" || return
}

function mkproj() {
  mkcd "${HOME}/projects/$1"
}

function cdtmp() {
  cd "$(mktemp -d)" || return
}

# vim functions
function vf() {
  nvim "$(rg --files -u | fzf -1 -q "$@")"
}

function vg() {
  nvim $(rg -l "$@" | tr '\n' ' ')
}

function vc() {
  nvim "$(git conflicted | tr '\n' ' ')"
}

function vm() {
  nvim $(git diff --name-only HEAD | tr '\n' ' ')
}

# dotfile management
function dotfile() {
  case "$1" in
  pull)
    for dotfile in ~/.zsh ~/.tmux ~/.vim; do
      echo "$dotfile:"
      git -C $dotfile pull
      echo
    done
    ;;
  st | status)
    for dotfile in ~/.zsh ~/.tmux ~/.vim; do
      echo "$dotfile:"
      git -C $dotfile st
      echo
    done
    ;;
  *)
    echo "No such command"
    ;;
  esac
}

# clipboard
function copyfile {
  emulate -L zsh
  clipcopy "$1"
}

function copypath {
  # If no argument passed, use current directory
  local file="${1:-.}"

  # If argument is not an absolute path, prepend $PWD
  [[ $file = /* ]] || file="$PWD/$file"

  # Copy the absolute path without resolving symlinks
  # If clipcopy fails, exit the function with an error
  print -n "${file:a}" | clipcopy || return 1

  echo "${(%):-"%B${file:a}%b copied to clipboard."}"
}

function tmux_ssh {
    if [[ "$1" = "-h" ]]; then
        echo "Usage: tmux_ssh [window_name] [hosts...]"
        echo "echo 'host1 host2' | tmux_ssh [window_name]"
        return 0
    fi

    if ! tmux info &>/dev/null; then
        echo "Error: tmux session not found"
        return 1
    fi

    if (( $# <= 1 )); then
        [[ -n "$1" ]] && window_name="$1" || window_name=""
        tmux_cmd="new-window"
        while read -r line; do
            for host in ${=line}; do
                [[ -n "$host" ]] || continue
                # Changed to keep shell open after SSH exits
                tmux ${=tmux_cmd} zsh -ic "ssh $host || bash"
                tmux select-layout tiled
                tmux set-window-option synchronize-panes
                tmux_cmd="split-window -h"
            done
        done
    else
        window_name="$1"
        shift
        tmux_cmd="new-window"
        for host in "$@"; do
            [[ -n "$host" ]] || continue
            # Changed to keep shell open after SSH exits
            tmux ${=tmux_cmd} zsh -ic "ssh $host || bash"
            tmux select-layout tiled
            tmux set-window-option synchronize-panes
            tmux_cmd="split-window -h"
        done
    fi

    [[ -z "$window_name" ]] && tmux command-prompt -p "window name:" "rename-window '%%'" || tmux rename-window "$window_name"
}

function ssh_asg() {
    if [[ "$1" = "-h" || -z "$1" ]]; then
        echo "Usage: ssh_asg <ASG_NAME> [SSH_USER]"
        echo "Example: ssh_asg my-asg-name"
        echo "Example: ssh_asg my-asg-name ec2-user"
        return 1
    fi

    local asg_name="$1"

    # Check if ASG exists
    if ! aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names "$asg_name" >/dev/null 2>&1; then
        echo "Error: ASG '$asg_name' not found"
        return 1
    fi

    # Get IPs and pipe to tmux_ssh
    aws ec2 describe-instances \
        --filters "Name=tag:aws:autoscaling:groupName,Values=$asg_name" \
        --query 'Reservations[*].Instances[*].PrivateIpAddress' \
        --output text | tr '\t' '\n' | tmux_ssh "$asg_name"
}

curl_cert() {
    if [ -z "$1" ]; then
        echo "Usage: curl_cert <hostname[:port]>"
        echo "Example: curl_cert example.com"
        echo "Example: curl_cert example.com:8443"
        return 1
    fi

    local host="${1%:*}"
    local port="${1##*:}"

    # Default to 443 if no port specified
    if [ "$host" = "$port" ]; then
        port=443
    fi

    echo "Checking certificate for $host:$port..."
    echo ""

    echo | openssl s_client -servername "$host" -connect "$host:$port" 2>/dev/null | \
    openssl x509 -noout -subject -issuer -dates -ext subjectAltName 2>/dev/null | \
    sed 's/subject=/Subject: /' | \
    sed 's/issuer=/Issuer: /' | \
    sed 's/notBefore=/Valid From: /' | \
    sed 's/notAfter=/Expires: /'
}
