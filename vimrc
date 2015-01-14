set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'bling/vim-airline'

call vundle#end()

filetype plugin indent on
syntax enable

set t_Co=256
set background=dark
let g:solarized_termcolors=16
colorscheme solarized

" Enable use of powerline-specific fonts and fancy symbols
let g:airline_powerline_fonts = 1

set laststatus=2
set encoding=utf-8

set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

set wildmenu
let mapleader=","

" Make backspace behave like you would expect
set backspace=indent,eol,start

set number

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

au FileType ruby,yaml,cucumber,coffee setlocal sts=2 ts=2 sw=2
au FileType php setlocal fileformats+=dos
au FileType html set noendofline binary sts=2 ts=2 sw=2 et ai
au FileType eruby set noendofline binary sts=2 ts=2 sw=2 et ai
au FileType sass set noendofline binary sts=4 ts=4 sw=4 et ai

set list
set listchars=tab:▸\ ,eol:¬

" Forget about those arrow keys
map <Left>  <Nop>
map <Right> <Nop>
map <Up>    <Nop>
map <Down>  <Nop>

" Color column as gentle reminder
if exists('+colorcolumn')
    set colorcolumn=80
endif

let g:vroom_use_vimux = 1

:au InsertEnter * :set nu
:au InsertLeave * :set rnu

:set cul

map <Leader>rl :RunLastVimTmuxCommand

" Rename the current file, credit goes to Gary Bernhardt
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>
