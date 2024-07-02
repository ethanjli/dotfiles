" Graphics
if &term =~# '^xterm'
  set ttyfast               " improve redrawing smoothness
endif

" Buffer management
set hidden                  " allow switching buffers with unsaved changes

" Command line
set wildmode=longest,list   " get bash-like tab completions
"set noshowmode              " show mode in status line instead

" Search
set ignorecase              " case-insensitive search by default
set smartcase               " case-sensitive search when uppercase chars are in query
set hlsearch                " highlight search matches
set incsearch               " incremental search
" clear search results:
nnoremap <Esc> :nohlsearch<CR>

" Substitution
set inccommand=split

" Scrolling
set scrolloff=5             " show lines above and below current line at screen edges

" Line display
set number                  " show line numbers
set relativenumber          " show relative line number offsets
"set colorcolumn=80,100      " show common column width limits
set colorcolumn=100         " show common column width limits
set linebreak               " wrap long lines
set breakindent             " indent wrapped lines
set showbreak=↪\            " indicate wrapped lines

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
set smartindent             " automatically indent C-like programs
set shiftwidth=2            " width of indentations with smart tabs
set shiftround              " round indent to a multiple of shiftwidth
set softtabstop=2           " width of tabs without smart tabs, so <BS> treats indent spaces as tabs
set tabstop=2               " number of columns occupied by a tab
set expandtab               " converts tabs to white space
set list listchars=tab:▸\ ,trail:·,nbsp:␣  " display tabs and trailing spaces visually

" Mouse
set mouse=a                 " enable mouse click

" Motion
" split current line:
nnoremap K i<CR><Esc>
" move current line:
nnoremap <Up> :m-2<CR>==
nnoremap <Down> :m+<CR>==

" Splits
set splitright              " when splitting vertically, move focus to new pane
set splitbelow              " when splitting horizontally, move focus to new pane

" Undo
set undofile                " save undo history to file

" Lua bootstrapping
source $HOME/.config/nvim/init.lua.vim

" Graphics with nvim plugins
colorscheme onedark

" Folding with nvim plugins
set foldmethod=expr
set foldexpr=nvimtreesitter#foldexpr()
set nofoldenable            " disable folding at startup
