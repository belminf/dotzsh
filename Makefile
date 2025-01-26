update:
	git submodule update --recursive --remote --merge
ifeq ($(shell uname -s),Linux)
	sudo oh-my-posh upgrade
else
	oh-my-posh upgrade
endif

init:
	git submodule update --init --recursive
	ln -sf ~/.zsh/rc.zsh ~/.zshrc
	ln -sf ~/.zsh/inputrc ~/.inputrc

.PHONY: update init
