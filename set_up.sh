#!/bin/bash
set -e

sudo apt remove -y neovim
sudo add-apt-repository -y ppa:neovim-ppa/unstable

#Utilities
sudo apt update &&
  sudo  apt install -y \
  vim neovim xsel unzip ripgrep \
  locate gdb tree tmux \
  cmake-curses-gui wget

cd /home/$USERNAME

# VIM
rm -rf .vim
ln -sf dotfiles/vim .vim
ln -sf dotfiles/vimrc .vimrc
#requires installing exuberant-ctags package
ln -sf dotfiles/ctags .ctags 
rm -rf .vim/bundle/Vundle.vim
git clone https://github.com/VundleVim/Vundle.vim.git .vim/bundle/Vundle.vim
vim +PluginInstall +qall


#GDB
ln -sf dotfiles/gdbinit .gdbinit
ln -sf dotfiles/stl-views.gdb .stl-views.gdb

# NEOVIM
mkdir -p .config/
rm -rf .config/nvim
ln -sf ~/dotfiles/nvim .config/nvim

## TMUX
ln -sf dotfiles/tmux.conf .tmux.conf
rm -rf .tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm .tmux/plugins/tpm

echo 'export VISUAL=nvim' >> .bashrc
echo 'export EDITOR="$VISUAL"' >> .bashrc
source .bashrc
