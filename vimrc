set nocompatible

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible' " load some sensible vim setup
Plug 'junegunn/seoul256.vim' " nice theme

" interesting stuff
Plug 'gioele/vim-autoswap' " do not open file again, switch to that vim window!
Plug 'terryma/vim-multiple-cursors' " who doesn't want multiple cursors?

" code completion/diagnostics
Plug 'Valloric/YouCompleteMe', { 'for': 'cpp' }
autocmd! User YouCompleteMe if !has('vim_starting') | call youcompleteme#Enable() | endif
Plug 'scrooloose/syntastic' " better with some external tools: cppcheck

" git utils
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" some useful misc stuff
Plug 'jszakmeister/vim-togglecursor' " also change cursor shape in insert mode in console
Plug 'ntpeters/vim-better-whitespace' " highlights trailing whitespace
Plug 'bogado/file-line' " start vim with file line: $ vim myfile.cpp:125
Plug 'vim-scripts/Mark--Karkat' " multi color highlight words
Plug 'scrooloose/nerdcommenter' " toggle comment

" load additional locally used extra packages
if !empty(glob("$HOME/.vimrc_local_plug"))
    so $HOME/.vimrc_local_plug
endif

call plug#end()

filetype plugin indent on

" search options
set hlsearch " highlight search
set ignorecase
set smartcase
set incsearch " search while typing

" other misc settings
set colorcolumn=80 " draw a line at column 80
set number " line numbers
set spell
set autowrite
set history=100 " command history
set nowrap " do not wrap line lines by default
set encoding=utf8

" proper indenting
syntax on
filetype on
filetype indent on
filetype plugin on
set autoindent
set cindent
set copyindent
set smarttab

" shift click to search current word
set mousemodel=extend

" some sane wild card ignores
set wildignore=*.dll,*.o,*.out,*.pyc,*.bak,*.exe,*.jpg,*.jpeg,*.png,*.gif,*.class,*.pdf

" folding by syntax, open all folding by default
set foldmethod=syntax
set foldlevelstart=99

colo seoul256
set guifont=Liberation\ Mono\ 12

" Highlight extra whitespace color setup (must be after loading the color theme!)
highlight ExtraWhitespace guifg=DarkRed guibg=Red ctermbg=Red ctermfg=DarkRed cterm=underline gui=underline
" Make whitespace clearly visible
set listchars=tab:>·,trail:␣,extends:>,precedes:<
set list

" load additional local settings
if !empty(glob("$HOME/.vimrc_local"))
    so $HOME/.vimrc_local
endif
