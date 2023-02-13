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
We are using this [Kitty coloschemes](https://github.com/dexpota/kitty-themes)
