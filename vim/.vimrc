" Basic Vim configuration for PyQuant Platform

" Enable syntax highlighting
syntax on

" Show line numbers
set number

" Use spaces instead of tabs
set expandtab
set shiftwidth=2
set tabstop=2

" Enable mouse support (works on Linux/Mac and Windows gVim/Neovim)
set mouse=a

" Enable line wrapping
set wrap

" Clipboard support (Linux/Mac; Windows Git Bash may need 'win32yank')
if has("clipboard")
    set clipboard=unnamedplus
endif