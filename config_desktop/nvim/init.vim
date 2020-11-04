" Doune's vimrc file
"
" TODO ORGANIZE

" Vim-Plug "{{{

" auto install
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin(expand('~/.config/nvim/plugged'))

Plug 'vim-airline/vim-airline'                      " airline status bar
Plug 'vim-airline/vim-airline-themes'               " airline status bar themes
Plug 'ctrlpvim/ctrlp.vim'                           " full path fuzzy finder
Plug 'tacahiroy/ctrlp-funky'                        " function navigator for languages without ctags configured
" Plug 'jiangmiao/auto-pairs'                       " auto brackets, quotes, etc matching
Plug 'Raimondi/delimitMate'                         " auto brackets, quotes, etc matching
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }     " completion engine - replaced by coc
" Plug 'sebastianmarkow/deoplete-rust'                              " completion for rust - replaced by coc
" Plug 'ervandew/supertab'                                          " completion using tab - replaced by coc
" Plug 'neomake/neomake'                                            " linter - replaced by coc
Plug 'neoclide/coc.nvim', { 'branch': 'release' }   " completion engine inspired by VSCode extensions
Plug 'airblade/vim-gitgutter'                       " shows git diff in the gutter
Plug 'scrooloose/nerdtree'                          " file explorer
Plug 'Xuyuanp/nerdtree-git-plugin'                  " git support for nerdtree
Plug 'vim-scripts/BufOnly.vim'                      " delete all buffers except the current one
Plug 'moll/vim-bbye'                                " delete buffers without messing the window and layout
Plug 'scrooloose/nerdcommenter'                     " commenting confort and shortcuts
Plug 'godlygeek/tabular'                            " automatic alignment
Plug 'mbbill/undotree'                              " visual undo tree
Plug 'vim-scripts/YankRing.vim'                     " copy paste history
Plug 'majutsushi/tagbar'                            " ctags
Plug 'lambdalisue/suda.vim'                         " edit files that need sudo rights
Plug 'cespare/vim-toml'                             " toml syntax highlighting

call plug#end()
"}}}

" General Config "{{{
set nocompatible                                    " not vi compatible
set encoding=utf-8                                  " text encoding
scriptencoding utf-8                                " text encoding
set history=500                                     " history length
set number                                          " always show line number
set relativenumber                                  " line numbers relative to cursor
" filetype plugin on                                " filetype plugins
" filetype indent on                                " filetype indents
syntax enable                                       " enable syntax highlighting
set autoread                                        " autoreload files when changed from outside
set backup                                          " backup files
set backupdir=$HOME/.nvim/tmp//,.                   " backup directory
set directory=$HOME/.nvim/tmp//,.                   " swap file directory
set undofile                                        " permanent undo
set undolevels=1000                                 " number of changes you can undo
set undoreload=10000                                " save the whole buffer on file reload
set so=9                                            " number of lines visible above/below the cursor
set wildmenu                                        " command completion
set wildmode=list:longest,full                      " completion priority
set wildignore=*.o,*~,*/.git/*                      " completion ignores
set signcolumn=yes                                  " always show signcolumn (needed for coc)
set ruler                                           " show cursor position
set cursorline                                      " highlight current line
set showmode                                        " show current mode
set cmdheight=2                                     " command bar height
set laststatus=2                                    " always show status bar
set hidden                                          " enable hidden buffer (needed for completion)
set backspace=indent,eol,start                      " backspace behavior
set whichwrap+=<,>,h,l                              " commands that wrap at end of line
set ignorecase                                      " ignore case when searching
set smartcase                                       " smart case searching behavior
set hlsearch                                        " highlight search results
set incsearch                                       " search as you type
set magic                                           " regex
set showmatch                                       " highlight matching brackets
set splitright                                      " vsplit position
set splitbelow                                      " hsplit position
set noerrorbells                                    " disable error sounds
set novisualbell                                    " disable visuel bell
set t_vb=                                           " terminal visual bell
set tm=500                                          " command completion timeout
set virtualedit=onemore                             " allows to move the cursor after end of line
set viewoptions-=options                            " don't auto change cwd
set sessionoptions-=options                         " don't auto change cwd
set expandtab smarttab                              " tab settings
set tabstop=4 shiftwidth=4                          " tab width
set autoindent smartindent                          " indentation behavior
set tw=500 lbr nowrap                               " no line wrap but line break after 500 characters
" set complete-=i                                   " vim completion sources
set shortmess+=c                                    " shorten messages
set iskeyword-=.                                    " end of word characters
set iskeyword-=#                                    " end of word characters
set iskeyword-=-                                    " end of word characters
" set iskeyword-=_                                    " end of word characters
set switchbuf=useopen,usetab,newtab                 " buffer behavior for quickfix commands
set foldmethod=marker                               " uses {{{ }}} for folds
set updatetime=300                                  " faster refresh
set mouse=a                                         " enable mouse usage
"}}}

" Normal Mappings "{{{
" reload all buffers
nnoremap <F5> :checktime<CR>
" remap 0 to first non blank character
nnoremap 0 ^
" indentation shift in visual mode
vnoremap < <gv
vnoremap > >gv
" move cursor to viewport
noremap <C-h> <C-W>h
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-l> <C-W>l
" move current line in normal or visual mode
nnoremap <M-u> mz:m+<cr>`z
nnoremap <M-i> mz:m-2<cr>`z
vnoremap <M-u> :m'>+<cr>`<my`>mzgv`yo`z
vnoremap <M-i> :m'<-2<cr>`>my`<mzgv`yo`z
" leader mappings
let mapleader = " "                                 " set leader mapping
" remap saving
nnoremap <leader>w :w!<cr>
" remap search
nnoremap <leader><leader> /
" disable highlight
nnoremap <silent> <leader><cr> :noh<cr>
" change buffer
nnoremap <leader>j :bnext<cr>
nnoremap <leader>k :bprevious<cr>
" tab pages
nnoremap <leader>tn :tabnew<cr>
nnoremap <leader>to :tabonly<cr>
nnoremap <leader>tc :tabclose<cr>
nnoremap <leader>tm :tabmove
nnoremap <leader>tl :exe "tabn ".g:lasttab<cr>
nnoremap <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/
" cwd
nnoremap <leader>cd :cd %:p:h<cr>:pwd<cr>
" merge conflict markers
nnoremap <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>
" change viewport sizes
noremap <leader>= <c-w>=
" toggle spell checking
nnoremap <leader>ss :setlocal spell!<cr>
" map <leader>ff to display all lines with keyword under cursor and ask which one to jump to
" nnoremap <leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>
" move a line of text using alt+[ui]
" autocomplete of (, [, {, ', "
" inoremap $1 ()<esc>i
" inoremap $2 []<esc>i
" inoremap $3 {}<esc>i
" inoremap $4 {<esc>o}<esc>O
" inoremap $q ''<esc>i
" inoremap $e ""<esc>i
" done by autopair/delimitMate
"}}}

" Plugins Mappings "{{{
" fuzzy function finder
nnoremap <leader>fu :CtrlPFunky<cr>
" fuzzy function finder with word under the cursor
nnoremap <leader>fU :execute 'CtrlPFunky '.expand('<cword>')<cr>

" CoC
" tab to trigger completion with character ahead and navigate.
inoremap <silent><expr> <tab>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr><s-tab> pumvisible() ? "\<C-p>" : "\<C-h>"
" navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostics-prev)
nmap <silent> ]g <Plug>(coc-diagnostics-next)
" goto code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<cr>
" renaming
nmap <leader>rn <Plug>(coc-rename)
" formating
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)
" code actions
" selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
" current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
" function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
" Remap <C-f> and <C-b> for scroll float windows/popups.
" Note coc#float#scroll works on neovim >= 0.4.3 or vim >= 8.2.0750
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#nvim_scroll(1, 1) : "\<C-f>"
vnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#nvim_scroll(0, 1) : "\<C-b>"
" Use CTRL-S for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)
" CoC lists
nnoremap <silent> <leader>d :<c-u>CocList diagnostics<cr>
nnoremap <silent> <leader>e :<c-u>CocList extensions<cr>
nnoremap <silent> <leader>c :<c-u>CocList commands<cr>
nnoremap <silent> <leader>o :<c-u>CocList outline<cr>
nnoremap <silent> <leader>s :<c-u>CocList -I symbols<cr>
" GitGutter : show git diff in the sign column
nnoremap <leader>ht :GitGutterToggle<cr>
nnoremap <leader>hb :GitGutterBufferToggle<cr>
nnoremap <leader>hh <Plug>(GitGutterNextHunk)
nnoremap <leader>hH <Plug>(GitGutterPrevHunk)
nnoremap <leader>hc <Plug>(GitGutterStageHunk)
nnoremap <leader>hu <Plug>(GitGutterUndoHunk)
nnoremap <leader>hp :call OpenGGPreview()<cr>
" NerdTree : file explorer
nnoremap <c-n> :NERDTreeToggle<cr>
" Script to close all buffer but the current one
nnoremap <leader>bo :BufOnly<cr>
" BBye : close buffers without messing with layout
nnoremap <leader>q :Bdelete<cr>
nnoremap <leader>bb :bufdo Bdelete<cr>
nnoremap <leader>ba :bufdo bd<cr>
nnoremap <leader>be :BufOnlyLayout<cr>
" Tabular : easy code align
nnoremap <leader>a= :Tabularize /=<cr>
vnoremap <leader>a= :Tabularize /=<cr>
nnoremap <leader>a: :Tabularize /:\zs<cr>
nnoremap <leader>a: :Tabularize /:\zs<cr>
" UndoTree : visual undo tree
nnoremap <c-u> :UndotreeToggle<cr>
" YankRing
nnoremap <c-y> :YRShow<cr>
" Tagbar
nnoremap <c-t> :TagbarToggle<cr>
"}}}

" Auto-commands "{{{

" restore state from last edit session
au BufWinLeave ?* mkview
au BufRead ?* silent loadview
" avoid this behavior for git commits
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0,1,1,0])
" remove auto comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" variable to keep track of last tab
let g:lasttab=1
au TabLeave * let g:lasttab=tabpagenr()
" highlight symbol and refs on cursor hold
autocmd CursorHold * silent call CocActionAsync('highlight')
" idk, was in the example coc config
augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
" jsonc comments highlighting
autocmd FileType json syntax match Comment +\/\/.\+$+
" auto close preview window on cursor move
au! CursorMoved * call s:ClosePreview()
" auto open NerdTree if no file specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" auto close if NerdTree is the last buffer open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" remove trailing whitespaces before saving
au BufWritePre * :%s/\s\+$//e
"}}}

" Plugins settings "{{{

" Airline : light status line
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled=1
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'
" CoC status line integration
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Deoplete : completion framework
" let g:deoplete#enable_at_startup=1
" Rust support
" let g:deoplete#sources#rust#racer_binary='/home/doune/.cargo/bin/racer'
" let g:deoplete#sources#rust#rust_source_path='/home/doune/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'

" Supertab : completion using tab
" let g:SuperTabClosePreviewOnPopupClose=1

" git gutter
let g:gitgutter_preview_win_floating=0

" NERD Commenter : easy comments
let g:NERDSpaceDelims=1
let g:NERDCompactSexyComs=1
let g:NERDCommentEmptyLines=1
let g:NERDTrimTrailingWhiteSpace=1

" undo tree
let g:undotree_WindowLayout=3
let g:undotree_SetFocusWhenToggle=1
let g:undotree_HighlightChangedText=0
let g:undotree_DiffAutoOpen=1

" YankRing : yank history
let g:yankring_min_element_length=2
let g:yankring_clipboard_monitor=0
let g:yankring_replace_n_pkey='<leader>p'
let g:yankring_replace_n_nkey='<leader>n'

" Tagbar : shows the structure on the current file in a split window
let g:tagbar_autofocus=1
let g:tagbar_type_rust = {
  \ 'ctagsbin' : '/usr/bin/ctags',
  \ 'ctagstype' : 'rust',
  \ 'kinds' : [
      \ 'n:modules',
      \ 's:structures:1',
      \ 'i:interfaces',
      \ 'c:implementations',
      \ 'f:functions:1',
      \ 'g:enumerations:1',
      \ 't:type aliases:1:0',
      \ 'v:constants:1:0',
      \ 'M:macros:1',
      \ 'm:fields:1:0',
      \ 'e:enum variants:1:0',
      \ 'P:methods:1',
  \ ],
  \ 'sro': '::',
  \ 'kind2scope' : {
      \ 'n': 'module',
      \ 's': 'struct',
      \ 'i': 'interface',
      \ 'c': 'implementation',
      \ 'f': 'function',
      \ 'g': 'enum',
      \ 't': 'typedef',
      \ 'v': 'variable',
      \ 'M': 'macro',
      \ 'm': 'field',
      \ 'e': 'enumerator',
      \ 'P': 'method',
  \ },
\ }

" sudo edit
let g:suda_smart_edit=1
"}}}

" Helper functions "{{{

" CoC
" for tab completion nagivation
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Documentation in preview window
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

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
"}}}

" Extras "{{{

" CoC commands
" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
"}}}

" Appearance "{{{

" neomake signs
" let g:neomake_error_sign = {
"     \ 'text': '',
"     \ 'texthl': 'NeomakeError',
"     \ }
" let g:neomake_warning_sign = {
"     \   'text': '',
"     \   'texthl': 'NeomakeWarning',
"     \ }
" let g:neomake_message_sign = {
"      \   'text': '',
"      \   'texthl': 'NeomakeMessage',
"      \ }
" let g:neomake_info_sign = {
"      \ 'text': 'ℹ',
"      \ 'texthl': 'NeomakeInfo'
"      \ }

" neomake colors
" highlight NeomakeError cterm=bold ctermfg=darkred
" hi NeomakeVirtualtextError cterm=bold ctermfg=darkred
" hi NeomakeWarning cterm=bold ctermfg=7
" hi NeomakeVirtualtextWarning cterm=bold ctermfg=7
hi clear SignColumn
" cursorline
hi clear CursorLineNr
hi CursorLine cterm=none ctermbg=0
" comments
hi Comment gui=italic cterm=italic
" folds
hi Folded ctermbg=none
" popups colors
hi Pmenu ctermfg=black ctermbg=darkcyan
hi PmenuSel ctermfg=black ctermbg=cyan
" errors color
hi ErrorMsg ctermfg=darkred ctermbg=black
hi Error ctermfg=darkred ctermbg=black
" gitgutter colors
hi GitGutterAdd ctermfg=darkgreen
hi GitGutterChange ctermfg=7
hi GitGutterDelete ctermfg=darkred
hi diffAdded ctermfg=darkgreen
hi diffChanged ctermfg=7
hi diffRemoved ctermfg=darkred
" tagbar highlight color for current tag
hi TagbarHighlight cterm=bold ctermfg=15 ctermbg=8
"}}}
