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
let mapleader = " "

" fast saving
nmap <leader>w :w!<cr>

" sudo save
command! W w !sudo tee % > /dev/null

" backup/swap files and persistent undo
set backupdir=$HOME/.nvim/tmp//,.
set directory=$HOME/.nvim/tmp//,.
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
set backspace=indent,eol,start

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
" don't change cwd
set viewoptions-=options
set sessionoptions-=options

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
" remove auto comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" eow characters
set iskeyword-=.
set iskeyword-=#
set iskeyword-=-
set iskeyword-=_

" # KEY BINDINGS #

" remap search to space
map <leader><leader> /

" disable highlight
map <silent> <leader><cr> :noh<cr>

" move between windows
map <C-h> <C-W>h
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l

" buffer navigation
map <leader>j :bnext<cr>
map <leader>k :bprevious<cr>

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

" map <leader>ff to display all lines with keyword under cursor and ask which one to jump to
nmap <leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" move a line of text using alt+[ui]
nmap <M-u> mz:m+<cr>`z
nmap <M-i> mz:m-2<cr>`z
vmap <M-u> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-u> :m'<-2<cr>`>my`<mzgv`yo`z

" toggle spell checking
map <leader>ss :setlocal spell!<cr>

" autocomplete of (, [, {, ', "
" inoremap $1 ()<esc>i
" inoremap $2 []<esc>i
" inoremap $3 {}<esc>i
" inoremap $4 {<esc>o}<esc>O
" inoremap $q ''<esc>i
" inoremap $e ""<esc>i
" done by autopair


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

" GitGutter : show git diff in the sign column
Plug 'airblade/vim-gitgutter'
nmap <leader>ht :GitGutterToggle<cr>
nmap <leader>hb :GitGutterBufferToggle<cr>
nmap <leader>hh <Plug>(GitGutterNextHunk)
nmap <leader>hH <Plug>(GitGutterPrevHunk)
nmap <leader>hc <Plug>(GitGutterStageHunk)
nmap <leader>hu <Plug>(GitGutterUndoHunk)
nmap <leader>hp :call OpenGGPreview()<cr>
let g:gitgutter_preview_win_floating=0
" auto close preview on cursor move
au! CursorMoved * call s:ClosePreview()
" faster refresh
set updatetime=100

" NerdTree : file explorer
Plug 'scrooloose/nerdtree'
map <c-n> :NERDTreeToggle<cr>
" auto open if no file specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" auto close if last buffer open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" NerdTree-git-plugin
Plug 'Xuyuanp/nerdtree-git-plugin'

" Script to close all buffer but the current one
Plug 'vim-scripts/BufOnly.vim'
nmap <leader>bo :BufOnly<cr>
" BBye : close buffers without messing with layout
Plug 'moll/vim-bbye'
nnoremap <leader>q :Bdelete<cr>
nnoremap <leader>bb :bufdo Bdelete<cr>
nnoremap <leader>ba :bufdo bd<cr>
nnoremap <leader>be :BufOnlyLayout<cr>

" NERD Commenter : easy comments
Plug 'scrooloose/nerdcommenter'
let g:NERDSpaceDelims=1
let g:NERDCompactSexyComs=1
let g:NERDCommentEmptyLines=1
let g:NERDTrimTrailingWhiteSpace=1

" Tabular : easy code align
Plug 'godlygeek/tabular'
nmap <leader>a= :Tabularize /=<cr>
vmap <leader>a= :Tabularize /=<cr>
nmap <leader>a: :Tabularize /:\zs<cr>
nmap <leader>a: :Tabularize /:\zs<cr>

" UndoTree : visual undo tree
Plug 'mbbill/undotree'
nnoremap <c-u> :UndotreeToggle<cr>
let g:undotree_WindowLayout=3
let g:undotree_SetFocusWhenToggle=1
let g:undotree_HighlightChangedText=0
let g:undotree_DiffAutoOpen=1

call plug#end()

call neomake#configure#automake('rw')


" # COLORS AND SIGNS #

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
hi NeomakeWarning cterm=bold ctermfg=7
hi NeomakeVirtualtextWarning cterm=bold ctermfg=7
hi clear SignColumn
" deoplete colors
hi Pmenu ctermfg=black ctermbg=darkcyan
hi PmenuSel ctermfg=black ctermbg=cyan
" errors color
hi ErrorMsg ctermfg=darkred ctermbg=black
hi Error ctermfg=darkred ctermbg=black
" cursorline
hi CursorLine cterm=none ctermbg=0
" gitgutter colors
hi GitGutterAdd ctermfg=darkgreen
hi GitGutterChange ctermfg=7
hi GitGutterDelete ctermfg=darkred
hi diffAdded ctermfg=darkgreen
hi diffChanged ctermfg=7
hi diffRemoved ctermfg=darkred


" # FUNCTIONS #

" close preview if open
function! s:ClosePreview()
    if exists('b:gg_close_preview') && b:gg_close_preview
        let preview=0
        for bufnum in tabpagebuflist()
            if getwinvar(bufwinnr(bufnum), '&previewwindow')
                let preview=1
                break
            endif
        endfor
        if preview
            pc
        endif
    endif
    silent! unlet b:gg_close_preview
endfunction

" opens gitgutter preview window and makes it close on cursor move
function! OpenGGPreview()
    let b:gg_close_preview=1
    exec 'GitGutterPreviewHunk'
endfunction

" deletes all buffer except the current one, without messing with layout
function! BufOnlyLayout(bang, buffer)
    if a:buffer == ""
        let buffer = bufnr('%')
    elseif (a:buffer + 0) > 0
        let buffer = bufnr(a:buffer + 0)
    else
        let buffer = bufnr(a:buffer)
    endif

    if buffer == -1
        echohl ErrorMsg
        echomsg "No matching buffer for" a:buffer
        echohl None
        return
    endif

    let last_buffer = bufnr('$')
    let n = 1
    let warn_modified = 0

    while n <= last_buffer
        if n != buffer && buflisted(n)
            if getbufvar(n, "&modified") && empty(a:bang)
                let warn_modified = 1
            else
                exec "Bdelete".a:bang. " ".n
            endif
        endif
        let n = n + 1
    endwhile

    if warn_modified
        echohl ErrorMsg
        echomsg "E89: No write since last change for some buffers (add ! to override)"
        echohl None
    endif
endfunction

" command with 0 or 1 arguments, using buffer names for completion, and can take a bang modifier
command! -nargs=? -complete=buffer -bang BufOnlyLayout
            \ :call BufOnlyLayout('<bang>','<args>')
