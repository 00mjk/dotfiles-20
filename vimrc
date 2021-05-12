set encoding=utf-8
scriptencoding utf-8

" --------------- "
" --- Plugins --- "
" --------------- "

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rails'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'vim-ruby/vim-ruby'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ervandew/supertab'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mileszs/ack.vim'
Plug 'tmux-plugins/vim-tmux'
Plug 'terryma/vim-multiple-cursors'
Plug 'ekalinin/Dockerfile.vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'elzr/vim-json'
Plug 'vim-syntastic/syntastic'

Plug 'majutsushi/tagbar'

call plug#end()

" ----------------------- "
" --- General options --- "
" ----------------------- "

set wildignore+=*.swp,*/tmp/
set noswapfile
set noundofile

" ------------------------------- "
" --- Leader key alternatives --- "
" ------------------------------- "

nmap , \
vmap , \

nmap <space> \
vmap <space> \

" -------------------------------------------------------- "
" --- Make shift-Y consistent with shift-C and shift-D --- "
" -------------------------------------------------------- "

" shift-C changes till the end of line, and shift-D deletes till the of the line.
" shift-Y breaks the pattern, and it's an alias for `yy'.
" This was initially in from vim-sensible but then removed.
nnoremap Y y$

" ---------------------- "
" --- Visual options --- "
" ---------------------- "

set number

set cursorline
set ignorecase
set showmatch

filetype plugin indent on " Automatically detect file types.
syntax on  " syntax highlighting

set noerrorbells visualbell t_vb=    " Disable all bells
set showcmd                          " show command that is being entered in the lower right
set backspace=indent,eol,start       " Allow extended backspace behaviour
set virtualedit=block                " allow placing the cursor after the last char

" --------------------- "
" --- Mouse support --- "
" --------------------- "

set mouse=a " enable mouse mode
if has("mouse_sgr")
	set ttymouse=sgr
else
	set ttymouse=xterm2
end

" ------------ "
" --- Tabs --- "
" ------------ "

" Use 2-space soft tabs by defaults
" (it's overriden for some some languages with different conventions).
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" ------------------------- "
" --- Buffer management --- "
" ------------------------- "

" Allow to open a different buffer in the same window of a modified buffer
set hidden

" position of the new split panes
set splitbelow
set splitright

" Remap leader-d to delete buffer
nmap <Leader>d :bd

" Cycle throuh buffers with tab / shift-tab
nmap <Tab> :bnext<CR>
nmap <S-Tab> :bprev<CR>
nmap <C-K> :bnext<CR>
nmap <C-J> :bprev<CR>

" ---------------- "
" --- Wrapping --- "
" ---------------- "

set autoindent  " Remember indent level after going to the next line.
set nowrap " Do not visually wrap lines by default.

if version > 704
  set breakindent " Align visually wrapped lines with the original indentation.
endif
set linebreak " Break between words when wrapping (don't break within words).
" toggle wrapping with leader-w
nmap <silent> <leader>w :set wrap!<CR>
" allow navigating 'visual lines' with j/k and up/down, instead of actual lines
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk

" ------------------------------------------------------------------- "
" --- Support vim options in individual files with magic comments --- "
" ------------------------------------------------------------------- "

set modeline

" --------------------------------------------------------- "
" --- Remember cursor position (when re-opening a file) --- "
" --------------------------------------------------------- "

autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \ exe "normal! g`\"" |
  \ endif

" --------------------- "
" --- Misc mappings --- "
" --------------------- "

" Set folding to leader-L
" zr to unfold and zm to fold. zR to unfold all and zM to fold all
nmap <Leader>l :set foldmethod=syntax<CR>

" Remap jj to escape insert mode
inoremap jj <ESC>

" Map leader-S to save file
nmap <Leader>s :w<CR>

" Map leader-q to quit vim
nmap <Leader>q :qa!<CR>

" ------------------------------ "
" --- Move lines up and down --- "
" ------------------------------ "

" Move lines up and down with Ctrl-arrowup/down and Ctrl-j/k (in normal, visual and insert mode)
" Note: only meant for small selections and small movements, will break moving
" multiple lines down beyond the bottom.
nnoremap <C-Down> :m .+1<CR>
nnoremap <C-Up> :m .-2<CR>
nnoremap <C-j> :m .+1<CR>
nnoremap <C-k> :m .-2<CR>
vnoremap <C-Down> :m '>+1<CR>gv
vnoremap <C-Up> :m '<-2<CR>gv
vnoremap <C-j> :m '>+1<CR>gv
vnoremap <C-k> :m '<-2<CR>gv
inoremap <C-Down> <ESC>:m .+1<CR>gi
inoremap <C-Up> <ESC>:m .-2<CR>gi
inoremap <C-j> <ESC>:m .+1<CR>gi
inoremap <C-k> <ESC>:m .-2<CR>gi

" -------------------------- "
" --- Search and replace --- "
" -------------------------- "

" ...current word
nnoremap <Leader>r :%s/\<<C-r><C-w>\>/

" ------------------ "
" --- Whitespace --- "
" ------------------ "

" --- Strip whitespace ---

set listchars=tab:»·,trail:·,extends:>,precedes:<
" toggle hidden characters highlighting:
nmap <silent> <Leader>h :set nolist!<CR>

function! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e " end of lines
  %s/\n\{3,}/\r\r/e " multiple blank lines
  silent! %s/\($\n\s*\)\+\%$// " end of file
  call cursor(l, c)
endfun

autocmd FileType Dockerfile,make,c,coffee,cpp,css,eruby,eelixir,elixir,html,java,javascript,json,markdown,php,puppet,python,ruby,scss,sh,sql,text,tmux,typescript,vim,yaml autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

" -------------------- "
" --- Omnicomplete --- "
" -------------------- "

" Allow the `enter' key to chose from the omnicompletion window, instead of <C-y>
" http://vim.wikia.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" --------------- "
" --- Pasting --- "
" --------------- "

set pastetoggle=<F3>

" --- Paste over visual selection preserving the content of the paste buffer
vnoremap <Leader>p pgvy`>
" p   -> paste normally
" gv  -> reselect the pasted text
" y   -> copy it again
" `>  -> jump to the last character of the visual selection (built-in mark)

" ---------------------------------------- "
" --- Fix arrow key combos inside tmux --- "
" ---------------------------------------- "

" this enables to use native and custom key combos inside tmux,
" as well as in standalone vim;
" relies on the term being correctly set inside tmux
if &term =~ '^screen'
  exec "set <xUp>=\e[1;*A"
  exec "set <xDown>=\e[1;*B"
  exec "set <xRight>=\e[1;*C"
  exec "set <xLeft>=\e[1;*D"
endif

" ------------------------------------------------ "
" --- Navigate within and between vim and tmux --- "
" ------------------------------------------------ "

" Also see the corresponding tmux configuration in these dotfiles.

function! TmuxWinCmd(direction)
  let wnr = winnr()
  " try to move...
  silent! execute 'wincmd ' . a:direction
  " ...and if does nothing it means that it was the last vim pane,
  " so we forward the command back to tmux
  if wnr == winnr()
    call system('tmux select-pane -' . tr(a:direction, 'phjkl', 'lLDUR'))
  end
endfunction

nmap <M-Down>   :call TmuxWinCmd('j')<CR>
nmap <M-Up>     :call TmuxWinCmd('k')<CR>
nmap <M-Left>   :call TmuxWinCmd('h')<CR>
nmap <M-Right>  :call TmuxWinCmd('l')<CR>

" ------------------- "
" --- vim-airline --- "
" ------------------- "

let g:airline_theme = 'base16_default' " Milder colorschemes (pending the creation of a 16-color colorscheme)
let g:airline#extensions#tabline#enabled = 1 " Enable the list of buffers
let g:airline#extensions#tabline#fnamemod = ':t' " Show just the filename
let g:airline#extensions#tabline#buffer_nr_show = 1 " Show buffer number in status bar
" Toggle the buffer/tab line with 'leader-t' (think of 'Toggle Tabs')
nnoremap <expr><silent> <Leader>t &showtabline ? ":set showtabline=0\<cr>" : ":set showtabline=2\<cr>"

" ----------- "
" --- Ack --- "
" ----------- "

if executable('ag')
  let g:ackprg = 'ag --vimgrep --hidden --follow --smart-case'.
        \' --ignore-dir=.git'.
        \' --ignore-dir=.hg'.
        \' --ignore-dir=.svn'.
        \' --ignore-dir=.bundle'.
        \' --ignore-dir=.bin'.
        \' --ignore-dir=vendor'.
        \' --ignore-dir=log'.
        \' --ignore-dir=node_modules'.
        \' --ignore=*.exe'.
        \' --ignore=*.so'.
        \' --ignore=*.class'.
        \' --ignore=*.dll'.
        \' --ignore=*.pyc'.
        \' --ignore=tags'
endif
" do no jump to the first result
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>

" ---------------- "
" --- NERDTree --- "
" ---------------- "

" Shortcut to open/close
map <Leader>n :NERDTreeToggle<CR>
" Highlight the current buffer (think of 'find')
map <Leader>f :NERDTreeFind<CR>

let NERDTreeMinimalUI=1
let NERDTreeShowHidden=1 " show hidden files at startup
let NERDTreeIgnore = ['\.pyc$', '\.class$'] " http://superuser.com/questions/184844/hide-certain-files-in-nerdtree
let NERDTreeAutoDeleteBuffer=1 " automatically replace/close the corresponding buffer when a file is moved/deleted

" ------------- "
" --- CtrlP --- "
" ------------- "

let g:ctrlp_show_hidden = 1
" open new file with <c-y> in the current window instead of v-split, to be
" consistent with the behaviour of the `:edit' command
let g:ctrlp_open_new_file = 'r'
" the max height for the results is still 10, but can be scrolled up if there
" are more
let g:ctrlp_match_window = 'results:100'
" when opening multiple files (selected with <c-z> and <c-o>)...
"   - open the first in the current window, and the rest as hidden
"     buffers (option 'r')
"   - set the maximum number of splits to use to '1' (which means only the
"     current one, no new splits will be created)
" unlike 'ij', this also works when the only buffer is the no-name buffer
let g:ctrlp_open_multiple_files = 'r1'

" only effective if `ag' not available
let g:ctrlp_custom_ignore = {
  \ 'dir': '\v[\/](\.git|\.hg|\.svn|\.bundle|bin|node_modules|log|vendor)$',
  \ 'file': '\v\.(exe|so|dll|class|pyc)$',
  \ }

" Use ag if available, because faster.
" Normally ag excludes directories like `git', but the `--hidden' option
" overrides that. We need therefore to explicitly specify the paths to be
" ignored.
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'.
        \' --ignore-dir=.git'.
        \' --ignore-dir=.hg'.
        \' --ignore-dir=.svn'.
        \' --ignore-dir=.bundle'.
        \' --ignore-dir=.bin'.
        \' --ignore-dir=vendor'.
        \' --ignore-dir=log'.
        \' --ignore-dir=node_modules'.
        \' --ignore=*.exe'.
        \' --ignore=*.so'.
        \' --ignore=*.class'.
        \' --ignore=*.dll'.
        \' --ignore=*.pyc'.
        \' --ignore=tags'
endif

" use ctrlp in a single shortcut to navigate buffers
noremap <Leader>b :CtrlPBuffer<CR>

" ---------------------- "
" --- vim-commentary --- "
" ---------------------- "

" Remap gc comments to leader-c
nmap <Leader>c gcc
vmap <Leader>c gc

" -------------- "
" --- vim-go --- "
" -------------- "

let g:go_fmt_command = "goimports"

let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_format_strings = 1
" specify it even if it's currently the default
let g:go_highlight_string_spellcheck = 1

" ----------------- "
" --- vim-RSpec --- "
" ----------------- "

" --- Syntax highlighting outside Rails ---

autocmd BufRead {*_spec.rb,spec_helper.rb} syn keyword rubyRspec
      \ after
      \ before
      \ class_double
      \ context
      \ describe
      \ described_class
      \ double
      \ expect
      \ include_context
      \ include_examples
      \ instance_double
      \ it
      \ it_behaves_like
      \ it_should_behave_like
      \ its
      \ let
      \ object_double
      \ raise_error
      \ setup
      \ shared_context
      \ shared_examples
      \ shared_examples_for
      \ specify
      \ subject
      \ xit

highlight def link rubyRspec Function

" ----------------- "
" --- Syntastic --- "
" ----------------- "

let g:syntastic_javascript_checkers=['eslint']

" ---------------- "
" --- vim-json --- "
" ---------------- "

let g:vim_json_syntax_conceal = 0
