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
grep -q "$(brew --prefix)/bin/zsh" /etc/shells || echo "$(brew --prefix)/bin/zsh" | sudo tee -a /etc/shells >/dev/null
sudo chsh -s "$(brew --prefix)/bin/zsh" "$USER"
```

### Setup

```
git clone git@github.com:belminf/dotzsh.git ~/.zsh
ln -sf ~/.zsh/rc.zsh ~/.zshrc
ln -sf ~/.zsh/inputrc ~/.inputrc
```
