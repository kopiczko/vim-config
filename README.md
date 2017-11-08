## Install

Clone the repository and update submodules.

```bash
git clone git@github.com:kopiczko/vim-config.git ~/.vim
cd ~/.vim && git submodule update --init --recursive
```


## Dealing with sumodules

To add a submodule:

```bash
cd ~/.vim && git sumodule add REPO bundle/SUBMODULE
```

To remove a submodule:

```bash
path=bundle/SUBMODULE

cd ./vim
git submodule deinit -f -- ${path}
rm -rf .git/modules/${path}
git rm -rf ${path}
```
