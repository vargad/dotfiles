set nocompatible


" make sure vim-plug is installed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible' " load some sensible vim setup

" themes
Plug 'junegunn/seoul256.vim', has('vim') ? {} : { 'on': [] }
Plug 'navarasu/onedark.nvim', has('nvim') ? {} : { 'on': [] }
Plug 'vim-airline/vim-airline'
Plug 'ryanoasis/vim-devicons'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" language specific
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'leafgarland/typescript-vim'
Plug 'rust-lang/rust.vim'

" code completion/diagnostics
Plug 'Valloric/YouCompleteMe' , { 'do': './install.py --clang-completer --rust-completer --ts-completer', 'for': ['c', 'cpp', 'sql', 'rust', 'javascript', 'typescript', 'typescriptreact'] }
Plug 'dense-analysis/ale'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/syntastic' " better with some external tools: cppcheck

" git utils
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on':  'NERDTreeToggle' }

" other utils
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tiagofumo/vim-nerdtree-syntax-highlight',  { 'on':  'NERDTreeToggle' }
Plug 'liuchengxu/vista.vim'
Plug 'derekwyatt/vim-fswitch'
Plug 'jlanzarotta/bufexplorer'
Plug 'kamykn/spelunker.vim' " improve spellcheck supporting camelCase and other variations

" some useful misc stuff
Plug 'jszakmeister/vim-togglecursor' " also change cursor shape in insert mode in console
Plug 'ntpeters/vim-better-whitespace' " highlights trailing whitespace
Plug 'vim-scripts/Mark--Karkat' " multi color highlight words
Plug 'scrooloose/nerdcommenter' " toggle comment
Plug 'vim-scripts/Smart-Home-Key' " smart jump to home, toggle between start of line and first text in line

" Plug 'CoderCookE/vim-chatgpt'

if has('nvim')
    Plug 'github/copilot.vim' , { 'for': [
        \ 'c',
        \ 'conf',
        \ 'cpp',
        \ 'gitcommit',
        \ 'html',
        \ 'javascript',
        \ 'json',
        \ 'markdown',
        \ 'python',
        \ 'ruby',
        \ 'rust',
        \ 'sh',
        \ 'sql',
        \ 'typescript',
        \ 'typescriptreact',
        \ 'vim'
    \ ] }
endif

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

set shiftwidth=4

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

" shift click to search current word
set mousemodel=extend
set mouse=a

" some sane wild card ignores
set wildignore=*.dll,*.o,*.out,*.pyc,*.bak,*.exe,*.jpg,*.jpeg,*.png,*.gif,*.class,*.pdf

" folding by syntax, open all folding by default
set foldmethod=syntax
set foldlevelstart=99


" theme
if !has('nvim')
    let g:seoul256_srgb = 1
    " colo seoul256
    colo seoul256-light
else
    let g:onedark_config = {
      \ 'style': 'light',
      \ 'toggle_style_key': '<leader>ts',
      \ 'toggle_style_list': ['light', 'warm'],
      \ 'diagnostics': {
        \ 'darker': v:true,
        \ 'background': v:true
      \ }
    \ }
    colo onedark
endif

if exists("g:neovide")
    set title
    set guifont=Fira\ Code,Noto\ Color\ Emoji:h11

    let g:neovide_scale_factor=1.0
    let g:neovide_cursor_vfx_mode = "pixiedust"
    let g:neovide_cursor_vfx_particle_density = 8.0

    function! ChangeScaleFactor(delta)
      let g:neovide_scale_factor = g:neovide_scale_factor * a:delta
    endfunction

    nnoremap <expr><C-=> ChangeScaleFactor(1.25)
    nnoremap <expr><C--> ChangeScaleFactor(1/1.25)


    let g:copilot_filetypes = {'gitcommit': v:true, 'markdown': v:true}

    inoremap <C-s> <Cmd>call copilot#Suggest()<CR>
else
    set guifont=Liberation\ Mono\ 11
endif

if has('nvim')
    set clipboard^=unnamed,unnamedplus
endif


" Highlight extra whitespace color setup (must be after loading the color theme!)
highlight ExtraWhitespace guifg=DarkRed guibg=Red ctermbg=Red ctermfg=DarkRed cterm=underline gui=underline
" Make whitespace clearly visible
set listchars=tab:>·,trail:␣,extends:>,precedes:<
set list

let NERDTreeIgnore = ['\.pyc$', '\.o$', '\.d$', '^venv']

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
map <F6> :Vista!!<CR>
map <F11> :ToggleBufExplorer<CR>

" other mappings
map <HOME> :SmartHomeKey<CR>

nnoremap <leader>gd :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gi :YcmCompleter GoToInclude<CR>
nnoremap <leader>t :YcmCompleter GetType<CR>
nnoremap <leader>f :YcmCompleter FixIt<CR>
let g:ycm_global_ycm_extra_conf = '~/.ycm_global_extra_conf.py'

let g:ycm_always_populate_location_list=1

let g:syntastic_javascript_checkers = ['eslint']

" Default mapping
let g:multi_cursor_start_word_key      = '<C-c>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-c>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'


call ale#Set('python_ruff_options', '.')
call ale#Set('python_mypy_options', '.')
let g:ale_html_tidy_options = '-q -e -language en --custom-tags inline'
let g:ale_virtualenv_dir_names = ["orchid_venv", "venv", "venv38"]
let g:ale_completion_enabled = 1
let g:syntastic_disabled_filetypes=['html']


" spelunker.vim will handle spell checking
set nospell

" set extensions for fswitch
au! BufEnter *.cc let b:fswitchdst = 'h,hh'
au! BufEnter *.h let b:fswitchdst = 'cc,c,cpp'

set makeprg=$HOME/.vim/smartmake.rb\ %
autocmd BufRead,BufNewFile *.rs set makeprg=$HOME/.vim/smartmake.rb\ %

" load additional local settings
if !empty(glob("$HOME/.vimrc_local"))
    so $HOME/.vimrc_local
endif

set tabstop=4 shiftwidth=4 expandtab

autocmd BufRead,BufNewFile *.rb set tabstop=4 shiftwidth=4 expandtab
autocmd Filetype javascript setlocal tabstop=2 shiftwidth=2 expandtab
autocmd Filetype typescript setlocal tabstop=2 shiftwidth=2 expandtab
autocmd Filetype typescriptreact setlocal tabstop=2 shiftwidth=2 expandtab
