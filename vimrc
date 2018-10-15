set nocompatible

filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'itchyny/lightline.vim'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-eunuch'

call vundle#end()            
filetype plugin indent on   

syntax enable
set t_Co=256




set hidden

set wildmenu
set showcmd

set ignorecase
set smartcase
set backspace=indent,eol,start

set autoindent
set nostartofline

set confirm
set visualbell
set t_vb=


set expandtab
set shiftwidth=2
set softtabstop=2


set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//

autocmd VimEnter * command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>, '', <bang>0)

nnoremap ;  :FZF <CR>



nnoremap <C-o> :NERDTreeToggle<CR>
nnoremap gn :tabedit<CR>
nnoremap gb :tabclose<CR>



command PrettyJSON %!python -m json.tool




