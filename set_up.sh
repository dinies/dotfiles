#!/bin/bash
set -e

#Utilities
sudo apt install -y vim xsel unzip ripgresp locate gdb tree tmux cmake-curses-gui

cd ~
rm -rf .vim
ln -s dotfiles/vim .vim
ln -s dotfiles/vimrc .vimrc

#GDB
ln -s dotfiles/tmux.conf .tmux.conf
ln -s dotfiles/gdbinit .gdbinit
ln -s dotfiles/stl-views.gdb .stl-views.gdb
# VIM
requires installing exuberant-ctags package
ln -s dotfiles/ctags .ctags 
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

# NEOVIM
echo 'export VISUAL=nvim' >> ~/.bashrc
echo 'export EDITOR="$VISUAL"' >> ~/.bashrc
echo 'export TERM=xterm-256color' >> ~/.bashrc
source ~/.bashrc

wget  https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb
sudo apt install ./nvim-linux64.deb
rm ./nvim-linux64.deb

mkdir -p ~/.config/
ln -s ~/dotfiles/nvim .config/nvim

## TMUX
ln -s ~/dotfiles/tmux.conf .tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

