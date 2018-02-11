## Install

I'm a [neovim][neovim] user, but this configuration should also work with
vanilla vim8.

Clone the repository and update submodules.

```bash
git clone git@github.com:kopiczko/vim-config.git ~/.vim
cd ~/.vim && git submodule update --init --recursive
```

Wire vim and [neovim][neovim] config path.

```bash
config_dir=$XDG_CONFIG_HOME
if [[ -z $config_dir ]]; then
    config_dir=$HOME/.config
fi

ln -s ~/.vim $config_dir/nvim
```

## Plugins

This configuration uses [pathogen][pathogen] for plugins. All plugins are git
submodules.

### Adding a Submodule

```bash
cd ~/.vim && git sumodule add REPO bundle/SUBMODULE
```

- After adding a plugin/submodule run `:Helptags` command inside your vim.
- If you are a [neovim][neovim] user and you install python plugin don't forget
  to run `:UpdateRemotePlugins`.

### Removing a Submodule

```bash
cd ~/.vim && git rm bundle/SUBMODULE
```

[neovim]: https://neovim.io
[pathogen]: https://github.com/tpope/vim-pathogen
