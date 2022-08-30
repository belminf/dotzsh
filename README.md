# zsh config

## Install

### OS

#### Arch

```
yay -S --needed pkgfile zsh git fzf direnv python-pipenv kubectx ripgrep bat gron-bin git tree tldr
sudo systemctl enable pkgfile-update.timer
```

#### macOS

```
brew install coreutils gnu-sed gnu-which zsh git fzf direnv pipenv kubectx ripgrep bat gron git tree tldr
/opt/homebrew/opt/fzf/install --key-bindings --completion --no-update-rc
```

### Setup

```
git clone git@github.com:belminf/dotzsh.git ~/.zsh
git submodule update --init --recursive
ln -sf ~/.zsh/rc.zsh ~/.zshrc
ln -sf ~/.zsh/inputrc ~/.inputrc
```
