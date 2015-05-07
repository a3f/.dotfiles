syntax enable
set background=dark
colorscheme solarized
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'git://git.wincent.com/command-t.git'
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-perl/vim-perl'
Plugin 'bling/vim-airline'
"Plugin 'gilligan/vim-lldb'
Plugin 'kien/ctrlp.vim'
Plugin 'a.vim'
Plugin 'sjl/gundo.vim'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-easytags'
"Plugin 'rosenfeld/conque-term'
Plugin 'dag/vim2hs'
Plugin 'eagletmt/neco-ghc'
Plugin 'eagletmt/ghcmod-vim'
Plugin 'scrooloose/syntastic'
Plugin 'altercation/vim-colors-solarized'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
let g:ycm_extra_conf_vim_data = ['&filetype']
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"

"""""""""""""""""
"""" General """"
"""""""""""""""""

let mapleader=' '
" evaluate selection or till semi-colon
vnoremap <leader>e "tc<c-r>=<c-r>t<CR><Esc>T<space>
nnoremap <leader>e "tct;<c-r>=<c-r>t<CR><Esc>T<space>
nnoremap <leader><backspace> :w<CR>

nore ; :
nore : ;
set encoding=utf-8
set fileencoding=utf-8

""""""""""""
"""" UI """"
""""""""""""

set nrformats+=alpha
set number
set showcmd
set wildmenu
set wildmode=list:longest,full
set mouse=a
set relativenumber
set guifont=Inconsolata\ for\ Powerline:h16
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts=1
set laststatus=2
"set timeoutlen=50 "fixes pause when leaving insert mode
set timeoutlen=1000 ttimeoutlen=0
if !exists('g:airline_symbols')
let g:airline_symbols = {}
endif
" unicode symbols
let g:airline_symbols.whitespace = '·'
let g:airline_symbols.linenr = 'Ξ'
"let g:airline#extensions#loclist#enabled = 1
autocmd VimEnter * call AirlineAddTime()

"""""""""""""""""""""""""
"""" Buffer handling """"
"""""""""""""""""""""""""
set hidden
nnoremap  <silent>   <tab>  :bnext<CR>
nnoremap  <silent> <s-tab>  :bprevious<CR>
nnoremap Z<tab> :bd<CR>

"""""""""""""""""""""""""
"""" Code formatting """"
"""""""""""""""""""""""""
"make tab in v mode indent code
vmap <tab> >gv
vmap <s-tab> <gv

set tabstop=4    "Number of spaces that a <Tab> in the file counts for"
set shiftwidth=4
set textwidth=0
set wrapmargin=0
set formatoptions-=t

""""""""""""""""""""
"""" Navigation """"
""""""""""""""""""""
set ignorecase smartcase
" remove search highlight
set hlsearch
set incsearch
nnoremap <silent> <leader>n :noh<CR>
" highlist last insertion
nnoremap gV `[v`]
"nnoremap <down> <C-d>
"nnoremap <up> <C-u>
nnoremap <leader>u :GundoToggle<CR>

"""""""""""""""""""""
"""" Line breaks """"
"""""""""""""""""""""
set wrap linebreak nolist
"j/k enter wrapped lines
nnoremap j gj
nnoremap k gk
" ctrl+j breaks line
"nnoremap <NL> i<CR><ESC>
nnoremap <leader>j o<Esc>
nnoremap <leader>k O<Esc>

"""""""""""""""""
"""" Editing """"
"""""""""""""""""
"replace selection or current word with yanked text
vnoremap S "_dP
nnoremap S "_diwP
inoremap jk <Esc>
"""""""""""""""""""
"""" Clipboard """"
"""""""""""""""""""
set clipboard=unnamed

" accumulate yanks instead of overwriting
nnoremap <leader>y "Ayy
nnoremap <leader>d "Add
nnoremap <leader>Y "ayy
nnoremap <leader>D "add
nnoremap <leader>p "ap
nnoremap <leader>P "aP

"""""""""""""""""""""""
"""" Code specific """"
"""""""""""""""""""""""
let g:syntastic_masm_checkers = ["nasm"]
let g:syntastic_nasm_nasm_args = ["-f macho64"]
let g:syntastic_asm_nasm_args = ["-f macho64"]
let g:syntastic_masm_nasm_args = ["-f macho64"]
let g:syntastic_asm_nasm_args = ["-f macho64"]
let g:ycm_open_loclist_on_ycm_diags=1 
set foldmethod=syntax
set foldlevel=99
" jump to decl/def
nnoremap <leader>g :YcmCompleter GoTo<CR>
nnoremap <leader>G :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>l :YcmForceCompileAndDiagnostics<CR><CR>
nnoremap <leader>L :YcmForceCompileAndDiagnostics<CR><CR>:YcmDiags<CR>
nnoremap <leader>T :YcmCompleter GetType<CR>
nnoremap <leader>fmt :%!astyle<CR>``
" this needs to be <leader>l and per filetype
nnoremap <leader>a :SyntasticCheck<CR>

"""""""""""""""""""""""
"""" File specific """"
"""""""""""""""""""""""
autocmd BufRead,BufNewFile *.hsc set filetype=haskell
autocmd VimLeave *.* :mksession! ~/.vimsession<CR>
"map ZZ :mksession! ~/.vimsession<CR>
"source ~/.vimsession 3

"""""""""""""""""""
"""" Functions """"
"""""""""""""""""""
function! AirlineAddTime()
  call airline#parts#define_raw('time', '%{strftime("%R")}')
  let g:airline_section_warning = airline#section#create([' ⎋ ', 'time'])
  call airline#parts#define_accent('time', 'white')
endfunction

