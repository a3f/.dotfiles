syntax enable
if $TERM_PROGRAM=="Apple_Terminal"
set background=light
else
set background=light
endif
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
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-eunuch'
Plugin 'scrooloose/nerdcommenter'
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
"Plugin 'altercation/vim-colors-solarized'

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
"""""""""""""""""
"""" General """"
"""""""""""""""""

let mapleader=' '
" evaluate selection or till semi-colon
vnoremap <leader>e "ac<c-r>=<c-r>a<CR><Esc>T<space>
nnoremap <leader>e "ac/[;,:=]<cr><c-r>=<c-r>a<CR><Esc>T<space>:noh<cr>
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
" doesn't work in osx term
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
vmap <C-c> <plug>NERDCommenterInvert
nmap <C-c> <plug>NERDCommenterInvert

""""""""""""""""""""
"""" Navigation """"
""""""""""""""""""""
set ignorecase smartcase
" remove search highlight
set hlsearch
set incsearch
nnoremap <silent> <leader>n :noh<CR>
" left-hand line-wise navigation
nnoremap <silent> <c-w> <c-y>
" highlist last insertion
nnoremap gV `[v`]
hi MatchParen cterm=standout
nore ^ 0
nore 0 ^
" remember column when switching buffers
:se nostartofline
" <c-a> start of line, <c-e> end of line
cnore <c-b> <c-a>
cnore <c-a> <c-b>
if has ('nvim')
tnoremap <Esc> <C-\><C-n>
endif

"nnoremap <down> <C-d>
"nnoremap <up> <C-u>
nnoremap <leader>u :GundoToggle<CR>
"support for Inline::C code highlighting
"eventually __END__ highlighting must be removed
autocmd BufRead,BufNewFile *.pl call TextEnableCodeSnip('c', '__C__', '__DATA__', 'SpecialComment')
cabbr <expr> %% expand('%:p:h')

"""""""""""""""""""""
"""" Line breaks """"
"""""""""""""""""""""
set wrap linebreak nolist
"j/k enter wrapped lines
nnoremap j gj
nnoremap k gk

vnoremap j gj
vnoremap k gk
" ctrl+j breaks line
nnoremap <c-j> a<CR><Esc>k$ 

"""""""""""""""""
"""" Editing """"
"""""""""""""""""
"
"replace selection or current word with yanked text
vnoremap S "_dP
nnoremap S "_diwP
"nnoremap <C-space> A<c-x><c-l><Esc>
"nnoremap <C-@> A<c-x><c-l><Esc>
nnoremap <space> i<space><Esc>

"""""""""""""""""""
"""" Clipboard """"
"""""""""""""""""""
set clipboard=unnamed

nnoremap x "_x
vnoremap x "_x
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
let g:python_host_skip_check = 1
let g:python3_host_skip_check = 1
let g:syntastic_check_on_open = 1
let g:syntastic_enable_perl_checker = 1
let g:syntastic_perl_checkers = ["perl"]
let g:syntastic_masm_checkers = ["nasm"]
let g:syntastic_nasm_nasm_args = ["-f macho64"]
let g:syntastic_asm_nasm_args = ["-f macho64"]
let g:syntastic_masm_nasm_args = ["-f macho64"]
let g:syntastic_asm_nasm_args = ["-f macho64"]

let g:ycm_open_loclist_on_ycm_diags=1 
let g:ycm_extra_conf_vim_data = ['&filetype']
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
let g:ycm_register_as_syntastic_checker = 0 
let g:ycm_show_diagnostics_ui = 1
let g:ycm_always_populate_location_list = 1
set foldmethod=syntax
set foldlevel=99
" jump to decl/def
nnoremap <leader>g :YcmCompleter GoTo<CR>
nnoremap <leader>G :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>l :YcmForceCompileAndDiagnostics<CR><CR>
nnoremap <F8> :YcmForceCompileAndDiagnostics<CR><CR>
nnoremap <leader>L :YcmForceCompileAndDiagnostics<CR><CR>:YcmDiags<CR>
nnoremap <leader>T :YcmCompleter GetType<CR>
nnoremap <leader>/ :YcmShowDetailedDiagnostic<CR>
nnoremap <leader>fmt :%!astyle<CR>``
" this needs to be <leader>l and per filetype
nnoremap <leader>a :SyntasticCheck<CR>
nnoremap <F7> :lprevious<CR>
nnoremap <F9> :lnext<CR>

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

function! TextEnableCodeSnip(filetype,start,end,textSnipHl)
  let ft=toupper(a:filetype)
  let group='textGroup'.ft
  if exists('b:current_syntax')
    let s:current_syntax=b:current_syntax
    " Remove current syntax definition, as some syntax files (e.g. cpp.vim)
    " do nothing if b:current_syntax is defined.
    unlet b:current_syntax
  endif
  execute 'syntax include @'.group.' syntax/'.a:filetype.'.vim'
  try
    execute 'syntax include @'.group.' after/syntax/'.a:filetype.'.vim'
  catch
  endtry
  if exists('s:current_syntax')
    let b:current_syntax=s:current_syntax
  else
    unlet b:current_syntax
  endif
  execute 'syntax region textSnip'.ft.'
  \ matchgroup='.a:textSnipHl.'
  \ start="'.a:start.'" end="'.a:end.'"
  \ contains=@'.group
endfunction

