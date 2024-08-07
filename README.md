# zsh config

## Install

### OS

#### Arch

```bash
yay -S --needed pkgfile zsh git fzf direnv python-pipenv kubectx ripgrep bat gron-bin git tree tldr starship fd zoxide eza vivid
sudo systemctl enable pkgfile-update.timer
```

#### macOS

```bash
brew install coreutils gnu-sed gnu-which zsh git fzf direnv pipenv kubectx ripgrep bat gron git tree tldr starship fd zoxide eza vivid
/opt/homebrew/opt/fzf/install --key-bindings --completion --no-update-rc
```

### Setup

```bash
git clone git@github.com:belminf/dotzsh.git ~/.zsh
git submodule update --init --recursive
ln -sf ~/.zsh/rc.zsh ~/.zshrc
ln -sf ~/.zsh/inputrc ~/.inputrc
```

## Keys

- <kbd>Ctrl</kbd> <kbd>T</kbd>: Find a file
- <kbd>Ctrl</kbd> <kbd>R</kbd>: Search history
- <kbd>Alt</kbd> <kbd>C</kbd>: Fuzzy search for `cd`
