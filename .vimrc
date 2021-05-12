call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rails'
Plug 'vim-airline/vim-airline'
Plug 'fatih/vim-go'
Plug 'vim-ruby/vim-ruby'
Plug 'scrooloose/nerdtree'
Plug 'ervandew/supertab'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mileszs/ack.vim'

call plug#end()

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

nmap , \
vmap , \

nmap <space> \
vmap <space> \

" Map tab key to next buffer
nmap <Tab> :bnext<CR>
nmap <S-Tab> :bprev<CR>
nmap <C-K> :bnext<CR>
nmap <C-J> :bprev<CR>

"map = and -  to end and beginning of line. More intuitive and easy on the fingers
nnoremap = $
nnoremap - 0

" Map l key to right pane and h key to left pane
map <C-L> <C-w>w
map <C-H> <C-w>p

" Remember cursor position when re-opening a file
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \ exe "normal! g`\"" |
  \ endif

" Set folding to leader-L
" zr to unfold and zm to fold. zR to unfold all and zM to fold all 
nmap <Leader>l :set foldmethod=syntax<CR>

" Remap jj to escape insert mode
inoremap jj <ESC>

" Map leader-S to save file 
nmap <Leader>s :w<CR>

" Map leader-q to quit vim
nmap <Leader>q :qa!<CR>

" vim-airline
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
" Show buffer number in status bar
let g:airline#extensions#tabline#buffer_nr_show = 1

" Ack
nnoremap <Leader>a :Ack!<space>

" Search and replace current word
nnoremap <Leader>r :%s/\<<C-r><C-w>\>/

" Remap leader-d to delete buffer
nmap <Leader>d :bd

" Remap gc comments to leader-c
nmap <Leader>c gcc
vmap <Leader>c gc

" Remove excess whitespace
set listchars=tab:»·,trail:·,extends:>,precedes:<
nmap <silent> <leader>w :set nolist!<CR>

function! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e " end of lines
  %s/\n\{3,}/\r\r/e " multiple blank lines
  silent! %s/\($\n\s*\)\+\%$// " end of file
  call cursor(l, c)
endfun

autocmd FileType Dockerfile,make,c,coffee,cpp,css,eruby,eelixir,elixir,html,java,javascript,json,
 \ markdown,php,puppet,python,ruby,scss,sh,sql,text,typescript,vim,yaml
 \ autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
