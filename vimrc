set nocompatible
set encoding=utf-8

" USEFUL SHORTCUTS
" Ctags: Ctrl + ]   --> go to tag
" Ctags: Ctrl + w }   Ctrl + wz --> open/close tag location in side panel
" Ctags: :tn :tp --> jump to next/previous tag

" Markdown (tabular and vim-markdown) see link
" https://vimawesome.com/plugin/markdown-syntax 

filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'junegunn/fzf'
Plugin 'scrooloose/nerdtree'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-commentary'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'edkolev/tmuxline.vim'
Plugin 'kuznetsss/shswitch'
Plugin 'majutsushi/tagbar'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/syntastic'

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



nnoremap <C-b> :NERDTreeToggle<CR>
nnoremap gn :tabedit<CR>
nnoremap gb :tabclose<CR>


nnoremap gs :SHSwitch<CR>
nnoremap gz :TagbarToggle<CR>


" Auto generate tags file on file write of *.c *.cpp *.h *.hpp files
autocmd BufWritePost *.c,*.cpp,*.h,*.hpp silent! !ctags . &

command! PrettyJSON %!python -m json.tool

let g:ycm_show_diagnostics_ui = 0


let g:airline_theme='solarized'
let g:tmuxline_powerline_separators=0

map <C-K> :py3f  /usr/share/clang/clang-format-13/clang-format.py<cr>
imap <C-K> <c-o>:py3f /usr/share/clang/clang-format-13/clang-format.py<cr>

" Paste from X CLIPBOARD leader is \
map <leader>pb :r!xsel --clipboard<CR>

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor\ --column
  set grepformat=%f:%l:%c%m
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind F (backward slash) to grep shortcut
command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap F :Ag<SPACE>

" Syntastic config
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
