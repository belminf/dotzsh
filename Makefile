deps:
ifeq ($(shell uname -s),Linux)
	yay -S --needed pkgfile zsh git fzf direnv kubectx ripgrep bat gron-bin tree tldr fd eza python-pipenv
	sudo systemctl enable pkgfile-update.timer
else
	brew install fzf direnv kubectx ripgrep bat gron tree tldr fd eza coreutils gnu-sed gnu-which pipenv
	/opt/homebrew/opt/fzf/install --key-bindings --completion --no-update-rc
endif

init: deps
	git submodule update --init
	ln -sf ~/.zsh/rc.zsh ~/.zshrc

update:
	git pull
	git submodule update --recursive --remote --merge


.PHONY: deps init update
