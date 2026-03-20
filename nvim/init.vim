set nocompatible
filetype plugin indent on
syntax on

set encoding=utf-8
set termguicolors
set number
set nowrap
set gdefault
set incsearch
set nohlsearch
set mouse=a
set clipboard=unnamedplus
set hidden
set splitright
set splitbelow
set cursorline
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

let mapleader = ","

autocmd FileType html,htmldjango setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
autocmd FileType vue,javascript,typescript setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab

inoremap jj <Esc>
inoremap jk <Esc>
inoremap <Esc> <Nop>
inoremap <S-Tab> <Esc>o
inoremap <S-CR> <Esc>o
inoremap <C-o> <Esc>o
inoremap {<CR> {<CR>}<C-o>O

nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader><Tab> :b#<CR>
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <leader>x :bd<CR>
nnoremap <leader>i gg=G``
nnoremap <leader>dtw :%s/\s\+$//e<CR>
nnoremap <Space> za
