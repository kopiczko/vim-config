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

### Install python (neovim)

This is optnional, required by neovim users. I use [pyenv][pyenv] to manage my
python installations. This is to prevent creating mess in my system python.

```bash

if [[ $OSTYPE == darwin* ]]; then
    # Do this even if it was done before.
    xcode-select --install
fi

export PYTHON_CONFIGURE_OPTS="--enable-framework"
pyenv install 2.7.14
pyenv install 3.6.3

pyenv rehash

pyenv shell 2.7.14 && pip install neovim
pyenv shell 3.6.3 && pip install neovim
```

If you use different version remember to update lines below inside vimconfig.

```
let g:python_host_prog = $HOME.'/.pyenv/versions/2.7.14/bin/python'
let g:python3_host_prog = $HOME.'/.pyenv/versions/3.6.3/bin/python'
```

Bonus: if you want to use pyenv installed python globally run `pyenv global
3.6.3`.

### Install ruby (neovim)

This is optnional, required by neovim users. I use [rbenv][rbenv] to manage my
ruby installations. This is to prevent creating mess in my system ruby.

```bash
rbenv install 2.4.2

rbenv rehash

rbenv shell 2.4.2 && gem install neovim
```

If you use different version remember to update lines below inside vimconfig.

```
let g:ruby_host_prog = $HOME.'/.rbenv/versions/2.4.2/bin/ruby'
```

Bonus: if you want to use rbenv installed ruby globally run `rbenv global
2.4.2`.

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
[pyenv]: https://github.com/pyenv/pyenv
