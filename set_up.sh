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

echo 'export VISUAL=nvim' >> ~/.bashrc
echo 'export EDITOR="$VISUAL"' >> ~/.bashrc
echo 'export TERM=xterm-256color' >> ~/.bashrc

# wget  https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb
# sudo apt install ./nvim-linux64.deb
# mkdir -p .conf/nvim
# ln -s dotfiles/init.lua .conf/nvim/init.lua
## add to the GNOME terminal profile a custom command: env TERM=xterm-256color /bin/bash
