# Install

## Install [YouCompleteMe](https://github.com/Valloric/YouCompleteMe)

See [installation instructions](https://github.com/Valloric/YouCompleteMe#installation)
for your OS.

On my mac I do it like this (if you want to use `--gocod-completer` flag you
have to have [go](http://golang.org/doc/install) installed):

```
brew install clang # use your OS package manager
cd ~/.vim/bundle/YouCompleteMe && ./install.sh --clang-completer --gocode-completer
```

## Clone the repository and update submodules

```
git clone git@github.com:kopiczko/vim-config.git ~/.vim
cd ~/.vim && git submodule update --init --recursive
```
