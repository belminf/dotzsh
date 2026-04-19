deps:
ifeq ($(shell uname -s),Linux)
	yay -S --needed pkgfile zsh git fzf direnv kubectx ripgrep bat gron-bin tree tldr fd eza oh-my-posh-bin python-pipenv
	sudo systemctl enable pkgfile-update.timer
else
	brew install oh-my-posh fzf direnv kubectx ripgrep bat gron tree tldr fd eza coreutils gnu-sed gnu-which pipenv
	/opt/homebrew/opt/fzf/install --key-bindings --completion --no-update-rc
endif

init: deps
	git submodule update --init
	ln -sf ~/.zsh/rc.zsh ~/.zshrc

update:
	git pull
	git submodule update --recursive --remote --merge
ifeq ($(shell uname -s),Linux)
	sudo oh-my-posh upgrade
else
	oh-my-posh upgrade
endif


.PHONY: deps init update
