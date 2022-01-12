T_BOLD=$(shell tput bold)
T_NORMAL=$(shell tput sgr0)

NVIM_CONFIG_DIR=$(HOME)/.config/nvim
CURRENT_DIR=$(abspath $(shell pwd))

install: install-symlinks install-python install-ruby install-coc install-invim
	@echo "$(T_BOLD)---> Downloading vim-plug$(T_NORMAL)"
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
	    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

	@echo "$(T_BOLD)**** RUN THIS WHEN YOU FIRST TIME OPEN NVIM ****$(T_NORMAL)"
	@echo "        :Mkspell - To generate spell files."
	@echo "        :UpdateRemotePlugins - To update python remote plugins."
	@echo "        :checkhealth - To check health."
	@echo "        :PlugUpgrade - to upgrade vim-plug.."
	@echo "        :PlugUpdate - to install/update dependencies."
	@echo "        :PlugStatus - to see if the dependencies are installed correctly."

install-symlinks:
	@echo "$(T_BOLD)---> Setting up symlink$(T_NORMAL)"
	mkdir -p $(shell dirname $(NVIM_CONFIG_DIR))
	[[ -h $(NVIM_CONFIG_DIR) ]] && [[ "$(shell readlink $(NVIM_CONFIG_DIR))" == "$(CURRENT_DIR)" ]] || ln -s $(CURRENT_DIR) $(NVIM_CONFIG_DIR)

install-python:
	@echo "$(T_BOLD)---> Installing python libraries$(T_NORMAL)"
	#pip2 install --upgrade pip
	pip3 install --upgrade pip

	#pip2 install --upgrade --user pynvim
	pip3 install --upgrade --user pynvim

install-ruby:
	@echo "$(T_BOLD)---> Installing ruby libraries$(T_NORMAL)"
	gem install --user-install neovim
	gem update --user-install neovim

install-coc:
	@echo "$(T_BOLD)---> Installing coc.nvim$(T_NORMAL)"
	@echo "--> Check if node and Go are isntalled"
	node --version
	go version
	@echo "--> Install latest gopls"
	go get golang.org/x/tools/gopls

install-invim:
	nvim -c 'UpdateRemotePlugins'
	nvim -c 'CocInstall -sync coc-go coc-snippets'
