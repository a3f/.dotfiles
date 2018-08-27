syntax enable
set background=dark
set nocompatible              " be iMproved, required
filetype off                  " required

" Load vim-plug
if empty(glob("~/.vim/autoload/plug.vim"))
    execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

" set the runtime path to include Plug and initialize
call plug#begin('~/.local/share/nvim/plugged')

Plug 'vivien/vim-linux-coding-style'
Plug 'yssl/QFEnter'
Plug 'zirrostig/vim-schlepp'
Plug 'iCyMind/NeoSolarized'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'racer-rust/vim-racer', { 'for' : 'rust' }
Plug 'airblade/vim-gitgutter'
Plug 'rust-lang/rust.vim', { 'for' : 'rust' }
Plug 'othree/eregex.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-characterize'
Plug 'lervag/vimtex' , { 'for' : 'tex' }
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-eunuch'
Plug 'FooSoft/vim-argwrap'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'Valloric/YouCompleteMe', { 'for' : ['c', 'c++', 'rust', 'objc', 'objc++'] }
Plug 'vim-perl/vim-perl', { 'for' : 'perl' }
Plug 'vim-perl/vim-perl6', { 'for' : 'perl6' }
Plug 'bling/vim-airline'
Plug 'kien/ctrlp.vim'
"Plug 'vim-scripts/a.vim'
Plug 'bogado/file-line'
Plug 'sjl/gundo.vim'
Plug 'xolox/vim-misc'
Plug 'bronson/vim-trailing-whitespace'
Plug 'dag/vim2hs', { 'for' : 'haskell' }
Plug 'eagletmt/ghcmod-vim', { 'for' : 'haskell' }
Plug 'eagletmt/neco-ghc', { 'for' : 'haskell' }
Plug 'scrooloose/syntastic'
Plug 'nxadm/syntastic-perl6', { 'for' : 'perl6' }
Plug 'ajh17/Spacegray.vim'
Plug 'rdnetto/YCM-Generator', { 'for' : 'cmake' }
Plug 'godlygeek/tabular'
Plug 'vim-scripts/gtags.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'benmills/vimux'
"Bundle 'christoomey/vim-sort-motion'
"Plugin 'welle/targets.vim'
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
"Plugin 'gilligan/vim-lldb'
"Plugin 'xolox/vim-easytags'
"Plugin 'rosenfeld/conque-term'
"
call plug#end()            " required

set termguicolors
colorscheme NeoSolarized
if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
  set t_Co=16
endif


let g:VimuxRunnerIndex=3

" All of your Plugins must be added before the following line
filetype plugin on    " required
filetype indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

"""""""""""""""""
"""" General """"
"""""""""""""""""

let mapleader=' '
" evaluate selection or till semi-colon
vnoremap <leader>e "ac<c-r>=<c-r>a<CR><Esc>T<space>
nnoremap <leader>e "ac/[;,:=]<cr><c-r>=<c-r>a<CR><Esc>T<space>:noh<cr>
nnoremap <leader><backspace> :w<CR>

vmap  <unique> <LEFT> <Plug>SchleppLeft
vmap  <unique> <RIGHT> <Plug>SchleppRight
vmap  <unique> <DOWN> <Plug>SchleppDown
vmap  <unique> <UP> <Plug>SchleppUp
vmap  <unique> D <Plug>SchleppDup

" Remove any introduced trailing whitespace after moving...
let g:Schlepp#trimWS = 1


nore ; :
nore : ;
set encoding=utf-8
set fileencoding=utf-8

""""""""""""
"""" UI """"
""""""""""""

set lazyredraw
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
autocmd VimEnter * call AirlineAddFunc()

"""""""""""""""""""""""""
"""" Buffer handling """"
"""""""""""""""""""""""""
set hidden
nnoremap  <silent>   <tab>  :bnext<CR>
nnoremap  <silent> <s-tab>  :bprevious<CR>
nnoremap Z<tab> :bd<CR>
" jump to last buffer
nnoremap <silent> <leader><tab> :b#<cr>

"""""""""""""""""""""""""
"""" Code formatting """"
"""""""""""""""""""""""""
"make tab in v mode indent code
vmap <tab> >gv
vmap <s-tab> <gv
imap <S-tab> <C-d>

set tabstop=8    "Number of spaces that a <Tab> in the file counts for"
set expandtab
set shiftwidth=4
set textwidth=0	"
set wrapmargin=0
set formatoptions-=t
set autoindent
set backspace=indent,eol,start
" this if for looooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooong lines
set showbreak=↪\ 
set scrolloff=1
set sidescrolloff=5
if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j " Delete comment character when joining commented lines
endif




vmap <C-c> <plug>NERDCommenterNested
nmap <C-c> <plug>NERDCommenterInvert
"nnoremap <silent> = :ArgWrap<CR>

""""""""""""""""""""
"""" Navigation """"
""""""""""""""""""""
set ignorecase smartcase
" remove search highlight
set hlsearch
set incsearch
nnoremap <silent> <leader>n :noh<CR>
" left-hand line-wise navigation
nnoremap <C-q> <C-y>
nnoremap <up> <C-y>
nnoremap <down> <C-e>
" line-wise navigation for when <c-q> and <c-e> are remapped to <m-f> and <m-b>
nnoremap <m-b> <c-y>
nnoremap <m-f> <c-e>
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
tnoremap <Esc> <C-Bslash><C-n>
endif

"nnoremap <down> <C-d>
"nnoremap <up> <C-u>
nnoremap <leader>u :GundoToggle<CR>
nnoremap <leader>z :NERDTreeToggle<CR>
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
" Jump to line 42 with 42G
nnoremap <CR> G
" ctrl+j breaks line
nnoremap <c-j> a<CR><Esc>k$

"""""""""""""""""
"""" Editing """"
"""""""""""""""""
"
"replace FALSE or current word with yanked text
vnoremap S "0P
nnoremap S viw"0P
"nnoremap <C-space> A<c-x><c-l><Esc>
"nnoremap <C-@> A<c-x><c-l><Esc>
nnoremap <space> i<space><Esc>

"""""""""""""""""""
"""" Clipboard """"
"""""""""""""""""""
set clipboard=unnamed

nnoremap x "_x
nnoremap X "_X
vnoremap x "_x
vnoremap X "_X
" accumulate yanks instead of overwriting
nnoremap <leader>y "Ayy
nnoremap <leader>d "Add
nnoremap <leader>Y "ayy
" lmao
nnoremap <leader>D "add
nnoremap <leader>p "ap
nnoremap <leader>P "aP

"""""""""""""""""""""""
"""" Code specific """"
"""""""""""""""""""""""
let g:linuxsty_patterns = [ "/usr/src/", "/linux", "~/linux", "~/prjs/uman" ]
let g:python_host_skip_check = 1
let g:python3_host_skip_check = 1
let g:syntastic_check_on_open = 1
let g:syntastic_enable_perl_checker = 1
let g:syntastic_perl6_checkers = ['jsonerror']
let g:syntastic_enable_perl6_jsonerror_checker = 1

let g:syntastic_perl_checkers = ["perl"]
let g:syntastic_masm_checkers = ["nasm"]
let g:syntastic_nasm_nasm_args = ["-f macho64"]
let g:syntastic_asm_nasm_args = ["-f macho64"]
let g:syntastic_masm_nasm_args = ["-f macho64"]
let g:syntastic_asm_nasm_args = ["-f macho64"]
let g:syntastic_vhdl_ghdl_args = ["--workdir=work"]
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_open_loclist_on_ycm_diags=1
let g:ycm_extra_conf_vim_data = ['&filetype']
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
let g:ycm_register_as_syntastic_checker = 0
let g:ycm_rust_src_path="~/dl/rust-master/src/"
let g:ycm_show_diagnostics_ui = 1
let g:ycm_always_populate_location_list = 1
set include-=i
"set foldmethod=syntax
"set foldlevel=99
nnoremap <leader>s :setlocal spell spelllang=en_us<CR>
" jump to decl/def
nore <C-]> :Gtags<CR><CR>
nore <C-Bslash> :Gtags -r<CR><CR>
map + :cn<CR>
map - :cp<CR>
nnoremap <leader>g :YcmCompleter GoTo<CR>
nnoremap <leader>G :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>l :YcmForceCompileAndDiagnostics<CR><CR>
"nnoremap <F8> :YcmForceCompileAndDiagnostics<CR><CR>
nnoremap <leader>L :YcmForceCompileAndDiagnostics<CR><CR>:YcmDiags<CR>
nnoremap <leader>T :YcmCompleter GetType<CR>
nnoremap <leader>/ :YcmShowDetailedDiagnostic<CR>
nnoremap <leader>fmt :%!astyle<CR>``
" this needs to be <leader>l and per filetype
nnoremap <leader>a :SyntasticCheck<CR>
nnoremap <F7> :lprevious<CR>
nnoremap <F9> :lnext<CR>
nnoremap <left> :lprevious<CR>
nnoremap <right> :lnext<CR>

command! -nargs=0 Spellcheck setlocal spell spelllang=en_us

if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif

command! -nargs=? Test call s:runtest(<f-args>)
fun! s:runtest(...)
    if a:0 == 0
        VimuxRunLastCommand
    else
        VimuxRunCommand a:1
    endif
endfun

"""""""""""""""""""""""
"""" File specific """"
"""""""""""""""""""""""
autocmd BufRead,BufNewFile *.hsc set filetype=haskell
autocmd BufRead,BufNewFile *.h   set syntax=c
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

function! AirlineAddFunc()
  let spc = g:airline_symbols.space
  call airline#parts#define_raw('function', '%{Options()}')
  "call airline#parts#define_raw('func', 'kek')
  "let g:airline_section_c = airline#section#create_right([' ƒ ', 'function'])
  if exists("+autochdir") && &autochdir == 1
      "let g:airline_section_c = airline#section#create_right(['%<', 'path', spc, 'readonly', 'function'])
  else
      let g:airline_section_gutter = airline#section#create_left(['%=', 'function'])
  endif
  call airline#parts#define_accent('function', 'white')
endfunction

fu! Options()
  if &ft=="cpp" || &ft=="perl" || &ft =="c"
    return ShowFuncName()
  endif
  return ""
endfunction

fun! ShowFuncName()
  let lnum = line(".")
  let col = col(".")
  echohl ModeMsg
  " FIXME remove args
  let text = getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
  let text = substitute(text, '\((\|=\).*', '', 'g')
  echohl None
  call search("\\%" . lnum . "l" . "\\%" . col . "c")
  return text
endfun
