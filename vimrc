set nocompatible


call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible' " load some sensible vim setup

" themes
Plug 'joshdick/onedark.vim', !has('nvim') ? {} : { 'on': [] }
Plug 'navarasu/onedark.nvim', has('nvim') ? {} : { 'on': [] }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" language specific
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'leafgarland/typescript-vim'
Plug 'rust-lang/rust.vim'

" code completion/diagnostics
Plug 'dense-analysis/ale'
Plug 'rust-lang/rust.vim'
"Plug 'scrooloose/syntastic' " better with some external tools: cppcheck
Plug 'mfussenegger/nvim-lsp-compl', { 'for': ['ruby'] }

Plug 'vim-test/vim-test'

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

" multicursor
Plug 'mg979/vim-visual-multi', {'branch': 'master'}


Plug 'madox2/vim-ai'

" Plug 'Shougo/vimproc.vim'

" Plug 'CoderCookE/vim-chatgpt'
" Plug 'aduros/ai.vim'

if has('nvim')
    Plug 'github/copilot.vim' , { 'for': [
        \ 'c',
        \ 'cmake',
        \ 'conf',
        \ 'cpp',
        \ 'gitcommit',
        \ 'html',
        \ 'javascript',
        \ 'json',
        \ 'lua',
        \ 'make',
        \ 'markdown',
        \ 'python',
        \ 'ruby',
        \ 'rust',
        \ 'sh',
        \ 'solidity',
        \ 'sql',
        \ 'toml',
        \ 'typescript',
        \ 'typescriptreact',
        \ 'vim',
        \ 'yaml'
    \ ] }

    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'
else
    Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clangd-completer --rust-completer --ts-completer', 'for': ['c', 'cpp', 'sql', 'rust', 'javascript', 'python', 'typescript', 'typescriptreact', 'solidity'] }
    Plug 'ggml-org/llama.vim'
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

syntax on

" vim-test
nmap <silent> <leader>tt :TestNearest<CR>
nmap <silent> <leader>tT :TestFile<CR>
nmap <silent> <leader>ta :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
let test#strategy = "neovim_sticky"
let g:test#neovim_sticky#kill_previous = 1
let g:test#preserve_screen = 0
let test#neovim_sticky#reopen_window = 1

" theme
if has('nvim')
    let g:onedark_config = {
      \ 'style': 'light',
      \ 'toggle_style_key': '<leader>ts',
      \ 'toggle_style_list': ['light', 'warm'],
      \ 'diagnostics': {
        \ 'darker': v:true,
        \ 'background': v:true
      \ }
    \ }
endif
colo onedark


if exists("g:neovide")
    set title
    set guifont=Fira\ Code,Noto\ Color\ Emoji:h11

    let g:neovide_scale_factor=1.0
    let g:neovide_cursor_vfx_mode = "pixiedust"
    let g:neovide_cursor_vfx_particle_density = 8.0
    let g:neovide_scroll_animation_length = 0
    let g:neovide_remember_window_size = v:false

    function! ChangeScaleFactor(delta)
      let g:neovide_scale_factor = g:neovide_scale_factor * a:delta
    endfunction

    nnoremap <expr><C-=> ChangeScaleFactor(1.25)
    nnoremap <expr><C--> ChangeScaleFactor(1/1.25)


    let g:copilot_filetypes = {'gitcommit': v:true, 'markdown': v:true}
    " let g:copilot_node_command = expand('~/.vim/node/bin/node')

    inoremap <C-s> <Cmd>call copilot#Suggest()<CR>
    " inoremap <C-p> <Cmd>lua require'lsp_compl'.trigger_completion()<CR>
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

let g:airline_powerline_fonts = 1
let g:airline_theme='onedark'


" function key mappings
map <F2> :YcmCompleter GoToImprecise<CR> " like in QtCreator
map <F4> :FSHere<CR> " like in QtCreator
map <F5> :NERDTreeToggle<CR>
map <F6> :Vista!!<CR>
map <F11> :ToggleBufExplorer<CR>

" other mappings
map <HOME> :SmartHomeKey<CR>

"nnoremap <leader>gd :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gi :YcmCompleter GoToInclude<CR>
nnoremap <leader>gt :YcmCompleter GetType<CR>
"nnoremap <leader>f :YcmCompleter FixIt<CR>
xnoremap <leader>c <Plug>NERDCommenterToggle
let g:ycm_global_ycm_extra_conf = '~/.ycm_global_extra_conf.py'

let g:ycm_confirm_extra_conf = 0
let g:ycm_always_populate_location_list=1
let g:ycm_key_list_select_completion = ['<A-Down>']
let g:ycm_key_list_previous_completion = ['<A-Up>']

set completeopt-=preview " do not show complete preview window



"let g:tsuquyomi_use_local_typescript = 0
"let g:tsuquyomi_use_dev_node_module = 0

call ale#Set('python_ruff_options', '.')
call ale#Set('python_mypy_options', '.')
"let g:ale_linters = { 'javascript': ['flow-language-server'] }
let g:ale_html_tidy_options = '-q -e -language en --custom-tags inline'
let g:ale_virtualenv_dir_names = ["orchid_venv", "venv", "venv38"]
let g:ale_completion_enabled = 0

let g:syntastic_disabled_filetypes=['html']
let g:syntastic_javascript_checkers = ['eslint']

let g:VM_maps = {}
let g:VM_maps["Switch Mode"] = '<C-Space>' " Copilot was also using tab


" spelunker.vim will handle spell checking
set nospell

" set extensions for fswitch
au! BufEnter *.cc let b:fswitchdst = 'h,hh'
au! BufEnter *.h let b:fswitchdst = 'cc,c,cpp'

command Msplit vsplit | copen


" TODO: most of these should be set globally
"au BufNewFile,BufRead *.py
    "\ set tabstop=4
    "\ set softtabstop=4
    "\ set shiftwidth=4
    "\ set expandtab
    "\ set autoindent
    "\ set fileformat=unix
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
