# Explicitly configured $PATH variable
PATH=/usr/local/git/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/opt/local/bin:/opt/local/sbin:/usr/X11/bin

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="xiong-chiamiov-plus"
ZSH_THEME="steeef"

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git kubectl osx zsh-syntax-highlighting brew repo sudo knife vagrant bundler web-search)

source $ZSH/oh-my-zsh.sh

# Put any proprietary or private functions/values in ~/.private, and this will source them
if [ -f $HOME/.private ]; then
  source $HOME/.private
fi

if [ -f $HOME/.profile ]; then
  source $HOME/.profile  # Read Mac .profile, if present.
fi

# Shell Aliases
## Git Aliases
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias go='git checkout '
###alias gk='gitk --all&'
###alias gx='gitx --all'
###alias got='git '
###alias get='git '

## Miscellaneous Aliases
alias htop='sudo htop'

# z directory jumper
. ~/dotfiles/z/z.sh
# Shell Functions
# qfind - used to quickly find files that contain a string in a directory
qfind () {
  find . -exec grep -l -s $1 {} \;
  return 0
}

# Custom exports
## Set EDITOR to /usr/bin/vim if Vim is installed
if [ -f /usr/bin/vim ]; then
  export EDITOR=/usr/bin/vim
fi

# pyenv settings
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
# # pyenv virtualenv plug-in
if which pyenv-virtualenv-init > /dev/null; then
   eval "$(pyenv virtualenv-init -)"
fi

# MacVim alias
alias mvim='/Applications/MacVim.app/Contents/bin/mvim -v'

# Sublime from command line
subl () {
    open -a "Sublime Text" $@
}

#MacTex binaries linking
export PATH="/Library/Tex/texbin:$PATH"

#python path for iphithon and jupiter
export PATH="~/.local/bin:$PATH"


#swiftenv
export SWIFTENV_ROOT=/usr/local/var/swiftenv 
if which swiftenv > /dev/null; then eval "$(swiftenv init -)"; fi

#swift version choose:
export PATH=/Library/Developer/Toolchains/swift-4.2-DEVELOPMENT-SNAPSHOT-2018-08-07-a.xctoolchain/usr/bin:"${PATH}"


