set mouse=a

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-fugitive'
call plug#end()


command! Gstatus call LazyLoadFugitive('Gstatus')
command! Gdiff call LazyLoadFugitive('Gdiff')
command! Glog call LazyLoadFugitive('Glog')
command! Gblame call LazyLoadFugitive('Gblame')

function! LazyLoadFugitive(cmd)
  call plug#load('vim-fugitive')
  call fugitive#detect(expand('%:p'))
  exe a:cmd
endfunction




hi Search cterm=NONE ctermfg=black ctermbg=yellow
set hlsearch
filetype plugin indent on
syntax on


set number                                                  "show line numbers
set relativenumber

set showcmd
set guicursor=a:blinkon500-blinkwait500-blinkoff500
set cursorline

set smartcase
set ignorecase
set hidden
set history=500

set fileencoding=utf-8
" ============== Turn off swap files ====================================== {{{

set noswapfile
set nobackup
set nowritebackup

" }}}
" ============== Identation =============================================== {{{
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab   "spaces instead of tabs
set breakindent
set smartindent
set nofoldenable
"set colorcolumn=80
set foldmethod=syntax
" }}}

autocmd BufWritePre * :%s/\s\+$//e

set nostartofline
" highlight matching bracket
set showmatch

set wrap
set linebreak
set showbreak=+++

set undolevels=1000

set listchars=tab:\ \ ,trail:·
set list

let g:mapleader = ','

set path+=**
set undofile

" Map for Escape key
inoremap jj <Esc>
tnoremap <LEADER>jj <C-\><C-n>

" Yank to the end of the line
nnoremap Y y$

" Copy to system clipboard
noremap <C-c> "+y

" Copies using system clipboard
set clipboard+=unnamedplus

" Move selected lines up and down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Clear search highlight but how???
nnoremap <silent><Leader><space> :noh<CR>


nnoremap <leader><tab> <c-^>

nnoremap <silent><leader>f :call Search()<CR>
nnoremap <silent><leader>F :call Search(v:true)<CR>


set backspace=indent,eol,start


let $NVIM_TUI_ENABLE_TRUE_COLOR=1

set autoread


" TODO not working
" :W sudo saves the file
" (useful for handling the permission-denied error)
"command W w !sudo tee % > /dev/null
command W :w suda://%
"command W :execute ':silent w !sudo tee % > /dev/null' | :edit!


set magic

set t_Co=256



" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext



" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()



" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/


" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
