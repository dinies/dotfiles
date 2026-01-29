#Dotfiles
========
This repository includes all of my custom dotfiles.  They should be cloned to
your home directory so that the path is `~/dotfiles/`.
The included setup script creates symlinks from your home
directory to the files which are located in `~/dotfiles/`
then sets-up vim, tmux, neovim, and finally
adds some utilities to the shell startup file.

To launch the script run:
``` bash
./set_up.sh
```

##Kitti terminal
In order to have flawless integration between editor and shell
and to have the option to change colorsheme instantaneously
we are using Kitty terminal instad the default GNOME terminal.
Follow this [start-up guide](here: https://sw.kovidgoyal.net/kitty/binary/)
We are using this [Kitty colorschemes](https://github.com/dexpota/kitty-themes)

Also install a nerd font:
```
mkdir -p ~/.local/share/fonts
mkdir tmp && cd tmp
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
tar -xf JetBrainsMono.tar.xz -C ~/.local/share/fonts
rm -rf tmp
fc-cache -fv
```

Finally remember to add to .config/kitti/ a kitti.conf file containing:
```
include ./theme.conf
allow_remote_control yes
enable_audio_bell no
font_family JetBrainsMono Nerd Font Mono

clipboard_control write-clipboard write-primary read-clipboard read-primary
paste_actions no-op
```
And optionally, to .bashrc:
```
col(){
    kitty @ set-colors -a "~/.config/kitty/kitty-themes/themes/$1.conf"
}
listcol(){
  ls ~/.config/kitty/kitty-themes/themes/
}
dsa(){
docker start "$1" && docker attach "$1"
}
```
