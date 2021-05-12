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
if !has('nvim')
  Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
endif
if has('nvim')
  Plug 'neovim/nvim-lspconfig'
endif
Plug 'vim-ruby/vim-ruby'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ervandew/supertab'
Plug 'tmux-plugins/vim-tmux'
Plug 'terryma/vim-multiple-cursors'
Plug 'ekalinin/Dockerfile.vim'
Plug 'pangloss/vim-javascript'
Plug 'elzr/vim-json'
if !has('nvim')
  Plug 'dense-analysis/ale'
endif
Plug 'majutsushi/tagbar'
Plug 'godlygeek/tabular'
Plug 'SirVer/ultisnips'
Plug 'mzlogin/vim-markdown-toc'
Plug 'tpope/vim-abolish'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-grepper'

" -------------------- "
" --- Colorschemes --- "
" -------------------- "

Plug 'altercation/vim-colors-solarized'
Plug 'rakr/vim-one'
Plug 'arcticicestudio/nord-vim'

" ------------------------- "
" --- Secondary plugins --- "
" ------------------------- "

" TODO: move language specific plugins and configuration to separate vimrc
" files to be loaded conditionally via a vimrc.before and vimrc.after mechanism

" TypeScript
" ...syntax
" Plug 'HerringtonDarkholme/yats.vim'
" ...dev tools (TSServer client)
" Plug 'Quramy/tsuquyomi'

" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" Plug 'dyng/ctrlsf.vim'

" Plug 'dhruvasagar/vim-table-mode'

" Reveal syntax highlighting group under the cursor
" Plug 'gerw/vim-HiLinkTrace'

" Plug 'keith/swift.vim'
" Plug 'mustache/vim-mustache-handlebars'
" Plug 'rodjek/vim-puppet'
" Plug 'udalov/kotlin-vim'
" Plug 'kchmck/vim-coffee-script'
" Plug 'posva/vim-vue'
" Plug 'vim-syntastic/syntastic'
" Plug 'mxw/vim-jsx'
" Plug 'mileszs/ack.vim'

call plug#end()

" ------------------------------- "
" --- Disable unused features --- "
" ------------------------------- "

" reverting the keys in :q (therefore bringing up the command history) is quite
" common and almost never what one wants, so it's disabled;
" however, since the command history is indeed useful sometimes, it's still
" possible to summon it with the Vim-native :<C-f>
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

let s:swap_dir = $HOME . "/.vim/swp//"
let s:bkp_dir = $HOME . "/.vim/backup//"
let s:undo_dir = $HOME . "/.vim/undo//"

if !isdirectory(s:swap_dir) | call mkdir(s:swap_dir, "p", 0755) | endif
if !isdirectory(s:bkp_dir) | call mkdir(s:bkp_dir, "p", 0755) | endif
if !isdirectory(s:undo_dir) | call mkdir(s:undo_dir, "p", 0755) | endif

let &directory=s:swap_dir
let &undodir=s:undo_dir
let &backupdir=s:bkp_dir

set swapfile
set undofile
set backup

set timeoutlen=300 " reduce the command timeout (default 1000)

set completeopt-=preview " do not open Preview split with docs for completion entries

" --- history --- "
set history=1000

" there is another setting that my override the history size, so we ensure to
" set that too; see "h 'viminfo'" (with quotes)
"
" default options:
"
" !   save and restore global variables that start with an uppercase letter
" '   max number of files to remember for marks
" h   disable effect of 'hlsearch' when loading viminfo file
" <   max number of lines saved per register
" s   max size of each register item in Kbytes
"
" additional option:
"
" :   max number of entries in the command history
set viminfo=!,'100,<50,s10,h,:1000

" ------------------------------- "
" --- Leader key alternatives --- "
" ------------------------------- "

" They preserve the native leader key.

" this is popular
nmap , \
vmap , \

" this is less so, but works great in practice
nmap <space> \
vmap <space> \

" ---------------------- "
" --- Visual options --- "
" ---------------------- "

if has('nvim')
  " reset to default, so it will show as normally does in Vim
  set guicursor=
endif

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

" for some reason the vertsplit highlight needs to be placed after the set
" colorcolumn option
highlight VertSplit cterm=none,reverse ctermbg=8 ctermfg=8
highlight EndOfBuffer cterm=none ctermfg=15
highlight ColorColumn ctermbg=15
highlight WildMenu cterm=bold ctermfg=0 ctermbg=11

" other higlights
highlight CursorLineNr cterm=underline,bold ctermfg=none ctermbg=none
highlight LineNr cterm=none ctermfg=8 ctermbg=none
highlight SignColumn cterm=none ctermbg=none

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
highlight Search term=reverse cterm=reverse ctermfg=11 ctermbg=0
highlight Todo term=reverse cterm=reverse,bold ctermfg=7 ctermbg=0
highlight Visual term=reverse cterm=reverse ctermfg=7 ctermbg=0

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

" Leader-gv selects text that was just just changed or pasted , similar to how
" the native gv reselects the last visual selection.
" <http://vim.wikia.com/wiki/Selecting_your_pasted_text>
nnoremap <expr> <Leader>gv '`[' . strpart(getregtype(), 0, 1) . '`]'

" --------------------- "
" --- Mouse support --- "
" --------------------- "

" see also <http://usevim.com/2012/05/16/mouse/>

set mouse=a " enable mouse mode

if !has('nvim')
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

" 1. Fix the home key inside tmux
if &term =~ '^screen'
  exec "set <Home>=\e[1~"
endif
" 2. remap the home key to toggle between first character and beginning of line
noremap <expr> <silent> <Home> col('.') == match(getline('.'),'\S')+1 ? '0' : '^'
" 3. also support insert mode
imap <silent> <Home> <C-O><Home>

" ---------------------------- "
" --- Quickfix and Loclist --- "
" ---------------------------- "

" force quickfix to always use the full width of the terminal at the bottom
" (and only the quickfix, not the location list, which instead belongs to each
" specific buffer)
" https://stackoverflow.com/a/59823132/417375
autocmd FileType qf if (getwininfo(win_getid())[0].loclist != 1) | wincmd J | endif

" Navigation
" ----------
" Useful for any type of search and command that populates the lists.
nmap [q :cprevious<CR>
nmap ]q :cnext<CR>

nmap [l :lprevious<CR>
nmap ]l :lnext<CR>

" Close quickfix list with Q like some plugins do
" -----------------------------------------------

" simply execute ':q<enter>' because both quickfix list and location list are
" of type qf, and if we use cclose in a location list it will try to close
" the quickfix if open in another window, not the current location list
autocmd FileType qf nnoremap <buffer> <silent> q :q<CR>

" Open quickfix results in vertical and horizontal splits
" -------------------------------------------------------
" with the same shortcuts provided by default by other plugins for the same
" purpose (<C-v> and <C-x>).

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
if !has('nvim')
  if has('linux')
    set <M-d>=d
  elseif has('osxdarwin')
    set <M-d>=∂
  endif
endif

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
      \ 'python',
      \ 'ruby',
      \ 'sh',
\]
let g:markdown_minlines = 100 " allow for more lines to be syntax highlighted
let g:markdown_syntax_conceal = 0 " don't mess with how the actual content is displayed

" ----------------------- "
" --- Auto-formatting --- "
" ----------------------- "

" Autoformat JSON with jq
" -M  monochrome
" -r raw output
autocmd FileType json command! -nargs=0 Format execute ':%! jq -Mr .'

" Autoformat XML and HTML with xmllint
autocmd FileType xml command! -nargs=0 Format execute ':%! xmllint --format --nowarning -'

" --- Special syntax highlight --- "
" TODO:
" autocmd Syntax * call matchadd('Todo', '\W\zs\(TODO\|FIXME\|CHANGED\|BUG\|HACK\)')
" autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\)')

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

nmap <silent> <M-Up>    :call TmuxWinCmd('k')<CR>
nmap <silent> <M-Down>  :call TmuxWinCmd('j')<CR>
nmap <silent> <M-Left>  :call TmuxWinCmd('h')<CR>
nmap <silent> <M-Right> :call TmuxWinCmd('l')<CR>

nmap <silent> <M-k>     :call TmuxWinCmd('k')<CR>
nmap <silent> <M-j>     :call TmuxWinCmd('j')<CR>
nmap <silent> <M-h>     :call TmuxWinCmd('h')<CR>
nmap <silent> <M-l>     :call TmuxWinCmd('l')<CR>

" ------------------- "
" --- ag defaults --- "
" ------------------- "

let s:ag_ignore =
      \' --ignore=".bin"'.
      \' --ignore=".bundle"'.
      \' --ignore=".git"'.
      \' --ignore=".hg"'.
      \' --ignore=".svn"'.
      \' --ignore="_quarantine"'.
      \' --ignore="bitbucket.org"'.
      \' --ignore="bundle"'.
      \' --ignore="cloud.google.com"'.
      \' --ignore="code.google.com"'.
      \' --ignore="cuelang.org"'.
      \' --ignore="github.com"'.
      \' --ignore="golang.org"'.
      \' --ignore="gopkg.in"'.
      \' --ignore="launchpad.net"'.
      \' --ignore="log"'.
      \' --ignore="node_modules"'.
      \' --ignore="speter.net"'.
      \' --ignore="vendor"'.
      \' --ignore="*.class"'.
      \' --ignore="*.dll"'.
      \' --ignore="*.exe"'.
      \' --ignore="*.pyc"'.
      \' --ignore="*.so"'.
      \' --ignore="tags"'

let s:ag_defaults = ' --hidden --follow --smart-case --skip-vcs-ignores'

let s:ag_grepprg = 'ag' . s:ag_defaults . s:ag_ignore

" ------------------- "
" --- rg defaults --- "
" ------------------- "

" TODO: move ignores to an rg config file, so they are the same everywhere
let s:rg_ignore =
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
      \ " --glob='!**/cuelang.org/'".
      \ " --glob='!**/git/'".
      \ " --glob='!**/github.com/'".
      \ " --glob='!**/golang.org/'".
      \ " --glob='!**/google.golang.org/'".
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

let s:rgdefaults = " --vimgrep --hidden --no-heading --line-number --follow --smart-case --trim --no-ignore-vcs"

let s:rg_grepprg = 'rg' . s:rgdefaults . s:rg_ignore

" ------------------- "
" --- vim-grepper --- "
" ------------------- "

" --- general options --- "

" the grepper variable will be merged with the defaults once the plugin loads
let g:grepper = {}

" list the possible search tools (backends) in order of preference, only the
" available executables will remain available once the plugin loads
let g:grepper.tools = [
  \'rg',
  \'ag',
  \'pt',
  \'ack',
  \'git',
  \'grep',
\]

let g:grepper.highlight = 1 " highlight matches
let g:grepper.stop = 1000 " stop searching after 1000 results, instead of the default 5000

" set up customised search commands
let g:grepper.rg = {'grepprg': s:rg_grepprg}
let g:grepper.ag = {'grepprg': s:ag_grepprg}

" the following two settings will use the standard 10-line quickfix window
" no matter how many matches found; see ':h grepper-faq-4'
let g:grepper.open = 0
autocmd User Grepper copen

" focus the results automatically
let g:grepper.switch = 1

" --- prompt --- "
"
" the prompt is a nice to have, and provides different functionality than the
" command above, in particular shortcuts for changing search tool (with <Tab>)
" and target directory of the search (with <C-d>)
"
" however, it does not support path completion, and it causes a redraw when Esc
" is pressed

" this will open the Grepper prompt, where the search pattern can be entered
" (or by pressing Enter using the current word if no pattern is given)
nnoremap <Leader>g :Grepper<CR>

" only show a visual prompt, not the underlying search command;
let g:grepper.prompt_text = ' ❯❯ '

" --- Ack-like custom command --- "
"
" build a command that that supports both current word (when no args are given),
" and path completion (like :Ack), because the Grepper prompt does not support
" completion
"
" what suggested in the vim-grepper docs is not a solution: setting
"
"     let g:grepper.prompt = 0
"
" will allow path completion after the search pattern, but it will not search
" for the current word with no input
"
function! AckgFunc(query)
  if a:query == ''
    execute 'Grepper -noprompt -cword'
  else
    execute 'Grepper -noprompt -query ' . a:query
  endif
endfunction

command! -nargs=* -complete=file Ackg call AckgFunc(<q-args>)

nnoremap <Leader>a :Ackg<Space>

" -- search current word --- "
"
nnoremap <Leader>8 :Grepper -open -cword -noprompt -switch<CR>
nnoremap <Leader>* :Grepper -open -cword -noprompt -switch<CR>

" --- operator --- "
"
" enable the operator in normal and visual mode, it will take a range or
" motion; see :help grepper-operator
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

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
let NERDTreeStatusline="" " this seems to be ignored anyawy

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
let g:fzf_preview_window = []
" do not jump to the existing window if the buffer is already visible
let g:fzf_buffers_jump = 0
" set fzf history specifically for use within Vim, separately from the global fzf history
let s:fzf_history_dir = $HOME . "/.vim/fzf-history//"
if !isdirectory(s:fzf_history_dir) | call mkdir(s:fzf_history_dir, "p", 0755) | endif
let g:fzf_history_dir = s:fzf_history_dir

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
let g:go_list_type = "quickfix"
let g:go_fmt_fail_silently = 1 " we have other means of showing syntax errors

" let g:go_fillstruct_mode = 'gopls'
" let g:go_diagnostics_enabled = 1
" let g:go_gopls_complete_unimported = v:true
" let $GINKGO_EDITOR_INTEGRATION = "true"

" let g:go_addtags_transform = "camelcase"
" let g:go_addtags_transform = "snake_case"

" highlight current identifier
" let g:go_auto_sameids = 1

" enable all syntax highlighting
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

autocmd FileType go nnoremap <Leader>z <Plug>(go-diagnostics)
autocmd FileType go nnoremap <Leader>t <Plug>(go-test)

" ----------------------------------- "
" --- Golang/Neovim setup for LSP --- "
" ----------------------------------- "

if has('nvim')
lua <<EOF
  nvim_lsp = require "nvim_lsp"
  nvim_lsp.gopls.setup {
    cmd = {"gopls", "serve"},
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
      },
    },
  }

  function goimports(timeoutms)
    local context = { source = { organizeImports = true } }
    vim.validate { context = { context, "t", true } }

    local params = vim.lsp.util.make_range_params()
    params.context = context

    local method = "textDocument/codeAction"
    local resp = vim.lsp.buf_request_sync(0, method, params, timeoutms)
    if resp and resp[1] then
      local result = resp[1].result
      if result and result[1] then
        local edit = result[1].edit
        vim.lsp.util.apply_workspace_edit(edit)
      end
    end

    vim.lsp.buf.formatting()
  end
EOF

  "  local nvim_lsp = require 'nvim_lsp'
  "  nvim_lsp.gopls.setup{
  "    cmd = {"gopls"};
  "    filetypes = {"go"};
  "    root_dir = nvim_lsp.util.root_pattern("go.mod", ".git");
  "    log_level = vim.lsp.protocol.MessageType.Log;
  "    settings = {}
  "  }

  autocmd BufWritePre *.go lua goimports(1000)
  nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>

  autocmd Filetype go setlocal omnifunc=v:lua.vim.lsp.omnifunc
endif

" ---------------------------------------------- "
" --- ALE (A.L.E., Asynchronous Lint Engine) --- "
" ---------------------------------------------- "

let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1 " it's the default, but let's make it explicit

let g:ale_sign_error = 'E'
let g:ale_sign_warning = 'W'
let g:ale_sign_info = 'I'
" other symbols to try ▶︎ ▷ • ‣ ■ □ ▢ ▪︎ ▲ ▴ ● ◯ ◼️ ☐

" white on dark red
highlight ALEErrorSign    cterm=reverse,bold ctermfg=1  ctermbg=none
" white on dark yellow
highlight ALEWarningSign  cterm=reverse,bold ctermfg=3  ctermbg=none
" white on light blue
highlight ALEInfoSign     cterm=reverse,bold ctermfg=12 ctermbg=none
" black on bright yellow
" highlight ALEWarningSign  cterm=bold         ctermfg=none ctermbg=11

" disable all linters unless explicitly enabled
" let g:ale_linters_explicit = 1

" open the loclist automatically on errors...
let g:ale_open_list = 1
" ...and close it when the buffer is closed
augroup CloseLoclistWindowGroup
  autocmd!
  autocmd QuitPre * if empty(&buftype) | lclose | endif
augroup END
" it will close anyway once all the issue have been addressed

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

let g:tagbar_sort = 0 " list tags in order of appearance in the file

" Add support for markdown files in tagbar with
" <https://github.com/jszakmeister/markdown2ctags>
let g:markdown2ctags_path='~/.vim/tools/markdown2ctags'
if filereadable(glob(g:markdown2ctags_path))
  let g:tagbar_type_markdown = {
      \ 'ctagstype': 'markdown',
      \ 'ctagsbin' : g:markdown2ctags_path,
      \ 'ctagsargs' : '-f - --sort=yes --sro=»',
      \ 'kinds' : [
          \ 's:sections',
          \ 'i:images'
      \ ],
      \ 'sro' : '»',
      \ 'kind2scope' : {
          \ 's' : 'section',
      \ },
      \ 'sort': 0,
  \ }
endif

" ------------------------- "
" --- Diff highlighting --- "
" ------------------------- "

" use simple ansi-colours for readability in any terminal with an ANSI palette
highlight DiffAdd     cterm=none,bold ctermfg=2   ctermbg=15
highlight DiffDelete  cterm=none      ctermfg=13  ctermbg=15
highlight DiffChange  cterm=none      ctermfg=8   ctermbg=15
highlight DiffText    cterm=none,bold ctermfg=4   ctermbg=15

" ------------------ "
" --- Statusline --- "
" ------------------ "

" vim switches into command mode when searching or replacing, but not other
" commands, we disable the specific visualisation until we manage to achieve
" consistency
" \ 'c'      : { 'highlight': 'BE_ModeOther',   'name': 'COMMAND'    },
let g:be_modes = {
  \ 'n'      : { 'name': 'NORMAL'    , 'highlight': 'BE_ModeNormal'  },
  \ 'no'     : { 'name': 'N-PENDING)', 'highlight': 'BE_ModeNormal'  },
  \ 'i'      : { 'name': 'INSERT'    , 'highlight': 'BE_ModeInsert'  },
  \ 'R'      : { 'name': 'REPLACE'   , 'highlight': 'BE_ModeInsert'  },
  \ 'v'      : { 'name': 'VISUAL'    , 'highlight': 'BE_ModeVisual'  },
  \ 'V'      : { 'name': 'V-LINE'    , 'highlight': 'BE_ModeVisual'  },
  \ "\<C-v>" : { 'name': 'V-BLOCK'   , 'highlight': 'BE_ModeVisual'  },
  \ 'Rv'     : { 'name': 'V-REPLACE' , 'highlight': 'BE_ModeInsert'  },
  \ 's'      : { 'name': 'SELECT'    , 'highlight': 'BE_ModeOther'   },
  \ 'S'      : { 'name': 'S-LINE'    , 'highlight': 'BE_ModeOther'   },
  \ "\<C-s>" : { 'name': 'S-BLOCK'   , 'highlight': 'BE_ModeOther'   },
  \ 'c'      : { 'name': 'NORMAL'    , 'highlight': 'BE_ModeNormal'  },
  \ 'cv'     : { 'name': 'VIM-EX'    , 'highlight': 'BE_ModeOther'   },
  \ 'ce'     : { 'name': 'EX'        , 'highlight': 'BE_ModeOther'   },
  \ 'r'      : { 'name': 'PROMPT'    , 'highlight': 'BE_ModeOther'   },
  \ 'rm'     : { 'name': 'MORE'      , 'highlight': 'BE_ModeOther'   },
  \ 'r?'     : { 'name': 'CONFIRM'   , 'highlight': 'BE_ModeOther'   },
  \ '!'      : { 'name': 'SHELL'     , 'highlight': 'BE_ModeOther'   },
  \ 't'      : { 'name': 'TERMINAL'  , 'highlight': 'BE_ModeOther'   },
\}

let g:be_buffer_types = {
  \ 'quickfix' : { 'name': 'QUICKFIX' , 'highlight': 'BE_ModeQuickfix' },
  \ 'loclist'  : { 'name': 'LOCLIST'  , 'highlight': 'BE_ModeLoclist'  },
  \ 'preview'  : { 'name': 'PREVIEW'  , 'highlight': 'BE_ModeOther'    },
  \ 'scratch'  : { 'name': 'SCRATCH'  , 'highlight': 'BE_ModeOther'    },
  \ 'help'     : { 'name': 'HELP'     , 'highlight': 'BE_ModeOther'    },
\}

" highlight StatusLine cterm=bold ctermfg=15 ctermbg=2
highlight StatusLine    cterm=none ctermfg=15 ctermbg=8
highlight StatusLineNC  cterm=none ctermfg=15 ctermbg=8

" green
" highlight BE_ModeNormal           cterm=bold,reverse  ctermfg=10    ctermbg=none
highlight BE_ModeNormal           cterm=bold  ctermfg=none    ctermbg=10
highlight BE_ModeNormalCentre     cterm=bold,reverse  ctermfg=2     ctermbg=none
" blue
highlight BE_ModeVisual           cterm=bold,reverse  ctermfg=12    ctermbg=none
highlight BE_ModeVisualCentre     cterm=bold,reverse  ctermfg=4     ctermbg=none
" magenta
highlight BE_ModeInsert           cterm=bold,reverse  ctermfg=13    ctermbg=none
highlight BE_ModeInsertCentre     cterm=bold,reverse  ctermfg=5     ctermbg=none
" cyan
" highlight BE_ModeOther            cterm=bold,reverse  ctermfg=14    ctermbg=none
highlight BE_ModeOther            cterm=bold  ctermfg=none ctermbg=14
highlight BE_ModeOtherCentre      cterm=bold,reverse  ctermfg=6     ctermbg=none
" red
highlight BE_ModeLoclist          cterm=bold,reverse  ctermfg=9     ctermbg=none
highlight BE_ModeLoclistCentre    cterm=bold,reverse  ctermfg=1     ctermbg=none
" grey
highlight BE_ModeQuickfix         cterm=bold,reverse  ctermfg=7     ctermbg=8
highlight BE_ModeQuickfixCentre   cterm=bold,reverse  ctermfg=8     ctermbg=none

" " yellow
" highlight BE_ModeLoclist          cterm=bold          ctermfg=none  ctermbg=11
" highlight BE_ModeLoclistCentre    cterm=bold,reverse  ctermfg=3     ctermbg=none

let g:BE_statusline_centre = ' %<%f %m%r%h%w %='
let g:BE_statusline_right = ' %4l:%-3c %6([%L]%)'
let g:BE_statusline_right_only_lines = ' %4l %6([%L]%)'

function! BE_Statusline(active)
  " an empty buftype name means a normal buffer...
  if &l:buftype !=? '' && &l:buftype !=? 'quickfix' | return | endif
  " unless it's the Explore window netrw
  if &l:filetype ==? 'netrw' | return | endif
  " help is handled separately
  if &l:filetype ==? 'help' | return | endif

  " quickfix and loclist need to be handled both by filetype (for the
  " scenarios) where the Enter events don't trigger) and by event, because if
  " only the filetype is handled, both types of lists will be set with the same
  " type of statusline
  if &l:filetype ==? 'qf' && getwininfo(win_getid())[0].loclist == 1
    setlocal statusline=%!BE_ListsStatusline('loclist')
  elseif &l:filetype ==? 'qf'
    setlocal statusline=%!BE_ListsStatusline('quickfix')
  elseif &l:previewwindow == 1
    setlocal statusline=%!BE_ModeOnlyStatusline('preview')
  elseif (&l:buftype ==? 'nofile' && &l:filetype ==? '') || &l:buftype ==? 'acwrite'
    " it's a 'scratch' file (we neeed to check filetype is empty because nerdtree is a 'nofile' too)
    setlocal statusline=%!BE_ModeOnlyStatusline('scratch')
  elseif a:active == 1
    setlocal statusline=%!BE_ActiveStatusline()
  else
    setlocal statusline=%!BE_InactiveStatusline()
  endif
endfunction

function! BE_ModeOnlyStatusline(buffer_type)
  let l:mode_name   = g:be_buffer_types[a:buffer_type]['name']
  let l:mode_colour = g:be_buffer_types[a:buffer_type]['highlight']

  let l:stl  = '%#'.l:mode_colour.'#'
  let l:stl .= ' '.l:mode_name.' '
  let l:stl .= '%#'.l:mode_colour.'Centre#'
  let l:stl .= ' '

  return l:stl
endfunction

function! BE_HelpStatusline()
  let l:mode_name   = g:be_buffer_types['help']['name']
  let l:mode_colour = g:be_buffer_types['help']['highlight']

  let l:stl  = '%#'.l:mode_colour.'#'
  let l:stl .= ' '.l:mode_name.' '
  let l:stl .= '%#'.l:mode_colour.'Centre#'
  let l:stl .= ' %F'

  return l:stl
endfunction

function! BE_ListsStatusline(list_type)
  let l:mode_name   = g:be_buffer_types[a:list_type]['name']
  let l:mode_colour = g:be_buffer_types[a:list_type]['highlight']

  let l:stl  = '%#'.l:mode_colour.'#'
  let l:stl .= ' '.l:mode_name.' '
  let l:stl .= '%#'.l:mode_colour.'Centre#'
  let l:stl .= ' [%L]'

  return l:stl
endfunction

function! BE_ListsStatuslineInitial()
  if getwininfo(win_getid())[0].loclist == 1
    let &l:statusline = BE_ListsStatusline('loclist')
  else
    let &l:statusline = BE_ListsStatusline('quickfix')
  endif
endfunction

function! BE_ActiveStatusline()
  let l:mode_name   = g:be_modes[mode()]['name']
  let l:mode_colour = g:be_modes[mode()]['highlight']

  let l:stl  = '%#'.l:mode_colour.'#'
  let l:stl .= ' '.l:mode_name.'%{&paste ? "\ \ (PASTE)" : ""} '
  let l:stl .= '%#'.l:mode_colour.'Centre#'
  " flags => m: modified, r: readonly, h: help, p: preview, y: filetype
  let l:stl .=  ' %<%f %m%r %='
  let l:stl .= '%#'.l:mode_colour.'#'
  let l:stl .= g:BE_statusline_right
  return l:stl
endfunction

function! BE_InactiveStatusline()
  let l:stl  =  ' %<%f %m%r%h%w %='
  let l:stl .= g:BE_statusline_right
  return l:stl
endfunction

augroup BE_StatuslineEvents
    autocmd!
    autocmd FileType              nerdtree  setlocal statusline=\ NERDTree
    autocmd FileType              netrw     setlocal statusline=\ %<%f
    " quickfix and help also need to have its own autocmd because WinEnter and
    " BufWinEnter are not triggered consistently on first opening it
    autocmd FileType              help      setlocal statusline=%!BE_HelpStatusline()
    autocmd  FileType             qf        call BE_ListsStatuslineInitial()
    autocmd WinEnter,BufWinEnter  *         call BE_Statusline(1)
    autocmd WinLeave              *         call BE_Statusline(0)
augroup END

set noshowmode " the mode is already shown in the statusline

" ---------------------------------- "
" --- Reload vimrc automatically --- "
" ---------------------------------- "

" <https://github.com/bryankennedy/vimrc/blob/master/vimrc>
autocmd! bufwritepost $MYVIMRC source $MYVIMRC

" ------------------------------------- "
" --- Load additional configuration --- "
" ------------------------------------- "

" You can put here any further customisations or overrides.

if filereadable(glob("~/.vimrc.after"))
  source ~/.vimrc.after
endif
