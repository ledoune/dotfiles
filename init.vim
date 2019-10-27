" Doune's vimrc file
"
" TODO ORGANIZE

" # BASICS #

" option not vi compatible
set nocompatible

" encoding
set encoding=utf-8
scriptencoding utf-8

" lines of history to remember
set history=500

" enable filetype plugins
filetype plugin on
filetype indent on

" always shows line number
set number
set relativenumber

" set autoread when a file is changed from the outside
set autoread

" map leader for extra combinations
let mapleader = ","

" fast saving
nmap <leader>w :w!<cr>

" sudo save
command! W w !sudo tee % > /dev/null

" backups and persistent undo
set backup
if has('persistent_undo')
    set undofile
    set undolevels=1000
    set undoreload=10000
endif


" # INTERFACE #

" lines to the cursor when moving up/down
set so=9

" wildmenu for command completion
set wildmenu
set wildmode=list:longest,full
set wildignore=*.o,*~,*/.git/*

" cursor position
set ruler

" highlight current line
set cursorline

" show current mode
set showmode

" command bar height
set cmdheight=2

" always show status bar
set laststatus=2

" hidden buffers
set hidden

" backspace behavior
set backspace=eol,start,indent

" which commands wrap at the eol
set whichwrap+=<,>,h,l

" ignore case when searching
set ignorecase
set smartcase

" search highlight
set hlsearch

" incremental search (as you type)
set incsearch

" regex
set magic

" show matching brackets
set showmatch

" split positions
set splitright
set splitbelow

" no sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" enable syntax highlighting
syntax enable

" allow cursor beyond last char
set virtualedit=onemore

" restore state from last edit session
au BufWinLeave ?* mkview
au BufWinEnter ?* silent loadview
" avoid this behavior for git commits
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0,1,1,0])

" # TEXT #

" use spaces instead of tabs and tabs settings
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

" linebreak on 500 char
set lbr
set tw=500

" indent and wrapping
set autoindent
set smartindent
set nowrap

set complete-=i
" removes octal from ctrl-A command
set nrformats-=octal
" shorten messages
set shortmess+=c

" eow characters
set iskeyword-=.
set iskeyword-=#
set iskeyword-=-
set iskeyword-=_

" # KEY BINDINGS #

" remap search to space
map <space> /

" disable highlight
map <silent> <leader><cr> :noh<cr>

" move between windows
map <C-h> <C-W>h
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l

" close all buffers
map <leader>ba :bufdo bd<cr>

" buffer navigation
map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" buffer behavior for quickfix commands
set switchbuf=useopen,usetab,newtab

" tabs management
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
" tab back and forth
let g:lasttab=1
nmap <leader>tl :exe "tabn ".g:lasttab<cr>
au TabLeave * let g:lasttab=tabpagenr()
" tab with cwd for current buffer
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/
" switch cwd to current buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" remap 0 to first non blank char
map 0 ^

" find merge conflict markers
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

" visual shifting
vnoremap < <gv
vnoremap > >gv

" adjust viewports to the same size
map <leader>= <c-w>=

" Map <Leader>ff to display all lines with keyword under cursor and ask which one to jump to
nmap <leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" move a line of text using alt+[ui]
nmap <M-u> mz:m+<cr>`z
nmap <M-i> mz:m-2<cr>`z
vmap <M-u> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-u> :m'<-2<cr>`>my`<mzgv`yo`z

" toggle spell checking
map <leader>ss :setlocal spell!<cr>

" auto complete of (, ", ', [
inoremap $1 ()<esc>i
inoremap $2 []<esc>i
inoremap $3 {}<esc>i
inoremap $4 {<esc>o}<esc>O
inoremap $q ''<esc>i
inoremap $e ""<esc>i


" # FUNCTIONS #


" # PLUGINS #

call plug#begin()

" Airline : light status line
Plug 'vim-airline/vim-airline'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled=1
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'

" CtrlP : fuzzy finder
Plug 'ctrlpvim/ctrlp.vim'
" extend it with simple function search
Plug 'tacahiroy/ctrlp-funky'
nnoremap <leader>fu :CtrlPFunky<cr>
" narrow the list down with a word under cursor
nnoremap <leader>fU :execute 'CtrlPFunky '.expand('<cword>')<cr>

" Auto-pairs : brackets in pair
Plug 'jiangmiao/auto-pairs'

" Deoplete : completion framework
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup=1
" Rust support
Plug 'sebastianmarkow/deoplete-rust'
let g:deoplete#sources#rust#racer_binary='/home/doune/.cargo/bin/racer'
let g:deoplete#sources#rust#rust_source_path='/home/doune/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'
" Supertab : completion using tab
Plug 'ervandew/supertab'
let g:SuperTabClosePreviewOnPopupClose=1

" Neomake : linter
Plug 'neomake/neomake'

call plug#end()

call neomake#configure#automake('rw')

" neomake signs
let g:neomake_error_sign = {
    \ 'text': '',
    \ 'texthl': 'NeomakeError',
    \ }
let g:neomake_warning_sign = {
    \   'text': '',
    \   'texthl': 'NeomakeWarning',
    \ }
let g:neomake_message_sign = {
     \   'text': '',
     \   'texthl': 'NeomakeMessage',                                                                                                
     \ }
let g:neomake_info_sign = {
     \ 'text': 'ℹ',
     \ 'texthl': 'NeomakeInfo'
     \ }

" neomake colors
highlight NeomakeError cterm=bold ctermfg=darkred
hi NeomakeVirtualtextError cterm=bold ctermfg=darkred
hi NeomakeWarning cterm=bold ctermfg=white
hi NeomakeVirtualtextWarning cterm=bold ctermfg=white
hi clear SignColumn
" deoplete colors
hi Pmenu ctermfg=black ctermbg=darkcyan
hi PmenuSel ctermfg=black ctermbg=cyan
" errors color
hi ErrorMsg ctermfg=darkred ctermbg=black
hi Error ctermfg=darkred ctermbg=black
" cursorline
hi CursorLine cterm=none ctermbg=0
