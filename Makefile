T_BOLD=$(shell tput bold)
T_NORMAL=$(shell tput sgr0)

install:
	@echo "$(T_BOLD)---> Downloading vim-plug$(T_NORMAL)"
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
	    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
