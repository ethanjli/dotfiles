" Graphics
if &term =~# '^xterm'
  set ttyfast               " improve redrawing smoothness
endif

" Buffer management
set hidden                  " allow switching buffers with unsaved changes

" Command line
set wildmode=longest,list   " get bash-like tab completions

" Search
set ignorecase              " case-insensitive search by default
set smartcase               " case-sensitive search when uppercase chars are in query
set hlsearch                " highlight search matches
set incsearch               " incremental search

" Scrolling
set scrolloff=5             " show lines above and below current line at screen edges

" Line display
set number                  " show line numbers
set relativenumber          " show relative line number offsets
"set colorcolumn=80,100      " show common column width limits
set colorcolumn=100      " show common column width limits

" Files
set encoding=utf-8

" Filetypes
filetype plugin on

" Chezmoi integration
autocmd BufWritePost ~/.local/share/chezmoi/* ! chezmoi apply --source-path "%"

" Syntax
syntax enable               " syntax highlighting
set showmatch               " show matching braces

" Indentation
filetype plugin indent on   " allow auto-indenting depending on file type
set shiftwidth=2            " width of indentations with smart tabs
set softtabstop=2           " width of tabs without smart tabs, so <BS> treats indent spaces as tabs
set tabstop=2               " number of columns occupied by a tab 
set expandtab               " converts tabs to white space
set list listchars=tab:▸\ ,trail:· " display tabs and trailing spaces visually

" Mouse
set mouse=a                 " enable mouse click

" Motion
nnoremap K i<CR><Esc>
nnoremap <Up> :m-2<CR>==
nnoremap <Down> :m+<CR>==
