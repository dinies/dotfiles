#!/bin/bash

set -euxo pipefail

echo 'Setup script started'
if ! grep -qi ubuntu /etc/os-release; then
  echo "This script is intended for Ubuntu containers."
fi

LOCALE="C.UTF-8"

# Persist locale system-wide
sudo tee /etc/default/locale >/dev/null <<EOF
LANG=${LOCALE}
LC_ALL=${LOCALE}
EOF

export LANG="${LOCALE}"
export LC_ALL="${LOCALE}"

sudo apt update &&
  sudo apt install -y \
  software-properties-common \
  vim xsel unzip ripgrep \
  locate gdb tree tmux \
  cmake-curses-gui wget

sudo apt remove -y neovim
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt update && sudo  apt install -y nvim


# VIM
rm -rf "$HOME/.vim"
ln -sf "$HOME/dotfiles/vim" "$HOME/.vim"
ln -sf "$HOME/dotfiles/vimrc" "$HOME/.vimrc"
#requires installing exuberant-ctags package
ln -sf "$HOME/dotfiles/ctags" "$HOME/.ctags"
rm -rf "$HOME/.vim/bundle/Vundle.vim"
git clone https://github.com/VundleVim/Vundle.vim.git "$HOME/.vim/bundle/Vundle.vim"
vim +PluginInstall +qall

#GDB
ln -sf "$HOME/dotfiles/gdbinit" "$HOME/.gdbinit"
ln -sf "$HOME/dotfiles/stl-views.gdb" "$HOME/.stl-views.gdb"

# NEOVIM
mkdir -p "$HOME/.config/"
rm -rf "$HOME/.config/nvim"
rm -rf "$HOME/.local/share/nvim"
ln -sf "$HOME/dotfiles/nvim" "$HOME/.config/nvim"

## TMUX
ln -sf "$HOME/dotfiles/tmux.conf" "$HOME/.tmux.conf"
rm -rf "$HOME/.tmux/plugins/tpm"
git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"

echo 'export VISUAL=nvim' >> "$HOME/.bashrc"
echo 'export EDITOR="$VISUAL"' >> "$HOME/.bashrc"

echo 'Setup script finished succesfully'
source "$HOME/.bashrc"
