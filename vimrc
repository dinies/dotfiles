set nocompatible
set encoding=utf-8

filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'junegunn/fzf'
Plugin 'scrooloose/nerdtree'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-eunuch'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'edkolev/tmuxline.vim'

call vundle#end()            
filetype plugin indent on   

syntax enable
set t_Co=256

set statusline+=%F



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



let g:airline_theme='solarized'
let g:tmuxline_powerline_separators=0


map <C-K> :py3f  /usr/share/clang/clang-format-6.0/clang-format.py<cr>
imap <C-K> <c-o>:py3f /usr/share/clang/clang-format-6.0/clang-format.py<cr>

function! Formatonsave()
    let l:formatdiff = 1
      py3f /usr/share/clang/clang-format-6.0/clang-format.py
    endfunction
    autocmd BufWritePre *.h,*.cc,*.cpp call Formatonsave()


