set nocompatible

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible' " load some sensible vim setup

Plug 'junegunn/seoul256.vim' " nice theme
Plug 'vim-airline/vim-airline'

" interesting stuff
"Plug 'terryma/vim-multiple-cursors' " who doesn't want multiple cursors?
"Plug 'Shougo/deol.nvim'

" code completion/diagnostics
Plug 'Valloric/YouCompleteMe' , { 'for': ['c', 'cpp', 'python', 'ruby', 'javascript', 'html', 'xml', 'xsd'] }
autocmd! User YouCompleteMe if !has('vim_starting') | call youcompleteme#Enable() | endif
Plug 'scrooloose/syntastic' " better with some external tools: cppcheck

" git utils
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" some useful misc stuff
Plug 'jszakmeister/vim-togglecursor' " also change cursor shape in insert mode in console
Plug 'ntpeters/vim-better-whitespace' " highlights trailing whitespace
Plug 'vim-scripts/Mark--Karkat' " multi color highlight words
Plug 'scrooloose/nerdcommenter' " toggle comment
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/Smart-Home-Key'
Plug 'derekwyatt/vim-fswitch'

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
set history=100 " command history
set nowrap " do not wrap line lines by default
set encoding=utf8
set wrap

" Write the contents of the file, if it has been modified, on each :next, :rewind, :last, :first, :previous, :stop, :suspend, :tag, :!, :make, CTRL-] and CTRL-^ command; and when a :buffer, CTRL-O, CTRL-I, '{A-Z0-9}, or `{A-Z0-9} command takes one to another file
set autowrite

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

" theme
let g:seoul256_srgb = 1
colo seoul256
set guifont=Liberation\ Mono\ 12

" Highlight extra whitespace color setup (must be after loading the color theme!)
highlight ExtraWhitespace guifg=DarkRed guibg=Red ctermbg=Red ctermfg=DarkRed cterm=underline gui=underline
" Make whitespace clearly visible
set listchars=tab:>·,trail:␣,extends:>,precedes:<
set list

let NERDTreeIgnore = ['\.pyc$', '\.o$', '\.d$']

" airline setup
set laststatus=2

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_left_sep='▶'
let g:airline_right_sep ='◀'
let g:airline_symbols.branch='⎇'

let g:airline#extensions#hunks#enabled=0
let g:airline_detect_spell=0
let g:airline#extensions#whitespace#enabled=0
let g:airline#extensions#syntastic#enabled=0

" function key mappings
map <F2> :YcmCompleter GoToImprecise<CR> " like in QtCreator
map <F4> :FSHere<CR> " like in QtCreator
map <F5> :NERDTreeToggle<CR>
map <F6> :TagbarToggle<CR>

" other mappings
map <HOME> :SmartHomeKey<CR>

nnoremap <leader>gd :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gi :YcmCompleter GoToInclude<CR>
nnoremap <leader>t :YcmCompleter GetType<CR>
nnoremap <leader>f :YcmCompleter FixIt<CR>

" Do not cancel multiple cursors when leaving visual mode
let g:multi_cursor_exit_from_visual_mode=0
" use Ctrl+C as multicursor next (default Ctrl+n used in browsers)
"let g:multi_cursor_next_key='<C-c>'

let g:multi_cursor_use_default_mapping=0

" Default mapping
let g:multi_cursor_start_word_key      = '<C-c>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-c>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" set extensions for fswitch
au! BufEnter *.cc let b:fswitchdst = 'h,hh'
au! BufEnter *.h let b:fswitchdst = 'cc,c,cpp'

set makeprg=$HOME/.vim/smartmake.rb\ %

" load additional local settings
if !empty(glob("$HOME/.vimrc_local"))
    so $HOME/.vimrc_local
endif
