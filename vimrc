" Si's .vimrc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This must be first, because it changes other options as side effect
set nocompatible

" Use pathogen to manage plugins under ~/.vim/bundle
call pathogen#infect()
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Change the mapleader from \ to ,
let mapleader=","

" Enable filetype plugins
filetype plugin indent on

" Set to auto read when a file is changed from the outside
" set autoread

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" (Slightly) quicker saving of files
nmap <leader>w :w!<CR>

" Sudo write (if we forget to sudo vim)
cnoreabbrev w!! w !sudo tee % >/dev/null

" Use ctags
let g:tagbar_ctags_bin='/usr/bin/ctags'
let g:tagbar_width=30
set tags=tags;/

" Work file types
au BufRead,BufNewFile *xensource.log* set filetype=messages
au BufRead,BufNewFile *isl_trace.log* set filetype=messages
au BufRead,BufNewFile *SMlog* set filetype=messages
au BufRead,BufNewFile *messages* set filetype=messages
"
" UI
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set guifont=Monospace\ 9

set mouse=a         " use the mouse in terminal mode

set go-=T           " no toolbar in gvim
set scrolloff=4     " lines of context when scrolling

set wildmode=longest,list     " bash-style file completion
set wildignore=*.o,*~,*.pyc   " Ignore compiled files

set ruler           " Show current position
set number          " always show line numbers
set cursorline      " highlight the current line

set cmdheight=2     " Height of the command bar

set hidden          " Handle hidden buffers

set showmatch       " show matching parenthesis
set matchtime=2     " show for 2 tenths of a second

set ignorecase      " ignore case when searching...
set smartcase       " ...unless I use case to search
set hlsearch        " highlight search terms
set incsearch       " show search matches as you type

set splitbelow      " open new splits below
set splitright      " open new vsplits to the right

" use sensible regex
nnoremap / /\v
vnoremap / /\v

" Move between bracket pairs
nnoremap <tab> %
vnoremap <tab> %

set lazyredraw    " don't redraw during macros

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=

" Handle long lines
set wrap
set textwidth=79
set formatoptions=qrn1

" Show invisibles (in Textmate style)
set list
set listchars=tab:▸\ ,eol:¬

" I think Vim Powerline is classed as UI
let g:Powerline_symbols = 'fancy'
let g:Powerline_cache_enabled = 1
set laststatus=2

" Command-t preferences
let g:CommandTMatchWindowReverse=1

" NERDCommenter preferences
let g:NERDSpaceDelims=1
let g:NERDRemoveExtraSpaces=1

" Colours
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" I know I'm using gnome => force 256 colors
set t_Co=256
" Let's try to always have colours
if &t_Co >= 256 || has("gui_running")
   colorscheme mustang
endif
if &t_Co > 2 || has("gui_running")
   " switch syntax highlighting on, when the terminal has colors
   syntax on
endif


" Higlight long lines
"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/

" Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files
set backup                        " enable backups
set noswapfile                    " It's 2012, Vim.

" Text editing
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wrap          " wrap lines
set showbreak=↪\   " useful indication of wrapping

set expandtab     " use tabs instead of spaces
set smarttab      " insert tabs at start of line with shiftwidth, not tabstop
set tabstop=4     " a tab is four spaces
set shiftwidth=4  " number of spaces to use for autoindenting

set backspace=indent,eol,start
                  " allow backspacing over everything in insert mode

set autoindent    " always set autoindenting on
set smartindent   " for some auto-semantic-indenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'


" Stuff I've not tidied yet
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>cd :cd %:p:h<CR>:pwd<CR>
nnoremap <silent> <leader>/ :nohlsearch<CR>

nmap <silent> <leader>r :TagbarToggle<CR>
nmap <silent> <leader>o :NERDTreeToggle<CR>

" Use tabs like a 'normal' editor
"set switchbuf=usetab,newtab
"map <C-t>     :tabnew<CR>
"map <C-left>  :tabp<CR>
"map <C-right> :tabn<CR>
"map <A-}>     :tabn<CR>
"map <A-{>     :tabp<CR>

" Move between windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" System clipboard interaction
noremap <leader>y "+y
noremap <leader>p :set paste<CR>"+p<CR>:set nopaste<CR>
noremap <leader>P :set paste<CR>"+P<CR>:set nopaste<CR>
vnoremap <leader>y "+ygv

" Clean trailing whitespace
nnoremap <leader>w mz:%s/\s\+$//<cr>:let @/=''<cr>`z

" Quick access to the Ack plugin
nmap <leader>a :Ack 

" Useful to see what you've changed before saving
function! s:DiffWithSaved()
    let filetype=&ft
    diffthis
    vnew | r # | normal! 1Gdd
    diffthis
    exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()