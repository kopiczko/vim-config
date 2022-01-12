T_BOLD=$(shell tput bold)
T_NORMAL=$(shell tput sgr0)

NVIM_CONFIG_DIR=$(HOME)/.config/nvim
CURRENT_DIR=$(abspath $(shell pwd))

.PHONY: help
help: ## Display this help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

install: install-symlinks install-python install-ruby install-coc install-invim ## Install all.
	@echo "$(T_BOLD)---> Downloading vim-plug$(T_NORMAL)"
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
	    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

	@echo "$(T_BOLD)**** RUN THIS WHEN YOU FIRST TIME OPEN NVIM ****$(T_NORMAL)"
	@echo "        :Mkspell - To generate spell files."
	@echo "        :UpdateRemotePlugins - To update python remote plugins."
	@echo "        :CocInstall -sync coc-go"
	@echo "        :checkhealth - To check health."
	@echo "        :PlugUpgrade - to upgrade vim-plug.."
	@echo "        :PlugUpdate - to install/update dependencies."
	@echo "        :PlugStatus - to see if the dependencies are installed correctly."

install-symlinks: ## Install symlinks.
	@echo "$(T_BOLD)---> Setting up symlink$(T_NORMAL)"
	mkdir -p $(shell dirname $(NVIM_CONFIG_DIR))
	[[ -h $(NVIM_CONFIG_DIR) ]] && [[ "$(shell readlink $(NVIM_CONFIG_DIR))" == "$(CURRENT_DIR)" ]] || ln -s $(CURRENT_DIR) $(NVIM_CONFIG_DIR)

install-python: ## Install pynvim.
	@echo "$(T_BOLD)---> Installing python libraries$(T_NORMAL)"
	#pip2 install --upgrade pip
	pip3 install --upgrade pip

	#pip2 install --upgrade --user pynvim
	pip3 install --upgrade --user pynvim

install-ruby: ## Install neovim.
	@echo "$(T_BOLD)---> Installing ruby libraries$(T_NORMAL)"
	gem install --user-install neovim
	gem update --user-install neovim

install-coc: ## Install CoC.
	@echo "$(T_BOLD)---> Installing coc.nvim$(T_NORMAL)"
	@echo "--> Check if node and Go are isntalled"
	node --version
	go version
	@echo "--> Install coc extensions"
	go get golang.org/x/tools/gopls

install-invim: ## Install stuff that should be run inside nvim.
	nvim -c 'UpdateRemotePlugins'
	nvim -c 'CocInstall -sync coc-go coc-snippets'
