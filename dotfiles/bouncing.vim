" Alternative Escape
" ------------------
" Go from insert mode to normal mode with 'jj', 'jk' or 'kj'.
" While possible, defining this mapping in visual mode is not done because it
" would interphere with the navigation keys.
" 'jk' is included, but it could prevent you from quickly typing 'Dijkstra'
inoremap jj <ESC>
inoremap jk <ESC>
inoremap kj <ESC>

" ================================
" === Create path for new file ===
" ================================

" http://stackoverflow.com/questions/10394707/create-file-inside-new-directory-in-vim-in-one-step/10397159#10397159
" You can also use `<C-y>` once you are in CtrlP.

function s:MKDir(...)
  if !a:0
        \|| isdirectory(a:1)
        \|| filereadable(a:1)
        \|| isdirectory(fnamemodify(a:1, ':p:h'))
    return
  endif
  return mkdir(fnamemodify(a:1, ':p:h'), 'p')
endfunction
command -bang -bar -nargs=? -complete=file EP :call s:MKDir(<f-args>) | e<bang> <args>

" ===========================================================
" === Close the current buffer without closing the window ===
" ===========================================================
"
" There is an actual plugin for this, but seems overkill:
" <http://www.vim.org/scripts/script.php?script_id=1147>

" <http://stackoverflow.com/a/8585343/417375> (terrific solution)
" First, fix ALT key (for gnome-terminal).
map q  <M-q>
" Second, the actual mapping
" ...current line in normal and insert mode
nnoremap <M-q> :bp<bar>sp<bar>bn<bar>bd<CR>
" Alternative keybindings for people with different terminals.
nnoremap <C-q> :bp<bar>sp<bar>bn<bar>bd<CR>
nnoremap <Leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

" ===============================
" === Filetype customizations ===
" ===============================

" http://beerpla.net/2008/04/02/how-to-add-a-vim-file-extension-to-syntax-highlighting/
syntax enable
filetype on
au BufNewFile,BufRead *.txt set filetype=markdown
au BufNewFile,BufRead *.md set filetype=markdown
au BufNewFile,BufRead *.erb set filetype=eruby.html
" Set filetype for specific names: <http://dailyvim.tumblr.com/post/1262764095/additional-ruby-syntax-highlighting>
autocmd BufRead,BufNewFile {Capfile,Gemfile,Rakefile,config.ru,.caprc,.irbrc,irb_tempfile*,.pryrc,Vagrantfile} set filetype=ruby
autocmd BufRead,BufNewFile {*bash_aliases} set filetype=sh
" It shouldn't be needed with the mustache.vim plugin
" au BufNewFile,BufRead *.mustache set filetype=html
autocmd BufRead,BufNewFile {.onc} set filetype=json

" Fold coffeescript by indentation:
" https://github.com/kchmck/vim-coffee-script#fold-by-indentation
autocmd BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable

" ===========================
" === Rainbow Parentheses ===
" ===========================
" Don't activate it by default.
let g:rainbow_active = 0

" =====================
" === Reuse buffers ===
" =====================
"
" If a buffer is already open in another window, jump to it instead of opening a new window.
set switchbuf=useopen

" ========================
" === Copy buffer path ===
" ========================
"
" Copy the current buffer full path to the system clipboard with `cp`
" http://stackoverflow.com/questions/916875/yank-file-name-path-of-current-buffer-in-vim
if has('unnamedplus')
  " ...full path
  nnoremap cpp :let @+ = expand("%:p")<CR>
  " ...relative path
  nnoremap cp :let @+ = expand("%")<CR>
else
  " ...full path
  nnoremap cpp :let @* = expand("%:p")<CR>
  " ...relative path
  nnoremap cp :let @* = expand("%")<CR>
endif

" =========================
" === Switch buffers... ===
" =========================

" ...toggle between current and previous
nnoremap <Leader><space> :b#<CR>
" ...next
nnoremap <C-Pagedown> :bn
inoremap <C-Pagedown> :bn
vnoremap <C-Pagedown> :bn
" ...previous
nnoremap <C-Pageup>   :bp
inoremap <C-Pageup>   :bp
vnoremap <C-Pageup>   :bp

" ...without Ctrl key, for mac users
nnoremap <Leader>] :bn
inoremap <Leader>] :bn
vnoremap <Leader>] :bn
nnoremap <Leader>[ :bp
inoremap <Leader>[ :bp
vnoremap <Leader>[ :bp

" ============================================
" === Close all hidden non-special buffers ===
" ============================================
"
" source http://stackoverflow.com/questions/1534835/how-do-i-close-all-buffers-that-arent-shown-in-a-window-in-vim
" modified to ensure that the buffers to close are normal (listed) buffers
"
" Other similar functions:
" http://stackoverflow.com/questions/8450919/how-can-i-delete-all-hidden-buffers>
" https://gist.github.com/skanev/1068214>
" http://vim.1045645.n5.nabble.com/close-all-unvisible-buffers-td4262697.html>
function! CloseHiddenBuffers()
  " figure out which buffers are visible in any tab
  let visible = {}
  for t in range(1, tabpagenr('$'))
    for b in tabpagebuflist(t)
      let visible[b] = 1
    endfor
  endfor
  " close any buffer that's loaded and not visible and not special
  for b in range(1, bufnr('$'))
    " add buflisted() to avoid closing special buffers
    if bufloaded(b) && !has_key(visible, b) && buflisted(b)
      exe 'bd ' . b
    endif
  endfor
endfun

nnoremap <Leader>ch :call CloseHiddenBuffers()<CR>

function! CloseAllNormalBuffers()
  " close any buffer that's loaded and not special
  for b in range(1, bufnr('$'))
    " add buflisted() to avoid closing special buffers
    if bufloaded(b) && buflisted(b)
      exe 'bd ' . b
    endif
  endfor
endfun

nnoremap <Leader>ca :call CloseAllNormalBuffers()<CR>

" =========================
" === Working directory ===
" =========================
" expand %% to current directory in the command prompt
" <https://github.com/chrishunt/dot-files/blob/master/.vim/vimrc>
cnoremap %% <C-R>=expand('%:h').'/'<CR>
" cd to directory of current buffer, and print it
" <http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file>
nnoremap <Leader>cd :cd %:p:h<CR>:pwd<CR>

" ===================================
" === Grep with external programs ===
" ===================================

" Set a different grep program
" ----------------------------
"
" This is taken from http://robots.thoughtbot.com/faster-grepping-in-vim.
" See also: http://learnvimscriptthehardway.stevelosh.com/chapters/32.html
"
" The motivation to add this was that, although 'ag' was installed on Ubuntu
" from the official repositories, it wasn't detected by ack.vim, and the
" plugin did't work.
" It's been left as it provides useful functionality with very little
" code, especially when no other plugins are available for this purpose.
"
if executable('grep')
  " http://vim.wikia.com/wiki/Find_in_files_within_Vim
  " -s: don't print error messages about missing or non readable files
  " -r: recursive
  " -n: print line numbers
  " -E: use extended regular expressions
  " -I: ignore binary files
  set grepprg=grep\ -srnEI\ --exclude-dir=.git\ .\ -e
endif

if executable('ack')
  set grepprg=ack\ --nogroup\ --nocolor
endif

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
endif

" grep 'bang' won't jump to the first result
command -nargs=+ -complete=file -bar G silent! grep! <args>|cwindow|redraw!

nnoremap \\ :G<SPACE>

" Use 'git grep' as grepprg
" -------------------------
"
" The 'fugitive' plugin already provides a much more evoluted and powerful
" solution with the Ggrep command.
" However, this is an interesting minimal option for when even fugitive
" is not available.
" With minor adaptations from:
" - http://stackoverflow.com/questions/2415237/techniques-in-git-grep-and-vim/2415257#2415257
" - http://vim.wikia.com/wiki/Git_grep
" - http://learnvimscriptthehardway.stevelosh.com/chapters/32.html
" Adds support for current word

func GitGrep(args)
  let l:original_grepprg = $grepprg
  set grepprg=git\ grep\ -n\ $*

  " grep bang will not jump to the first result
  if empty(a:args)
    let l:currword = expand('<cword>')
    if strlen(l:currword) == 0
      return
    else
      let l:cmd_string = "grep! -w " . l:currword
    endif
  else
    " escape the same way as ack.vim
    let l:cmd_string = 'grep! ' . escape(a:args, '|#%')
  endif

  silent execute l:cmd_string
  let &grepprg = l:original_grepprg
  copen
  redraw!
endfun

command -nargs=* -complete=file GG call GitGrep(<q-args>)
nnoremap \\\ :GG<SPACE>

" Faster ':vimgrep' with noautocmd
" --------------------------------

" Search current word in files with current extension
nnoremap <Leader>s :noautocmd vimgrep
  \ /<C-r>=(expand("<cword>"))<CR>/gj
  \ **/*.<C-r>=(expand("%:e"))<CR>
  \<C-left><Left>
" Search for word under cursor without jumpin to next occurrence
" http://stackoverflow.com/questions/4256697/vim-search-and-highlight-but-do-not-jump
map <Leader>h *``

" clear search results pressing space
" -----------------------------------
" nnoremap <space> :nohlsearch<CR>
" NOTE: disabled because already present in vim-sensible:
" Use <C-L> to clear the highlighting of :set hlsearch.
" (taken from https://github.com/tpope/vim-sensible)
" if maparg('<C-L>', 'n') ==# ''
"   nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
" endif

" ========================================
" === External commands without prompt ===
" ========================================
" <http://vim.wikia.com/wiki/Avoiding_the_%22Hit_ENTER_to_continue%22_prompts>
" Example
" :Silent tmux send-keys -t 1.2 "bundle exec rspec spec/my_spec.rb" C-m
" => run the tests in the second pane of the first tmux window, enter
" Notes
" - when running a tmux command, the actual command must be quoted;
" - bash aliases cannot be used; see snippets for more on this;
command! -nargs=1 Silent
      \ | execute ':silent !'.<q-args>
      \ | execute ':redraw!'

" =====================================
" === Fix keys when running in tmux ===
" =====================================

" This requires (besides some faith and luck)...
"
" 1 - ...to set the TERM "correctly" in bashrc, which breaks 16-colors
" colorschemes, but will allow solarized to work correctly inside tmux.
"
" if [[ -n "$TMUX" ]]; then
"   export TERM=screen-256color
" else
"   export TERM=xterm-256color
" fi
"
" ...or set the terminal only inside tmux (~/.tmux.conf); this won't be
" enough to have solarized work fully.
"
" set -g default-terminal "screen-256color"
"
" 2 - ...to set xterm key forwarding in tmux.conf
" set -g xterm-keys on
"
" <http://superuser.com/questions/401926/how-to-get-shiftarrows-and-ctrlarrows-working-in-vim-in-tmux/402084#402084>
" tmux will send xterm-style keys when its xterm-keys option is on

if &term =~ '^screen'
  map [6;5~ <C-Pagedown>
  map [5;5~ <C-PageUp>
  map [6;3~ <M-Pagedown>
  map [5;3~ <M-Pageup>

  exec "set <Home>=\e[1~"

  exec "set <xUp>=\e[1;*A"
  exec "set <xDown>=\e[1;*B"
  exec "set <xRight>=\e[1;*C"
  exec "set <xLeft>=\e[1;*D"
endif

" ====================
" === View options ===
" ====================

set noerrorbells visualbell t_vb=    " Disable all bells
let is_neovim=matchstr($VIMRUNTIME, '\<nvim\>')
if is_neovim == ""
  set encoding=utf-8                 " Encoding
endif
set number                           " display line numbers
nnoremap <F7> :setlocal number!<CR> " Toggle line numbers

" Autoreload ~/.vimrc when edited
" -------------------------------
"
" <https://github.com/bryankennedy/vimrc/blob/master/vimrc>
autocmd! bufwritepost $MYVIMRC source $MYVIMRC
autocmd! bufwritepost $HOME/.vimrc.after source $HOME/.vimrc.after

" Per project vimrc
" -----------------
"
" <http://damien.lespiau.name/blog/2009/03/18/per-project-vimrc/>
set exrc " enable per-directory .vimrc files
set secure " disable unsafe commands in local .vimrc files
