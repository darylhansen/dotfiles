My vim configuration. To use this configuration:

1a. Get the files:

```bash
DOTFILE_PATH="~/dotfiles" # or whereever you want the repo to be
git clone --recursive https://github.com/darylhansen/dotfiles $DOTFILE_PATH
ln -s $DOTFILE_PATH/_vimrc ~/.vimrc
ln -s $DOTFILE_PATH/_vim ~/.vim
```

1b. Alternatively, I think that this would also work:
```bash
git clone https://github.com/darylhansen/dotfiles/_vimrc.git ~/.vimrc
```


2. Install and setup Vundle (http://github.com/gmarik/vundle):
```bash
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
```
