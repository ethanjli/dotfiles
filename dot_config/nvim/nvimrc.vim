" Neovim-specific settings

" Command line
set noshowmode              " show mode in status line instead

" Graphics
colorscheme onedark

" Folding
set foldmethod=expr
set foldexpr=nvimtreesitter#foldexpr()
set nofoldenable            " disable folding at startup
