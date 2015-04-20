filetype off
call pathogen#infect()
call pathogen#helptags()

syntax on
set backspace=2
set number
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set showmatch
set mouse=a

filetype on
filetype plugin indent on

if $COLORTERM == 'gnome-terminal'
 	set t_Co=16
endif
"color molokai
set background=dark
set colorcolumn=80

if filereadable(expand("~/.vim/bundle/vim-colors-solarized/colors/solarized.vim"))
let g:Solarized_termcolors=16
let g:Solarized_termtrans=1
let g:Solarized_contrast="normal"
let g:Solarized_visibility="normal"
color solarized             " Load a colorscheme
endif


