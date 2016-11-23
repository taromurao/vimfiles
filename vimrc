set nocompatible      " We're running Vim, not Vi!

" vim: nowrap fdm=marker
"  ---------------------------------------------------------------------------
"  Plugins
"  ---------------------------------------------------------------------------

silent! runtime bundles.vim
runtime plugins/bclose.vim

"  ---------------------------------------------------------------------------
"  General
"  ---------------------------------------------------------------------------

filetype plugin indent on
let mapleader = ","
let g:mapleader = ","
set modelines=0
set history=10000
" This tells Vim to keep a backup copy of a file when overwriting it.  But not
" on the VMS system, since it keeps old versions of files already.
if has("vms")
  set nobackup
else
  set backup
endif
syntax enable
set autoread

"  ---------------------------------------------------------------------------
"  UI
"  ---------------------------------------------------------------------------

set title
set encoding=utf-8
set fencs=iso-2022-jp,euc-jp,cp932
set fileencodings=ucs-bom,utf8,prc
set scrolloff=3
set autoindent
set smartindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set number
set norelativenumber
set undofile

" Auto adjust window sizes when they become current
set winwidth=84
set winheight=5
set winminheight=5
set winheight=999

set splitbelow splitright

if has('mouse')
  set mouse=a
endif

"  ---------------------------------------------------------------------------
"  Text Formatting
"  ---------------------------------------------------------------------------

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

set nowrap
set textwidth=79
set formatoptions=n

" check to make sure vim has been compiled with colorcolumn support
" before enabling it
if exists("+colorcolumn")
  set colorcolumn=80
endif

"  ---------------------------------------------------------------------------
"  Mappings
"  ---------------------------------------------------------------------------

" Turn off arrow keys (this might not be a good idea for beginners, but it is
" the best way to ween yourself of arrow keys on to hjkl)
" http://yehudakatz.com/2010/07/29/everyone-who-tried-to-convince-me-to-use-vim-was-wrong/

nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>"
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Searching / moving
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch

" Center screen when scrolling search results
nmap n nzz
nmap N Nzz

" AG
nnoremap <leader>a :Ag
"
" Easy commenting
nnoremap // :TComment<CR>
vnoremap // :TComment<CR>

" Switch between buffers
noremap <tab> :bn<CR>
noremap <S-tab> :bp<CR>
" close buffer
nmap <leader>d :Bclose<CR>
" close all buffers
nmap <leader>D :bufdo bd<CR>

" Ignore some binary, versioning and backup files when auto-completing
set wildignore=.svn,CVS,.git,*.swp,*.jpg,*.png,*.gif,*.pdf,*.bak
" Set a lower priority for .old files
set suffixes+=.old

"  ---------------------------------------------------------------------------
"  Function Keys
"  ---------------------------------------------------------------------------

" Press F5 to toggle GUndo tree
nnoremap <F5> :GundoToggle<CR>

" indent file and return cursor and center cursor
map   <silent> <F6> mmgg=G`m^zz
imap  <silent> <F6> <Esc> mmgg=G`m^zz

"  ---------------------------------------------------------------------------
"  Plugins
"  ---------------------------------------------------------------------------

" eradicate all trailing whitespace all the time
let g:DeleteTrailingWhitespace = 1
let g:DeleteTrailingWhitespace_Action = 'delete'

" AutoClose
let g:AutoClosePairs = {'(': ')', '{': '}', '[': ']', '"': '"', "'": "'", '#{': '}'}
let g:AutoCloseProtectedRegions = ["Character"]

" CtrlP
nmap <leader>f :CtrlP<cr>

" Add settings for tabular
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

" Tabularize
if exists(":Tab")
  nmap <leader>a\| :Tab /\|<CR>
  vmap <leader>a\| :Tab /\|<CR>
  nmap <leader>a= :Tab /=<CR>
  vmap <leader>a= :Tab /=<CR>
  nmap <leader>a: :Tab /:\zs<CR>
  vmap <leader>a: :Tab /:\zs<CR>
endif

" Powerline
" set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim

" Airline
let g:airline_powerline_fonts = 1
let g:airline_theme = 'powerlineish'

" Enable spellchecking with English since it might avoid typos of also variable names of strings in code.
set spell spelllang=en
"  ---------------------------------------------------------------------------
"  Language Mappings
"  ---------------------------------------------------------------------------

" Other files to consider Ruby
au BufRead,BufNewFile Gemfile,Rakefile,Thorfile,config.ru,Vagrantfile,Guardfile,Capfile set ft=

" text
autocmd FileType text set wrap linebreak nolist

" Python
autocmd FileType python set sw=4 sts=4 et

" JavaScript
autocmd FileType javascript set sw=4 sts=4 et

" CoffeeScript
let coffee_compile_vert = 1
au BufNewFile,BufReadPost *.coffee setl foldmethod=indent

" SASS / SCSS
au BufNewFile,BufReadPost *.scss setl foldmethod=indent
au BufNewFile,BufReadPost *.sass setl foldmethod=indent
au BufRead,BufNewFile *.scss set filetype=scss

"  ---------------------------------------------------------------------------
"  Directories
"  ---------------------------------------------------------------------------

set backupdir=~/tmp,/tmp
set undodir=~/.vim/.tmp,~/tmp,~/.tmp,/tmp

" Ctags path (brew install ctags)
let Tlist_Ctags_Cmd = 'ctags'

" Make Vim use RVM correctly when using Zsh
" https://rvm.beginrescueend.com/integration/vim/
set shell=/bin/sh

" Finally, load custom configs
if filereadable($HOME . '.vimrc.local')
  source ~/.vimrc.local
endif

"  ---------------------------------------------------------------------------
"  GnomeTerminal
"  ---------------------------------------------------------------------------
"
if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

"  ---------------------------------------------------------------------------
"  Colors
"  ---------------------------------------------------------------------------
" let g:solarized_termcolors=256
set background=dark
colorscheme solarized

"  ---------------------------------------------------------------------------
"  Misc
"  ---------------------------------------------------------------------------

" When vimrc, either directly or via symlink, is edited, automatically reload it
autocmd! bufwritepost .vimrc source %
autocmd! bufwritepost vimrc source %

" Haskell mode
let g:haddock_browser = "open"
let g:haddock_browser_callformat = "%s %s"

" RSpec" gvim
set guioptions-=T
set guioptions-=m
set guioptions-=r
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>

" gvim
set guioptions-=T
set guioptions-=m
set guioptions-=r

" Create a new line, but do not enter the insert mode
" Press Enter to create a new line below the current line
" Press Shift+Enter to create a line above.
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>
