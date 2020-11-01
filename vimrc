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
Plug 'tpope/vim-dispatch'
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
Plug 'arcticicestudio/nord-vim'
Plug 'mhinz/vim-grepper'

" TypeScript
" ...syntax
Plug 'HerringtonDarkholme/yats.vim'
" ...dev tools (TSServer client)
Plug 'Quramy/tsuquyomi'

Plug 'altercation/vim-colors-solarized'

" ------------------------------------------- "
" --- Experimental or rarely used plugins --- "
" ------------------------------------------- "

" Plug 'dhruvasagar/vim-table-mode'

" Reveal syntax highlighting group under the cursor
" Plug 'gerw/vim-HiLinkTrace'

call plug#end()

" ------------------------------- "
" --- Disable unused features --- "
" ------------------------------- "

" reverting the keys in :q (therefore bringing up the command history) is quite
" common and almost never what one wants, so it's disabled;
" however, since the command history is indeed useful sometimes, it's still
" possible to summon it with the built-in :<C-f>
map q: <Nop>
" disable interactive ex-mode
nnoremap Q <nop>
" disable compatibility with old vi
set nocompatible

" ------------------- "
" --- Colorscheme --- "
" ------------------- "

" Try to use 'peachpuff' if available, because it's a 16-color scheme that
" adapts acceptably well to dark and light background terminals, at the same
" time, which is useful for pairing in shared sessions.
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

" --- reduce the command timeout --- "
" (default 1000)
set timeoutlen=350

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
syntax on " syntax highlighting

set noshowcmd                     " showcmd (on by default) is very noisy when running long commands, such as Ack
set noerrorbells visualbell t_vb= " disable all bells
set backspace=indent,eol,start    " allow extended backspace behaviour
set virtualedit=block             " allow placing the cursor after the last char in visual block
set scrolloff=3                   " number of lines visible when scrolling
set sidescroll=3
set sidescrolloff=3
set splitright                    " position of the new split panes
set splitbelow

if exists('+colorcolumn')
  set colorcolumn=81,101 " display vertical rulers for line length
  autocmd FileType qf set colorcolumn=
endif

" ---------------------- "
" --- Search options --- "
" ---------------------- "

set ignorecase  " ignore case when searching...
set smartcase   " ...unless one upper case letter is present in the word
set gdefault    " replace all the occurences in the line by default
set incsearch   " start searching without pressing enter
set hlsearch    " highlight results
" normalise the search highlight colours
" This black text/bright yellow background works really well with Tango Light
" and most other terminal themes, but might require tweaking in the
" ~/.vimrc.local for some unconventional terminal themes (Solarized Light,
" Pastel...)
" See the README/TODO for more options.
hi Search term=reverse cterm=reverse ctermfg=11 ctermbg=0
hi Todo term=reverse cterm=reverse,bold ctermfg=7 ctermbg=0
hi Visual term=reverse cterm=reverse ctermfg=7 ctermbg=0

" search and replace current word
nnoremap <Leader>r :%s/\<<C-r><C-w>\>/

" highlight current word without jumping to the next occurrence
map <Leader>h :let @/ = '\<'.expand('<cword>').'\>'\|set hlsearch<C-M>

" ----------------------------------- "
" --- Search for visual selection --- "
" ----------------------------------- "

" Search for selected text, forwards or backwards. It is case insensitive, and
" any whitespace is matched ('hello\nworld' matches 'hello world')
" makes * and # work on visual mode too.
"
" - http://vim.wikia.com/wiki/Search_for_visually_selected_text
" - http://vim.wikia.com/wiki/VimTip171
" - http://got-ravings.blogspot.com/2008/07/vim-pr0n-visual-search-mappings.html
" - https://github.com/nelstrom/vim-visual-star-search
" - http://vimcasts.org/episodes/search-for-the-selected-text/
function! s:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

" ------------------------------------------- "
" --- Search and replace visual selection --- "
" ------------------------------------------- "

" Start the find and replace command across the entire file
vnoremap <Leader>r <Esc>:%s/<c-r>=GetVimEscapedVisual()<cr>//c<Left><Left>
vnoremap <C-r> <Esc>:%s/<c-r>=GetVimEscapedVisual()<cr>//c<Left><Left>

" ------------------------------ "
" --- Visual selection utils --- "
" ------------------------------ "
"
" Based on
" * https://github.com/bryankennedy/vimrc/blob/master/vimrc
" * http://stackoverflow.com/questions/676600/vim-replace-selected-text/677918#677918
" * http://peterodding.com/code/vim/profile/autoload/xolox/escape.vim

function! GetVimEscapedVisual() range
  return VimEscape(GetVisual())
endfunction

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

function! ShellEscape(str)
  let str=a:str
  return shellescape(fnameescape(str))
endfunction

function! GetShellEscapedVisual() range
  return ShellEscape(GetVisual())
endfunction

" --------------------------------- "
" --- Reselect last edited text --- "
" --------------------------------- "

" Leader-gv selects the just changed or pasted text, similar to how the native
" gv reselects the last visual selection.
" <http://vim.wikia.com/wiki/Selecting_your_pasted_text>
nnoremap <expr> <Leader>gv '`[' . strpart(getregtype(), 0, 1) . '`]'

" --------------------- "
" --- Mouse support --- "
" --------------------- "

" see also <http://usevim.com/2012/05/16/mouse/>

if !has('nvim')
  set mouse=a " enable mouse mode
  if has("mouse_sgr")
    set ttymouse=sgr
  else
    set ttymouse=xterm2
  end
end

set ttyfast          " Send more characters for redraws (faster scrolling)
set mousehide        " Hide mouse pointer while typing
set mousemodel=popup

" ---------------------------- "
" --- Tabs and indentation --- "
" ---------------------------- "

" Use 2-space soft tabs by defaults
" (it's overridden for languages with different conventions).
set autoindent  	" remember indent level after going to the next line.
set expandtab 		" replace tabs with spaces
set tabstop=2
set shiftwidth=2
set softtabstop=2

autocmd FileType python
	\ setlocal tabstop=4
	\ | setlocal softtabstop=4
	\ | setlocal shiftwidth=4

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

" --------------- "
" --- Folding --- "
" --------------- "

" autocmd FileType python setlocal foldmethod=indent

" -------------------------- "
" --- Formatting options --- "
" -------------------------- "

" Ensure some formatting options, some of which may already be enabled by
" default, depending on the version of Vim.
"
" * Wrap text automatically both for text (t) and comments (c).
" * Auto-add current comment leader on new lines both in insert mode (r) and
" * normal mode (o).
" * Remove the comment characters when joining lines (j).
" * Allow formatting of comments with 'gq' (q).
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

set nowrap " Do not visually wrap lines by default.

set breakindent " Align visually wrapped lines with the original indentation.
set linebreak " Break between words when wrapping (don't break within words).
" toggle wrapping with leader-ww
nmap <silent> <leader>ww :set wrap!<CR>
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

" write all changed buffers with Ctrl-S
inoremap <C-S> <esc>:wall<cr>
nnoremap <C-S> :wall<CR>

" Map F1 key (main vim help) to ESC to avoid bringing it up by mistake.
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>
inoremap <F1> <ESC>

" ---------------------- "
" --- Save with sudo --- "
" ---------------------- "

" http://www.commandlinefu.com/commands/view/1204/save-a-file-you-edited-in-vim-without-the-needed-permissions
if !exists(":Sudow")
  command Sudow :execute ':silent w !sudo tee % > /dev/null' | :edit!
endif

" ---------------------------------------- "
" --- Command aliases for common typos --- "
" ---------------------------------------- "

" http://vimdoc.sourceforge.net/htmldoc/usr_40.html#40.2
if !exists(":W")
  command W w
endif
if !exists(":Wa")
  command Wa wa
endif
if !exists(":WA")
  command WA wa
endif
if !exists(":Q")
  command Q q
endif
if !exists(":Qa")
  command Qa qa
endif
if !exists(":QA")
  command QA qa
endif
if !exists(":Wq")
  command Wq wq
endif
if !exists(":Wqa")
  command Wqa wqa
endif
if !exists(":Xa")
  command Xa xa
endif

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
" NOTE: only meant for small selections and small movements, will break moving
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

" --- Visualise whitespace ---
set listchars=tab:▸·,trail:·,extends:>,precedes:<
" toggle hidden characters highlighting:
nmap <silent> <Leader>w :set nolist!<CR>

" --- highlight unwanted trailing whitespace --- "
" <https://vim.fandom.com/wiki/Highlight_unwanted_spaces#Highlighting_with_the_match_command>
"
" only in normal mode
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" --- Strip whitespace ---

function! <SID>StripExtraWhitespace()
  " store the original position
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e " end of lines
  %s/\n\{3,}/\r\r/e " multiple blank lines
  silent! %s/\($\n\s*\)\+\%$// " end of file
  call cursor(l, c) " back to the original position
endfun

autocmd FileType Dockerfile,make,c,coffee,cpp,css,eruby,eelixir,elixir,html,java,javascript,json,markdown,php,puppet,ruby,scss,sh,sql,text,tmux,typescript,vim,yaml,zsh,bash,dircolors autocmd BufWritePre <buffer> :call <SID>StripExtraWhitespace()

" StripTrailingWhitespace will not remove multiple blank lines, for langagues
" where that is the desired style.
function! <SID>StripTrailingWhitespace()
  " store the original position
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e " end of lines
  silent! %s/\($\n\s*\)\+\%$// " end of file
  call cursor(l, c) " back to the original position
endfun

autocmd FileType python autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespace()

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

" ---------------------- "
" --- Copy and Paste --- "
" ---------------------- "

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

" 'borrowed' from
" <https://github.com/zonk1024/vim_stuffs/blob/281b4dfe92d4883550659989c71ec72350f3dd10/vimrc#L129>
" Turns on paste mode, puts you in insert mode then autocmds the cleanup
function! InsertPaste() range
  set paste
  startinsert
  augroup PasteHelper
    autocmd InsertLeave * call LeavePaste()
  augroup END
endfunction

function! InsertPasteNewLine() range
  set paste
  call append(line("."), "")
  exec line(".")+1
	startinsert
  augroup PasteHelper
    autocmd InsertLeave * call LeavePaste()
  augroup END
endfunction

" Cleanup by turning off paste mode and unbinding itself from InsertLeave
function! LeavePaste() range
  set nopaste
  augroup PasteHelper
    autocmd!
  augroup END
endfunction

nnoremap <Leader>i :call InsertPaste()<CR>
nnoremap <Leader>o :call InsertPasteNewLine()<CR>

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
      \ 'bash=sh',
      \ 'go',
      \ 'golang=go',
      \ 'html',
      \ 'javascript',
      \ 'json',
      \ 'kotlin',
      \ 'python',
      \ 'ruby',
      \ 'sh',
\]
let g:markdown_minlines = 100 " allow for more lines to be syntax highlighted
let g:markdown_syntax_conceal = 0 " don't mess with how the actual content is displayed

" -------------------- "
" --- vim-dispatch --- "
" -------------------- "

" don't create shortcuts, as this is only installed to support Ack's
" asynchronous behaviour
let g:dispatch_no_maps = 1

" ---------------- "
" --- vim-ruby --- "
" ---------------- "

" Highlight ruby operators (`/`, `&&`, `*`...)
let g:ruby_operators = 1

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
      \ match_array

highlight def link rubyRspec Function

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

" Airline is included despite of how heavily it clutters the UI, for a few
" reasons...
"
" * it's hugely popular
" * it provides a 'tab bar' functionality, which is considered useful for users
"   coming from GUI editors; this works really well and can be displayed with
"   the custom :ToggleTablineWithBuffers command
" * some parts of the status bar are actually helpful (in particular the Vim
"   mode and how it's formatted)
"
" However, to prevent a cognitive storm, it's been heavily streamlined.

set noshowmode " showing the Vim mode twice is ugly

let g:airline_theme = 'base16_default' " Milder colorscheme (pending the creation of a true 16-color colorscheme)

let g:airline_symbols_ascii = 1

" --- tabline --- "

let g:airline#extensions#tabline#enabled = 1 " Enable the list of buffers
let g:airline#extensions#tabline#fnamemod = ':t' " Show just the filename
let g:airline#extensions#tabline#buffer_nr_show = 1 " Show buffer number in status bar
au VimEnter * :set showtabline=0 " Keep the tabline hidden by default
function! s:ToggleTablineWithBuffers()
  if &showtabline
    set showtabline=0
  else
    set showtabline=2
  end
endfunction

if !exists(":ToggleTablineWithBuffers")
  command ToggleTablineWithBuffers call <SID>ToggleTablineWithBuffers()
endif

" --- Streamline the status bar

" More extensions might need to be disabled if additional plugins are installed
" and have a correspoding builtin extension.
"
" Run :AirlineExtensions to find which are enabled.

" the built-in quickfix extension is lightweight and we can leave it on
" let g:airline#extensions#quickfix#enabled = 0

" unfortunately tagbar, because it's not asynchronous, can make this extension
" quite slow, delaying the painting of the status bar
let g:airline#extensions#tagbar#enabled = 0

" other resource-intensive extensions are all better disabled
let g:airline#extensions#branch#enabled = 0
let g:airline#extensions#fugitiveline#enabled = 0
let g:airline#extensions#fzf#enabled = 0
let g:airline#extensions#keymap#enabled = 0
let g:airline#extensions#netrw#enabled = 0
let g:airline#extensions#po#enabled = 0
let g:airline#extensions#searchcount#enabled = 0
let g:airline#extensions#syntastic#enabled = 0
let g:airline#extensions#term#enabled = 0
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#wordcount#enabled = 0

" customise the airline layout:
" - remove section X (filetype)
" - remove section Y (file encoding and fileformat)
" - remove section B (git branch etc.)
let g:airline#extensions#default#layout = [
  \ [ 'a', 'c' ],
  \ [ 'x', 'z', 'error', 'warning', 'statistics' ]
\ ]

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
      \ " --glob='!**/.bin/'".
      \ " --glob='!**/.bundle/'".
      \ " --glob='!**/.git/'".
      \ " --glob='!**/.hg/'".
      \ " --glob='!**/.svn/'".
      \ " --glob='!**/_quarantine/'".
      \ " --glob='!**/bitbucket.org/'".
      \ " --glob='!**/bundle/'".
      \ " --glob='!**/cloud.google.com/'".
      \ " --glob='!**/code.google.com/'".
      \ " --glob='!**/git/'".
      \ " --glob='!**/github.com/'".
      \ " --glob='!**/google.golang.org/'".
      \ " --glob='!**/golang.org/'".
      \ " --glob='!**/gopkg.in/'".
      \ " --glob='!**/launchpad.net/'".
      \ " --glob='!**/log/'".
      \ " --glob='!**/node_modules/'".
      \ " --glob='!**/speter.net/'".
      \ " --glob='!**/vendor/'".
      \ " --glob='!**/venv*/'".
      \ " --glob='!*.class'".
      \ " --glob='!*.dll'".
      \ " --glob='!*.exe'".
      \ " --glob='!*.pyc'".
      \ " --glob='!*.so'".
      \ " --glob='!tags'"

let s:rg_base_grepprg = 'rg --vimgrep --hidden --no-heading --line-number --follow --smart-case --trim --no-ignore-vcs' . s:rgignore

" ----------------------- "
" --- Search with Ack --- "
" ----------------------- "

if executable('rg')
  let g:ackprg = s:rg_base_grepprg
elseif executable('ag')
  let g:ackprg = 'ag --hidden --follow --smart-case --skip-vcs-ignores' . s:agignore
endif
" do no jump to the first result
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>
" highlight the searched term
let g:ackhighlight = 1

" Search for visual selection (rudimental, only works in basic scenarios)
vnoremap <Leader>a y:Ack <C-r>=GetShellEscapedVisual()<CR>

" Run in the background with the help of tpope/vim-dispatch
" only appears to work in tmux
if $TMUX != ""
  let g:ack_use_dispatch = 1
endif

" ------------------- "
" --- vim-grepper --- "
" ------------------- "

" Asynchronous search.
"
" Alternative solutions are
"
" * Ack <https://github.com/mileszs/ack.vim> in conjunction with Dispatch
"   <https://github.com/tpope/vim-dispatch>, which however appears to require
"   tmux
" * CtrlSF <https://github.com/dyng/ctrlsf.vim> the most popular, robust, and
"   complete of the bunch
" * vim-esearch <https://github.com/eugen0329/vim-esearch>
" * agrep <https://github.com/ramele/agrep>
" * FlyGrep <https://github.com/wsdjeg/FlyGrep.vim>
" * fzf.vim <https://github.com/junegunn/fzf.vim>

" the variable will not exist if the plugin has not been installed yet (for
" example on vim-plug's first run), this will initialise it with defaults
runtime plugin/grepper.vim

if exists(":Grepper")
  let g:grepper.tools = [
    \'rg',
    \'ag',
    \'pt',
    \'ack',
    \'git',
    \'ack-grep',
    \'grep',
    \'findstr',
    \'sift',
  \]

  " use default quickfix window height of 10 lines, no matter how many matches
  " grepper found
  let g:grepper.open = 0
  autocmd User Grepper copen

  let g:grepper.prompt_text = ' ❯❯ ' " only show a prompt, not the underlying search command
  let g:grepper.highlight = 1 " highlight matches
  let g:grepper.stop = 1000 " stop searching after 1000 results, instead of the default 5000

  let g:grepper.rg.grepprg = s:rg_base_grepprg

  " this will open the Grepper prompt, where the search pattern can be entered
  " (or by pressing Enter using the current word if no pattern is given)
  nnoremap <Leader>s :Grepper<CR>

  " search the word under the cursor directly
  nnoremap <Leader>8 :Grepper -open -cword -noprompt -switch<CR>
  nnoremap <Leader>* :Grepper -open -cword -noprompt -switch<CR>

  " --- operator --- "
  " enable the operator in normal mode, it will take a range or motion; see
  " :help grepper-operator
  nmap gs <plug>(GrepperOperator)
  " search the visual selection by mapping the operator (which can take ranges
  " and motions like all normal operators)
  xmap gs <plug>(GrepperOperator)
endif

" ---------------- "
" --- NERDTree --- "
" ---------------- "

" Shortcut to open/close
map <Leader>n :NERDTreeToggle<CR>
" Highlight the current buffer (think of 'find')
map <Leader>f :NERDTreeFind<CR>

let NERDTreeMinimalUI=1
let NERDTreeShowHidden=1
let NERDTreeNaturalSort=1
let NERDTreeIgnore = ['\.pyc$', '\.class$'] " http://superuser.com/questions/184844/hide-certain-files-in-nerdtree
let NERDTreeAutoDeleteBuffer=1 " automatically replace/close the corresponding buffer when a file is moved/deleted
let NERDTreeCascadeSingleChildDir=0 " do not collapse on the same line directories that have only one child directory

" ----------------------------------- "
" --- fzf and fzf.vim integration --- "
" ----------------------------------- "

" See also https://github.com/junegunn/fzf/blob/master/README-VIM.md

" NOTE: Most of the options set with envars in the shell will also apply when
" fzf is invoked in Vim. Check those options in case of unwanted behaviour.

" run in a less intrusive terminal buffer at the bottom
let g:fzf_layout = { 'down': '~30%' }
" command to generate tags file
let g:fzf_tags_command = 'ctags -R'
" disable the preview window
let g:fzf_preview_window = ''
" do not jump to the existing window if the buffer is already visible
let g:fzf_buffers_jump = 0

" same keybindings used for CtrlP
nmap <C-p> :Files<CR>
noremap <Leader>b :Buffers<CR>

" ---------------------- "
" --- vim-commentary --- "
" ---------------------- "

" Shortcuts
nmap <Leader>c gcc
vmap <Leader>c gc
" The underscore (_) represents the forward slash (/).
" See :help :map-special-keys.
" NOTE: this will not work with nnoremap and vnoremap
nmap <C-_> gcc
vmap <C-_> gc

autocmd FileType proto setlocal commentstring=//\ %s
autocmd FileType sql setlocal commentstring=--\ %s

" -------------- "
" --- vim-go --- "
" -------------- "

let g:go_fmt_command = "goimports"

highlight link goBuiltins Keyword

let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_functions = 1 " includes methods
let g:go_highlight_operators = 1
let g:go_highlight_string_spellcheck = 1 " even if it's currently the default
let g:go_highlight_types = 1

let g:go_highlight_generate_tags = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_variable_assignments = 1
let g:go_highlight_variable_declarations = 1

" When on with the cursor, show information about the identifier (funcions, vars..)...
let g:go_auto_type_info = 1
" ...after only 100 ms instead of the default 800
set updatetime=100

autocmd FileType go nnoremap <Leader>z :GoDiagnostics!<CR>
autocmd FileType go nnoremap <Leader>t :GoTest!<CR>

" ----------------- "
" --- Syntastic --- "
" ----------------- "

let g:syntastic_javascript_checkers=['eslint']
" let g:syntastic_go_checkers=['go']

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

" -------------- "
" --- TagBar --- "
" -------------- "

nnoremap <Leader>tt :TagbarToggle<CR>

" ------------------------------------- "
" --- Load additional configuration --- "
" ------------------------------------- "

" You can put here any further customisations or overrides.

if filereadable(glob("~/.vimrc.after"))
  source ~/.vimrc.after
endif

" ---------------------------------- "
" --- Reload vimrc automatically --- "
" ---------------------------------- "

" <https://github.com/bryankennedy/vimrc/blob/master/vimrc>
autocmd! bufwritepost $MYVIMRC source $MYVIMRC
