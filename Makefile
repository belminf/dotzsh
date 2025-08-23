init:
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


.PHONY: init update
