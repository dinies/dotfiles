#!/bin/bash
set -e

cd ~
rm -rf .vim
ln -s dotfiles/vim .vim
ln -s dotfiles/vimrc .vimrc
ln -s dotfiles/tmux.conf .tmux.conf
ln -s dotfiles/gdbinit .gdbinit
ln -s dotfiles/stl-views.gdb .stl-views.gdb
#requires installing exuberant-ctags package
ln -s dotfiles/ctags .ctags 

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

echo 'export VISUAL=vim' >> ~/.bashrc
echo 'export EDITOR="$VISUAL"' >> ~/.bashrc
