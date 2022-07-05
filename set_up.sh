#!/bin/bash
set -e

cd ~
rm -rf .vim
ln -s dotfiles/vim .vim
ln -s dotfiles/vimrc .vimrc
ln -s dotfiles/tmux.conf .tmux.conf
ln -s dotfiles/gdbinit .gdbinit
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

sed  -i 's/<C-o> :NERDTreeToggle<CR>/<C-p> :NERDTreeToggle<CR>/g' dotfiles/vimrc
