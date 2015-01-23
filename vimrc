set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'bling/vim-airline'
Plugin 'chriskempson/vim-tomorrow-theme'
Plugin 'junegunn/vim-easy-align'
Plugin 'kien/ctrlp.vim'
Plugin 'mileszs/ack.vim'
Plugin 'tacahiroy/ctrlp-funky'
Plugin 'thoughtbot/vim-rspec'
Plugin 'tpope/vim-fugitive'

call vundle#end()

filetype plugin indent on
syntax enable

set t_Co=256
set background=dark
let g:solarized_termcolors=16
colorscheme Tomorrow-Night

set clipboard=unnamed " use OS clipboard

" Configure netrw to behave nicely
let g:netrw_liststyle=3
let g:netrw_banner=0
let g:netrw_altv=1
let g:netrw_preview=1

" http://ivanbrennan.nyc/blog/2014/01/16/rigging-vims-netrw/
fun! VexToggle(dir)
  if exists("t:vex_buf_nr")
     call VexClose()
  else
    call VexOpen(a:dir)
  endif
endf

fun! VexOpen(dir)
  let g:netrw_browse_split=4
  let vex_width = 25

  execute "Vexplore " . a:dir
  let t:vex_buf_nr = bufnr("%")
  wincmd H

  call VexSize(vex_width)
endf

fun! VexClose()
  let cur_win_nr = winnr()
  let target_nr = ( cur_win_nr == 1 ? winnr("#") : cur_win_nr )

  1wincmd w
  close
  unlet t:vex_buf_nr

  execute (target_nr - 1) . "wincmd w"
  call NormalizeWidths()
endf

fun! VexSize(width)
  execute "vertical resize" . a:width
  set winfixwidth
  call NormalizeWidths()
endf

fun! NormalizeWidths()
  let eadir_pref = &eadirection
  set eadirection=hor
  set equalalways! equalalways!
  let &eadirection = eadir_pref
endf

noremap <Leader><Tab> :call VexToggle(getcwd())<cr>
noremap <Leader>` :call VexToggle("")<cr>

" Enable use of powerline-specific fonts and fancy symbols
let g:airline_powerline_fonts = 1

"
let g:ctrlp_working_path_mode = 'ra'

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

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

let g:rspec_runner = "os_x_iterm"

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
