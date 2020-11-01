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
Plug 'posva/vim-vue'
Plug 'majutsushi/tagbar'
Plug 'udalov/kotlin-vim'
Plug 'godlygeek/tabular'
Plug 'kchmck/vim-coffee-script'
Plug 'udalov/kotlin-vim'
Plug 'SirVer/ultisnips'

Plug 'altercation/vim-colors-solarized'

" Experimental
" Plug 'dhruvasagar/vim-table-mode'

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

" They preserve the native leader key.

nmap , \
vmap , \

nmap <space> \
vmap <space> \

" -------------------------------------------------------- "
" --- Make shift-Y consistent with shift-C and shift-D --- "
" -------------------------------------------------------- "

" shift-C changes till the end of line, and shift-D deletes till the of the line.
" shift-Y breaks the pattern, and it's an alias for `yy'.
" This was initially in vim-sensible but then removed.
nnoremap Y y$

" ---------------------- "
" --- Visual options --- "
" ---------------------- "

set number " show line numbers

set cursorline
set showmatch " highlight matching parentheses
set matchtime=0 " ...but stay out of the way (do not jump around)

filetype plugin indent on " automatically detect file types.
syntax on  " syntax highlighting

set noerrorbells visualbell t_vb= " disable all bells
set showcmd                       " show command that is being entered in the lower right
set backspace=indent,eol,start    " allow extended backspace behaviour
set virtualedit=block             " allow placing the cursor after the last char

if exists('+colorcolumn')
  set colorcolumn=81,101 " display vertical rulers for line length
endif

" ---------------------- "
" --- Search options --- "
" ---------------------- "

set ignorecase  " ignore case when searching...
set smartcase   " ...unless one upper case letter is present in the word
set gdefault    " replace all the occurences in the line by default
set incsearch   " start searching without pressing enter
set hlsearch    " highlight results
hi Search term=reverse cterm=reverse ctermbg=8 ctermfg=3

" search and replace current word
nnoremap <Leader>r :%s/\<<C-r><C-w>\>/

" ----------------------------------- "
" --- Search for visual selection --- "
" ----------------------------------- "

" http://vim.wikia.com/wiki/Search_for_visually_selected_text
" http://vim.wikia.com/wiki/VimTip171
" http://got-ravings.blogspot.com/2008/07/vim-pr0n-visual-search-mappings.html
" https://github.com/nelstrom/vim-visual-star-search
" http://vimcasts.org/episodes/search-for-the-selected-text/
" Search for selected text, forwards or backwards. It is case insensitive, and
" any whitespace is matched ('hello\nworld' matches 'hello world')

" makes * and # work on visual mode too.
function! s:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

" ------------------------------ "
" --- Visual selection utils --- "
" ------------------------------ "
"
" Based on
" * https://github.com/bryankennedy/vimrc/blob/master/vimrc
" * http://stackoverflow.com/questions/676600/vim-replace-selected-text/677918#677918
" * http://peterodding.com/code/vim/profile/autoload/xolox/escape.vim

" Escape special characters in a string for exact matching.
" This is useful to copying strings from the file to the search tool
function! VimEscape(string)
  let string=a:string
  " Escape regex characters
  let string = escape(string, '^$.*\/~[]')
  " Escape the line endings
  let string = substitute(string, '\n', '\\n', 'g')
  return string
endfunction

" Return the visually selected text without altering the unnamed register.
function! GetVisual() range
  " Save the current register and clipboard
  let reg_save = getreg('"')
  let regtype_save = getregtype('"')
  let cb_save = &clipboard
  set clipboard&

  " Put the current visual selection in the " register
  normal! ""gvy
  let selection = getreg('"')

  " Put the saved registers and clipboards back
  call setreg('"', reg_save, regtype_save)
  let &clipboard = cb_save

  return selection
endfunction

function! GetVimEscapedVisual() range
  return VimEscape(GetVisual())
endfunction

function! ShellEscape(str)
  let str=a:str
  return shellescape(fnameescape(str))
endfunction

function! GetShellEscapedVisual() range
  return ShellEscape(GetVisual())
endfunction

" ------------------------------------------- "
" --- Search and replace visual selection --- "
" ------------------------------------------- "

" Start the find and replace command across the entire file
vnoremap <Leader>r <Esc>:%s/<c-r>=GetVimEscapedVisual()<cr>//c<Left><Left>

" --------------------- "
" --- Mouse support --- "
" --------------------- "

if !has('nvim')
  set mouse=a " enable mouse mode
  if has("mouse_sgr")
    set ttymouse=sgr
  else
    set ttymouse=xterm2
  end
end

" -------------------------- "
" --- Tabs (indentation) --- "
" -------------------------- "

" Use 2-space soft tabs by defaults
" (it's overriden for some some languages with different conventions).
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" --------------------------- "
" --- Indenting shortcuts --- "
" --------------------------- "

" Indent/Unindent visually selected lines without losing the selection.
vnoremap > >gv
vnoremap < <gv
" Indent single lines with a single keystroke. The ability to specify a motion
" is lost, but this caters for the more common use case, indent until the
" desired level is obtained.
nnoremap > >>
nnoremap < <<

" ------------------------- "
" --- Buffer management --- "
" ------------------------- "

" Reuse buffers: if a buffer is already open in another window, jump to it
" instead of opening a new window.
set switchbuf=useopen

" Allow to open a different buffer in the same window of a modified buffer
set hidden

" position of the new split panes
set splitbelow
set splitright

" Cycle throuh buffers with tab / shift-tab
nmap <Tab> :bnext<CR>
nmap <S-Tab> :bprev<CR>
nmap <C-K> :bnext<CR>
nmap <C-J> :bprev<CR>

" Close the current buffer without closing the window
" <http://stackoverflow.com/a/8585343/417375>
nnoremap <Leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

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

" Map F1 key (main vim help) to ESC to avoid bringing it up by mistake.
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>
inoremap <F1> <ESC>

" -------------------------- "
" --- Intuitive home key --- "
" -------------------------- "

" 1. Fix the home inside tmux
if &term =~ '^screen'
  exec "set <Home>=\e[1~"
endif
" 2. remap the home key to toggle between first character and beginning of line
noremap <expr> <silent> <Home> col('.') == match(getline('.'),'\S')+1 ? '0' : '^'
" 3. also support insert mode
imap <silent> <Home> <C-O><Home>

" -------------------------------- "
" --- Quickfix list navigation --- "
" -------------------------------- "
" Useful for any type of search and command that populates the quickfix list.
nmap [q :cprevious<CR>
nmap ]q :cnext<CR>

" ------------------------------ "
" --- Quickfix list mappings --- "
" ------------------------------ "

" Open quickfix results in vertical and horizontal splits, with the same
" shortcuts provided by default by CtrlP (<C-v> and <C-x>).

" Picking just the functionality we need from https://github.com/yssl/QFEnter

" This will only be called in the quickfix window, owing to the filetype
" restriction on the autocmd (see below).
function! <SID>OpenQuickfix(new_split_cmd)
  " 1. the current line is the result idx as we are in the quickfix
  let l:qf_idx = line('.')
  " 2. jump to the previous window
  wincmd p
  " 3. switch to a new split (the new_split_cmd will be 'vnew' or 'split')
  execute a:new_split_cmd
  " 4. open the 'current' item of the quickfix list in the newly created buffer
  "    (the current means, the one focused before switching to the new buffer)
  execute l:qf_idx . 'cc'
endfunction

autocmd FileType qf nnoremap <buffer> <C-v> :call <SID>OpenQuickfix("vnew")<CR>
autocmd FileType qf nnoremap <buffer> <C-x> :call <SID>OpenQuickfix("split")<CR>

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

" ------------------ "
" --- Whitespace --- "
" ------------------ "

" --- Strip whitespace ---

set listchars=tab:»·,trail:·,extends:>,precedes:<
" toggle hidden characters highlighting:
nmap <silent> <Leader>h :set nolist!<CR>

function! <SID>StripTrailingWhitespaces()
  " store the original position
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e " end of lines
  %s/\n\{3,}/\r\r/e " multiple blank lines
  silent! %s/\($\n\s*\)\+\%$// " end of file
  call cursor(l, c) " back to the original position
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
" p   -> paste normally
" gv  -> reselect the pasted text
" y   -> copy it again
" `>  -> jump to the last character of the visual selection (built-in mark)
vnoremap <Leader>p pgvy`>

" ------------------- "
" --- Real delete --- "
" ------------------- "
"
" Delete without yanking, send the deleted content to the 'black hole' register.
" https://stackoverflow.com/questions/7501092/can-i-map-alt-key-in-vim
" http://vim.wikia.com/wiki/Get_Alt_key_to_work_in_terminal
if !has('nvim')
  set <M-d>=d
end

" ...then, the actual mapping:
" current line in normal and insert mode
nnoremap <M-d> "_dd
nnoremap <Leader>d "_dd
" selection in visual mode
vnoremap <M-d> "_d
vnoremap <Leader>d "_d

" ---------------------- "
" --- Spell checking --- "
" ---------------------- "

" toggle spell checking with <F6>
nnoremap <F6> :setlocal spell!<CR>
vnoremap <F6> :setlocal spell!<CR>
inoremap <F6> <Esc>:setlocal spell!<CR>

" Automatically enable spell checking for some filetypes.
" <http://robots.thoughtbot.com/vim-spell-checking>
" autocmd BufRead,BufNewFile *.md setlocal spell
autocmd FileType markdown setlocal spell
autocmd FileType gitcommit setlocal spell

" ---------------- "
" --- Markdown --- "
" ---------------- "

let g:markdown_fenced_languages = [
      \ 'html',
      \ 'python',
      \ 'bash=sh',
      \ 'ruby',
      \ 'go',
      \ 'golang=go',
\]
let g:markdown_syntax_conceal = 0
let g:markdown_minlines = 100

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

nmap <M-Up>     :call TmuxWinCmd('k')<CR>
nmap <M-Down>   :call TmuxWinCmd('j')<CR>
nmap <M-Left>   :call TmuxWinCmd('h')<CR>
nmap <M-Right>  :call TmuxWinCmd('l')<CR>

nmap <M-k> :call TmuxWinCmd('k')<CR>
nmap <M-j> :call TmuxWinCmd('j')<CR>
nmap <M-h> :call TmuxWinCmd('h')<CR>
nmap <M-l> :call TmuxWinCmd('l')<CR>

" ------------------- "
" --- vim-airline --- "
" ------------------- "

let g:airline_theme = 'base16_default' " Milder colorschemes (pending the creation of a 16-color colorscheme)
let g:airline#extensions#tabline#enabled = 1 " Enable the list of buffers
let g:airline#extensions#tabline#fnamemod = ':t' " Show just the filename
let g:airline#extensions#tabline#buffer_nr_show = 1 " Show buffer number in status bar

" TODO: Hide the '[No Name]' buffer
" let g:airline#extensions#tabline#excludes = [
"   \]

" Toggle the buffer/tab line with 'leader-t' (think of 'Toggle Tabs')
nnoremap <expr><silent> <Leader>t &showtabline ? ":set showtabline=0\<cr>" : ":set showtabline=2\<cr>"
" Keep the tabline hidden by default
au VimEnter * :set showtabline=0

" --- Streamline the status bar
" Disable branch display
let g:airline#extensions#branch#enabled = 0
" TODO:
" disable mode display
" disable word count
" show default line count + line number

" ---------------- "
" --- agignore --- "
" ---------------- "

let s:agignore =
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

" ----------- "
" --- Ack --- "
" ----------- "

if executable('ag')
  let g:ackprg = 'ag --hidden --follow --smart-case --skip-vcs-ignores' . s:agignore
endif
" do no jump to the first result
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>
" highlight the searched term
let g:ackhighlight = 1

" Search for visual selection
vnoremap <Leader>a y:Ack <C-r>=GetShellEscapedVisual()<CR>

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
let NERDTreeCascadeSingleChildDir=0 " do not collapse on the same line directories that have only one child directory

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
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden --skip-vcs-ignores -g ""' . s:agignore
endif

" Ignore space chars in file finder by designating spaces as an abbreviation
" for empty string that's expanded in fuzzy search, filename, full path &
" regexp modes (set in the mode attr).
" https://github.com/kien/ctrlp.vim/blob/master/doc/ctrlp.txt
" Fixes fuzzy searching files with space seperated terms
let g:ctrlp_abbrev = {
  \ 'gmode': 'i',
  \ 'abbrevs': [
    \ {
      \ 'pattern': ' ',
      \ 'expanded': '',
      \ 'mode': 'pfrz',
    \ },
    \ ]
  \ }

" use ctrlp in a single shortcut to navigate buffers
noremap <Leader>b :CtrlPBuffer<CR>
let g:ctrlp_switch_buffer = 0

" include the current file
let g:ctrlp_match_current_file = 1

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

" When on with the cursor, show information about the identifier (funcions, vars..)...
let g:go_auto_type_info = 1
" ...after only 100 ms instead of the default 800
set updatetime=100

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

" ------------------------------------- "
" --- Load additional configuration --- "
" ------------------------------------- "

" You can put here any further customisations or overrides.

if filereadable(glob("~/.vimrc.after"))
  source ~/.vimrc.after
endif
