# zsh config

## Setup

### Requirements
#### Arch

```bash
yay -S --needed pkgfile zsh git fzf direnv python-pipenv kubectx ripgrep bat gron-bin git tree tldr fd eza oh-my-posh
sudo systemctl enable pkgfile-update.timer
```

#### macOS

```bash
brew install coreutils gnu-sed gnu-which zsh git fzf direnv pipenv kubectx ripgrep bat gron git tree tldr fd eza oh-my-posh
/opt/homebrew/opt/fzf/install --key-bindings --completion --no-update-rc
```

### Install

```bash
git clone git@github.com:belminf/dotzsh.git ~/.zsh
make init
```

## Update

```bash
make update
```

## Keys

- <kbd>Ctrl</kbd> <kbd>T</kbd>: Find a file
- <kbd>Ctrl</kbd> <kbd>R</kbd>: Search history
- <kbd>Ctrl</kbd> <kbd>Q</kbd>: Push line till next prompt (e.g., forgot to run a different command first)
- <kbd>Ctrl</kbd> <kbd>B</kbd>: Copy what is on the command line buffer
