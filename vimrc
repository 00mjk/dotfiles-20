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
Plug 'mzlogin/vim-markdown-toc'
Plug 'tpope/vim-abolish'
Plug 'rodjek/vim-puppet'
Plug 'mustache/vim-mustache-handlebars'
Plug 'keith/swift.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" TypeScript
" ...syntax
Plug 'HerringtonDarkholme/yats.vim'
" ...dev tools (TSServer client)
Plug 'Quramy/tsuquyomi'

Plug 'altercation/vim-colors-solarized'

" ----------------------------------- "
" --- Experimental or rarely used --- "
" ----------------------------------- "

" Plug 'dhruvasagar/vim-table-mode'

" Reveal syntax highlighting group under the cursor
" Plug 'gerw/vim-HiLinkTrace'

call plug#end()

" --- Colorscheme --- "

" Try to use 'peachpuff' if available, because it's adapts to dark and light
" background terminals, at the same time, which is useful for pairing.
try
  colorscheme peachpuff
  catch
		echom "'peachpuff' colorscheme not available, defaulting to 'default'"
  try
    colorscheme default
    catch
			echom "'default' colorscheme not available, not setting the colorscheme"
  endtry
endtry

" ----------------------- "
" --- General options --- "
" ----------------------- "

set wildmode=list:longest,full " open a list of all the matches (list) *and* cycle through them (full)
set wildignorecase
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
" -- Formatting options --- "
" ------------------------- "

" Ensure some formatting options, some of which may already be enabled by
" default, depending on the version of Vim.
" Wrap text automatically both for text (t) and comments (c).
" Auto-add current comment leader on new lines both in insert mode (r) and
" normal mode (o).
" Remove the comment characters when joining lines (j).
" Allow formatting of comments with 'gq' (q).
set formatoptions+=jtcroq
" For auto-formatting of text (not just comments) to work, textwidth must be
" explicitly set (it's 0 by default).
set textwidth=79
" Also wrap existing long lines when adding text to it (-l).
" Respect new lines with a paragraph (-a).
set formatoptions-=la

" Disabling auto formatting for the following file types because the wrapping
" also seems to be applied to code.
autocmd FileType swift,erb,sh set formatoptions-=t

" Use only one space after punctuation:
" http://en.wikipedia.org/wiki/Sentence_spacing#Typography
set nojoinspaces

" I - When moving the cursor up or down just after inserting indent for i
" 'autoindent', do not delete the indent. (cpo-I)
set cpoptions+=I

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

" Exclude git commit messages.
let cursorRestoreExclusions = ['gitcommit']

autocmd BufReadPost *
  \ if index(cursorRestoreExclusions, &ft) < 0
	\ && line("'\"") > 1
  \ && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
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
" shortcuts provided by default by other plugins for the same purpose
" (<C-v> and <C-x>).

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
vnoremap <C-Down> :m '>+1<CR>gv
vnoremap <C-Up> :m '<-2<CR>gv
inoremap <C-Down> <ESC>:m .+1<CR>gi
inoremap <C-Up> <ESC>:m .-2<CR>gi
" For terminals where Ctrl-arrows are captured by the system.
nnoremap <C-j> :m .+1<CR>
nnoremap <C-k> :m .-2<CR>
vnoremap <C-j> :m '>+1<CR>gv
vnoremap <C-k> :m '<-2<CR>gv
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

" Enable syntax-based for natively supported languages, and using ctags when
" available.
" Plugins will overwrite with more specific setups as appropriate (like vim-go).
set omnifunc=syntaxcomplete#Complete

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

" --- Make shift-Y consistent with shift-C and shift-D --- "
" shift-C changes till the end of line, and shift-D deletes till the of the line.
" shift-Y breaks the pattern, and it's an alias for `yy'.
" This was once in vim-sensible but then removed.
nnoremap Y y$

" ------------------- "
" --- Real delete --- "
" ------------------- "
"
" Delete without yanking, send the deleted content to the 'black hole' register.
" https://stackoverflow.com/questions/7501092/can-i-map-alt-key-in-vim
" http://vim.wikia.com/wiki/Get_Alt_key_to_work_in_terminal
if !has('nvim') && has('linux')
  set <M-d>=d
elseif has('osxdarwin')
  set <M-d>=∂
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

" Highlight syntax by default when entering an md file
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
" In modern Vim the markdown plugin is included by default in the Vim
" distribution itself.
let g:markdown_fenced_languages = [
      \ 'go',
      \ 'golang=go',
      \ 'html',
      \ 'javascript',
      \ 'json',
      \ 'kotlin',
      \ 'python',
      \ 'ruby',
      \ 'bash=sh',
      \ 'sh',
\]
let g:markdown_minlines = 100 " allow for more lines to be syntax highlighted
let g:markdown_syntax_conceal = 0 " don't mess with how the actual content is displayed

" ------------------------------------------------------- "
" --- File types for non-standard filename extensions --- "
" ------------------------------------------------------- "

autocmd BufNewFile,BufReadPost {*zsh,*.zsh-theme} set filetype=zsh

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
      \' --ignore="_quarantine"'.
      \' --ignore="bitbucket.org"'.
      \' --ignore="cloud.google.com"'.
      \' --ignore="code.google.com"'.
      \' --ignore="github.com"'.
      \' --ignore="golang.org"'.
      \' --ignore="gopkg.in"'.
      \' --ignore="launchpad.net"'.
      \' --ignore="speter.net"'.
      \' --ignore=".bin"'.
      \' --ignore=".bundle"'.
      \' --ignore="bundle"'.
      \' --ignore=".git"'.
      \' --ignore=".hg"'.
      \' --ignore=".svn"'.
      \' --ignore="log"'.
      \' --ignore="node_modules"'.
      \' --ignore="vendor"'.
      \' --ignore="*.class"'.
      \' --ignore="*.dll"'.
      \' --ignore="*.exe"'.
      \' --ignore="*.pyc"'.
      \' --ignore="*.so"'.
      \' --ignore="tags"'

" ---------------- "
" --- rgignore --- "
" ---------------- "

let s:rgignore =
      \' --glob="!_quarantine/**"'.
      \' --glob="!bitbucket.org/**"'.
      \' --glob="!cloud.google.com/**"'.
      \' --glob="!code.google.com/**"'.
      \' --glob="!github.com/**"'.
      \' --glob="!golang.org/**"'.
      \' --glob="!gopkg.in/**"'.
      \' --glob="!launchpad.net/**"'.
      \' --glob="!speter.net/**"'.
      \' --glob="!.bin/**"'.
      \' --glob="!.bundle/**"'.
      \' --glob="!bundle/**"'.
      \' --glob="!.git/**"'.
      \' --glob="!.hg/**"'.
      \' --glob="!.svn/**"'.
      \' --glob="!log/**"'.
      \' --glob="!node_modules/**"'.
      \' --glob="!vendor/**"'.
      \' --glob="!*.class"'.
      \' --glob="!*.dll"'.
      \' --glob="!*.exe"'.
      \' --glob="!*.pyc"'.
      \' --glob="!*.so"'.
      \' --glob="!tags"'

" ----------- "
" --- Ack --- "
" ----------- "

if executable('rg')
  let g:ackprg = 'rg --hidden --no-heading --line-number --follow --smart-case --no-ignore-vcs' . s:rgignore
elseif executable('ag')
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

" ----------------------------------- "
" --- fzf and fzf.vim integration --- "
" ----------------------------------- "

" See also https://github.com/junegunn/fzf/blob/master/README-VIM.md

" run in a less intrusive terminal buffer at the bottom
let g:fzf_layout = { 'down': '~30%' }
" command to generate tags file
let g:fzf_tags_command = 'ctags -R'
" disable the preview window
let g:fzf_preview_window = ''
" jump to the existing window if possible
let g:fzf_buffers_jump = 1

" same keybindings used for CtrlP
nmap <C-p> :Files<CR>
noremap <Leader>b :Buffers<CR>

" ---------------------- "
" --- vim-commentary --- "
" ---------------------- "

" Remap gc comments to leader-c
nmap <Leader>c gcc
vmap <Leader>c gc

autocmd FileType proto setlocal commentstring=//\ %s
autocmd FileType sql setlocal commentstring=--\ %s

" -------------- "
" --- vim-go --- "
" -------------- "

let g:go_fmt_command = "goimports"

highlight link goBuiltins Keyword

let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
" let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_format_strings = 1
" specify it even if it's currently the default
let g:go_highlight_string_spellcheck = 1

let g:go_highlight_function_parameters = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_variable_assignments = 1
let g:go_highlight_variable_declarations = 1

" let g:go_highlight_extra_types = 1
" let g:go_highlight_fields = 1
" let g:go_highlight_types = 1
" let g:go_highlight_functions = 1
" let g:go_highlight_operators = 1
" let g:go_highlight_format_strings = 1

" let g:go_highlight_debug = 1

" let g:go_highlight_space_tab_error = 1
" let g:go_highlight_diagnostic_errors = 1
" let g:go_highlight_string_spellcheck = 1
" let g:go_highlight_diagnostic_warnings = 1
" let g:go_highlight_chan_whitespace_error = 1
" let g:go_highlight_array_whitespace_error = 1
" let g:go_highlight_trailing_whitespace_error = 1

" When on with the cursor, show information about the identifier (funcions, vars..)...
let g:go_auto_type_info = 1
" ...after only 100 ms instead of the default 800
set updatetime=100

autocmd FileType go nnoremap <Leader>z :GoDiagnostics!<CR>

" ----------------- "
" --- vim-RSpec --- "
" ----------------- "

" --- Syntax highlighting outside Rails ---

autocmd BufRead {*_spec.rb,spec_helper.rb} syn keyword rubyRspec
      \ after
      \ before
      \ class_double
      \ contain_exactly
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
      \ any_args
      \ anything
      \ array_including
      \ boolean
      \ duck_type
      \ hash_excluding
      \ hash_including
      \ instance_of
      \ kind_of
      \ no_args

highlight def link rubyRspec Function

" ----------------- "
" --- Syntastic --- "
" ----------------- "

let g:syntastic_javascript_checkers=['eslint']
" let g:syntastic_go_checkers=[
"   \ 'go'
"   \]

" let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list = 1

" ---------------- "
" --- vim-json --- "
" ---------------- "

let g:vim_json_syntax_conceal = 0

" --------------------- "
" --- rainbow pairs --- "
" --------------------- "

let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'],['{', '}']]

" ------------------------------------- "
" --- Load additional configuration --- "
" ------------------------------------- "

" You can put here any further customisations or overrides.

if filereadable(glob("~/.vimrc.after"))
  source ~/.vimrc.after
endif
