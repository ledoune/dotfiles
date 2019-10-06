set nocompatible
filetype plugin on
filetype indent on

" encoding	
set encoding=utf-8

" always on status bar
set laststatus=2

" 256 colors term
set t_Co=256

" allows buffer switching without save
set hidden
" ctype indent
set cindent shiftwidth=4
" always show line numbers
set number
" highlight column
set colorcolumn=110

" autoread if file modified while opened
set autoread

" backups
set backup
" persistent undo
if has('persistent_undo')
	set undofile
	set undolevels=1000
	set undoreload=10000
endif

" splits positions
set splitright
set splitbelow

" adjust viewports
map <leader>= <C-w>=

" map <leader>ff to display all lines with keyword under cursor
" and ask which one to jump to
nmap <leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<cr>

" highlight current line
set cursorline

" no line wrapping
set nowrap

" leader key
let mapleader = ','
let g:mapleader = ','

" fast saving
nmap <leader>w : :w!<cr>

" :W sudo saves
command W w !sudo tee % > /dev/null

" always 7 lines under/above the cursor
set so=7

" cmd completion
set wildmenu

set wildignore=*.o,*~,*/.git/*

" cmd height
set cmdheight=2

" search
set ignorecase
set smartcase
set hlsearch
set incsearch

" changes the special characters that can be used in search patterns
set magic

" tab
set expandtab "spaces instead of spaces
set softtabstop=4
set smarttab
set shiftwidth=4
set tabstop=4

" linebreak at 500 chars
set lbr
set tw=500

" disable highlight with <leader>cr
map <silent> <leader><cr> :noh<cr>

" close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" close all the buffers
map <leader>ba :bufdo bd<cr>

" move between buffers
map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext

" let 'tl' toggle between current and last accessed tab
let g:leasttab = 1
nmap <leader>tl :exe "tabn ".g:leasttab<cr>
au TabLeave * let g:lasttab = tabpagenr()

" open a new tab with the current buffer's path
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" switch cwd to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" specify the behavior when switching between buffers
try
	set switchbuf=useopen,usetab,newtab
	set stal=2
catch
endtry

" return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line ("'\"") <= line("$") | exe "normal! g'\"" | endif

" remap 0 to first non blank character
map 0 ^

" move a line of text using ALT+[ui]
nmap <M-u> mz:m+<cr> `z
nmap <M-i> mz:m-2<cr> `z
vmap <M-u> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-u> :m'<-2<cr>`>my`<mzgv`yo`z

" initialise directories

function! InitializeDirectories()
	let parent = $HOME
	let prefix = 'nvim'
	let dir_list = {
		\ 'backup': 'backupdir',
		\ 'views': 'viewdir',
		\ 'swap': 'directory' }
	
	if has('persistent_undo')
		let dir_list['undo'] = 'undodir'
	endif

	let common_dir = parent . '/.' . prefix

	for [dirname, settingname] in items(dir_list)
		let directory = common_dir . dirname . '/'
		if exists("*mkdir")
			if !isdirectory(directory)
				call mkdir(directory)
			endif
		endif
		if !isdirectory(directory)
			echo "Warning: Unable to create backup directory: " . directory
			echo "Try: mkdir -p " . directory
		else
			let directory = substitute(directory, " ", "\\\\ ", "g")
			exec "set " . settingname . "=" . directory
		endif
	endfor
endfunction
call InitializeDirectories()
