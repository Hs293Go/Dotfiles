runtime! bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

syntax on
set encoding=utf-8
set number
set noswapfile
set hlsearch
set ignorecase
set incsearch
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
set backspace=indent,eol,start

nnoremap ; :

"reload the .vimrc
nmap <silent> <leader>rv :source ~/.vimrc<CR>
"show spaces"
nmap <silent> <leader>s :set nolist!<CR>
"show line numbers"
nmap <silent> <leader>l :set nonu!<CR>
"wrap lines"
nmap <silent> <leader>w :set nowrap!<CR>
"hide hightlight of searches"
nmap <silent> // :nohlsearch<CR>

" Movements shortcuts {{{

" C-h/j/k/l to move between buffers
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
" Buffer switching/management, might as well use those keys for something useful
map <Right> :bnext<CR>
imap <Right> <ESC>:bnext<CR>
map <Left> :bprev<CR>
imap <Left> <ESC>:bprev<CR>
" Maximize only this window"
nmap <silent> <leader>m :only<CR>
"vertical split"
nmap <silent> <leader>v :bel :vne<CR>
"horizontal split"
nmap <silent> <leader>f :bel :new<CR>
"close viewport buffer"
nmap <silent> <leader>x :hid<CR>
" }}}

" Edit the .bashrc"
nmap <silent> <leader>eb :e ~/.bashrc<CR>
" Edit the .zshrc"
nmap <silent> <leader>ez :e ~/.zshrc<CR>
" Edit the .vimrc"
nmap <silent> <leader>ev :e ~/.vimrc<CR>
" Edit the .gitconfig"
nmap <silent> <leader>eg :e ~/.gitconfig<CR>
" Edit the .tmux.conf"
nmap <silent> <leader>et :e ~/.tmux.conf<CR>

filetype plugin indent on

au FileType python setlocal formatprg=autopep8\ -

highlight Pmenu ctermfg=15 ctermbg=0 guifg=#ffffff guibg=#000000
let &t_TI = ""
let &t_TE = ""

let g:airline_powerline_fonts = 1
let g:airline_theme='molokai'

let g:ycm_autoclose_preview_window_after_insertion = 1
