" Basic

set nocompatible
set autoindent
set ruler
set number

syntax on
filetype indent plugin on

set shiftwidth=2
set softtabstop=2
set expandtab

set number
set ruler

" Cursor style settings
" 1 -> blinking block
" 2 -> solid block
" 3 -> blinking underscore
" 4 -> solid underscore
" 5 -> blinking vertical bar
" 6 -> solid vertical bar

let &t_SI.="\e[5 q" " SI = INSERT mode
let &t_SR.="\e[3 q" " SR = REPLACE mode
let &t_EI.="\e[1 q" " EI = NORMAL mode (ELSE)

" Reset cursor style on startup
autocmd VimEnter * :normal :startinsert :stopinsert

" Remaps
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv
