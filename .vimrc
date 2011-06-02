" Colorscheme theme
colorscheme robokai
set gfn=Droid\ Sans\ Mono:h13

" Enable filetypes
filetype on
filetype plugin on
filetype indent on
syntax on

" Escape out of insert mode when jj is pressed
imap jj <Esc>

" Buffer mappings, buffer delete, buffer previous
map ,bd :bd<CR>
map ,bn :bn<CR>
map ,bp :bp<CR>
map ,bl :ls<CR>

"BufExplorer mappings
map ,be :BufExplorer<CR>

" Window key mappings
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l

" File browser settings
map <F2> :NERDTreeToggle<CR>
map <F3> :e .<CR>:set number<CR>

" Full screen
map <C-f> :set invfullscreen<CR>

" Indenting stuff
set autoindent
set smartindent
set showmatch

" Display current cursor position in lower right corner.
set ruler

" Show lines numbers
set number

" Switch between buffers without saving
set hidden

" Tab stuff
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Show command in bottom right portion of the screen
set showcmd

" Change the current directory to that of the file in the buffer
autocmd BufEnter * cd %:p:h

" Set incremental searching"
set incsearch

" Highlighting searching
set hlsearch

" Set the search scan so that it ignores case when the search is all lower
" Case but recognizes uppercase if it's specified
set ignorecase
set smartcase

" Hide MacVim toolbar by default
set go-=T

" Split windows below the current window
set splitbelow

" More useful command-line completion
set wildmenu

" Auto-completion menu
set wildmode=list:longest

"""" Custom configuration for Symfony 2 """"
" Extra configuration to view *.twig files
au BufRead,BufNewFile *.twig set syntax=htmljinja
