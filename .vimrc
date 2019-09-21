yntax enable           " enable syntax processing

" spaces and tabs
set tabstop=2       " number of visual spaces per TAB
set softtabstop=2   " number of spaces in tab when editing
set shiftwidth=2
set expandtab       " tabs are spaces
set smartindent
set autoindent
set nu

set path+=**

" ui config
set showmatch           " highlight matching [{()}]
set cursorline          
set colorcolumn=80

" searching
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set ignorecase

set showmatch
set nocompatible
set clipboard=unnamed
set wildmenu
set esckeys
set backspace=indent,eol,start
set ttyfast
set encoding=utf-8 nobomb
let mapleader=" "
set noerrorbells
set nostartofline
set ruler
set shortmess=atI
set showmode
set title
set showcmd
set scrolloff=4

nnoremap ; :
vnoremap ; :

cnoreabbrev vsf vert<space>sf

" FZF fuzzy finder
set rtp+=/usr/local/opt/fzf

" fd finder https://github.com/sharkdp/fd

command FV call fzf#run({'source': 'fd', 'sink': 'vsp', 'options': '-m', 'down': '30%'})
command FS call fzf#run({'source': 'fd', 'sink': 'sp', 'options': '-m', 'down': '30%'})
command FE call fzf#run({'source': 'fd', 'sink': 'e', 'options': '-m', 'down': '30%'})

" Strip trailing whitespace (,ss)
function! StripWhitespace()
 let save_cursor = getpos(".")
 let old_query = getreg('/')
 :%s/\s\+$//e
 call setpos('.', save_cursor)
 call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>
" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" Automatic commands
if has("autocmd")
 " Enable file type detection
 filetype on
 " Treat .json files as .js
 autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
 " Treat .md files as Markdown
 autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
endif

" Plugins
" https://github.com/junegunn/vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'elixir-editors/vim-elixir'
Plug 'ntk148v/vim-horizon'

call plug#end()

color horizon

" Column color for elixir files
augroup elixir
  au!
  autocmd FileType elixir set colorcolumn=98
augroup END
