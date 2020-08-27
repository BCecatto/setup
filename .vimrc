syntax enable           " enable syntax processing
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins
filetype on           " Enable filetype detection
set nocompatible      " We're running Vim, not Vi!

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
set runtimepath^=~/.vim/bundle/ctrlp.vim
set background=dark
set clipboard=unnamed
syntax on

nnoremap ; :
vnoremap ; :

" copy and paste commands
noremap <c-y> "+y
noremap <c-p> "+p

" nerdtree
nmap <silent> <leader>n :call NERDTreeCWD()<cr>

cnoreabbrev vsf vert<space>sf

" FZF fuzzy finder
set rtp+=/usr/local/opt/fzf
let g:ackprg = 'ag --vimgrep'

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
Plug 'slashmili/alchemist.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'scrooloose/nerdtree'
Plug 'elixir-editors/vim-elixir'                                                                                                  
Plug 'neoclide/coc.nvim', {'branch': 'release'} 
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-surround'
Plug 'dense-analysis/ale'
Plug 'dart-lang/dart-vim-plugin'
Plug 'thosakwe/vim-flutter'
Plug 'natebosch/vim-lsc'
Plug 'natebosch/vim-lsc-dart'
Plug 'janko-m/vim-test'
Plug 'morhetz/gruvbox'
Plug 'jiangmiao/auto-pairs'
Plug 'benmills/vimux'
Plug 'slim-template/vim-slim'
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'
Plug 'Shougo/neocomplete.vim'

call plug#end()

" save
nmap <Leader>q :q<CR>
nmap <Leader>w :w<CR>

" color schema
colo gruvbox

" Prompt for a command to run
map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>vz :VimuxZoomRunner<CR>
map <Leader>vt :VimuxTogglePane

" tabs commands
nmap <Leader>t :tabnew<CR>
nmap <Leader>tn :tabn<CR>
nmap <Leader>tp :tabp<CR>

" run tests
nmap <Leader>rs :TestFile<CR>
nmap <Leader>rn :TestNearest<CR>
nmap <Leader>rl :TestLast<CR>
nmap <Leader>ra :TestSuite<CR>
nmap <Leader>rv :TestVisit<CR>

" CtrlP config
let g:ctrlp_switch_buffer = 'et'
let g:ctrlp_use_caching = 0
set wildignore+=*/node_modules/*,*/_build/*,*/deps/*,*/.elixir_ls/*

" Config lsc dart
let g:lsc_auto_map = v:true

" Vim flutter key mappgin
nnoremap <leader>fa :FlutterRun<cr>
nnoremap <leader>fq :FlutterQuit<cr>
nnoremap <leader>fr :FlutterHotReload<cr>
nnoremap <leader>fR :FlutterHotRestart<cr>
nnoremap <leader>fD :FlutterVisualDebug<cr>

let g:ale_linters = {
			\   'elixir': ['elixir-ls'],
			\}

let g:ale_fixers = {
			\   'elixir': ['mix_format'],
			\}
let g:ale_elixir_elixir_ls_release='~/.asdf/installs/elixir/1.9.1'

let g:ale_completion_enabled = 1
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 'never'
highlight ALEErrorSign ctermbg=NONE ctermfg=white
highlight ALEWarningSign ctermbg=NONE ctermfg=white
let g:ale_linters_explicit = 1
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1

noremap <Leader>ad :ALEGoToDefinition<CR>
noremap <leader>af :ALEFix<cr>
noremap <Leader>ar :ALEFindReferences<CR>

" Column color for elixir files
augroup elixir
  au!
  autocmd FileType elixir set colorcolumn=98
augroup END
