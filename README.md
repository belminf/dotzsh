# zsh config

## Install

### OS

#### Arch

```
yay -S --needed pkgfile zsh git fzf direnv python-pipenv kubectx ripgrep zsh-completions bat gron-bin git tree tldr
sudo systemctl enable pkgfile-update.timer
```

#### macOS

```
brew install coreutils gnu-sed gnu-which zsh git fzf direnv pipenv kubectx ripgrep zsh-completion bat gron git tree tldr
```

### Setup

```
git clone git@github.com:belminf/dotzsh.git ~/.zsh
ln -sf ~/.zsh/rc.zsh ~/.zshrc
ln -sf ~/.zsh/inputrc ~/.inputrc
```
