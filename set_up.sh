#!/bin/bash
set -e

#Utilities
sudo apt install -y vim xsel unzip ripgrep locate gdb tree tmux cmake-curses-gui

cd ~

# VIM
rm -rf .vim
ln -s dotfiles/vim .vim
ln -s dotfiles/vimrc .vimrc
#requires installing exuberant-ctags package
ln -s dotfiles/ctags .ctags 
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall


#GDB
ln -s dotfiles/gdbinit .gdbinit
ln -s dotfiles/stl-views.gdb .stl-views.gdb

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
ln -s dotfiles/tmux.conf .tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

