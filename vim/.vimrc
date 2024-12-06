" Don't try to be vi compatible
set nocompatible

" Helps force plugins to load correctly when it is turned back on below
filetype off

" Turn on syntax highlighting
syntax on

" For plugins to load correctly
filetype plugin indent on

" Space is the leader key
let mapleader = " "


" show line numbers
set number
set ruler

set nowrap

set t_Co=256
set ttyfast
set hidden
set laststatus=2

" key maps
" -------------------------------------------------------------------------------------
" move vertically by visual line
nnoremap j gj
nnoremap k gk

" copy to system clipboard
nnoremap <leader>y "+ygv"*y
vnoremap <leader>y "+ygv"*y

nnoremap <leader>y "+Ygv"*Y
vnoremap <leader>y "+Ygv"*Y

" paste from system clipboard
nnoremap <leader>p "+p
vnoremap <leader>p "+p

nnoremap <leader>P "+P
vnoremap <leader>P "+P

" better indenting
vnoremap < <gv
vnoremap > >gv
