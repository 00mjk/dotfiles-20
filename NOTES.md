[] `[vim]` suggest different style for Search dark yellow for some terminal
   colorschemes, in the rare cases where the default is not readable
   `hi Search term=reverse cterm=reverse ctermfg=3 ctermbg=15`
   dark cyan background with bright white text is also generally well readable
   `hi Search term=reverse cterm=reverse ctermfg=6 ctermbg=15`

[] See if this can fixed, it's become very unpredictable depending on the
   terminal

       " Close quickfix list with escape
       if has('localmap')
         autocmd FileType qf nnoremap <buffer> <silent> <Esc> :<c-u> cclose<CR>
       endif

[] Reconsider these shortcuts

       " Set folding to leader-L
       " zr to unfold and zm to fold. zR to unfold all and zM to fold all
       nmap <Leader>l :set foldmethod=syntax<CR>

       " Remap jj to escape insert mode
       inoremap jj <ESC>

Miscellanea
-----------

### Other plugins

TODO: move language specific plugins and configuration to separate vimrc
files to be loaded conditionally via a vimrc.before and vimrc.after mechanism

TypeScript

    " ...syntax
    Plug 'HerringtonDarkholme/yats.vim'
    " ...dev tools (TSServer client)
    Plug 'Quramy/tsuquyomi'

Statusline

    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

Other

    Plug 'dyng/ctrlsf.vim'

    Plug 'dhruvasagar/vim-table-mode'

    " Reveal syntax highlighting group under the cursor
    Plug 'gerw/vim-HiLinkTrace'

    Plug 'keith/swift.vim'
    Plug 'mustache/vim-mustache-handlebars'
    Plug 'rodjek/vim-puppet'
    Plug 'udalov/kotlin-vim'
    Plug 'kchmck/vim-coffee-script'
    Plug 'posva/vim-vue'
    Plug 'vim-syntastic/syntastic'
    Plug 'mxw/vim-jsx'
    Plug 'mileszs/ack.vim'

Markdown preview

* <https://github.com/greyblake/vim-preview>
* <https://github.com/previm/previm/blob/master/README-en.mkd>
* <https://github.com/suan/vim-instant-markdown>

Markdown syntax

* <https://github.com/gabrielelana/vim-markdown>, for GitHub-flavoured markdown
* <https://github.com/plasticboy/vim-markdown>

Native markdown configuration

    " Vim has a built-in markdown plugin (tpope/vim-markdown), but its syntax
    " highligting is basic in terms of styles, and does not support several valid
    " markdown features
    "
    " to activate it:
    autocmd BufNewFile,BufReadPost *.md set filetype=markdown

    " treat .txt files as markdown
    autocmd BufNewFile,BufReadPost *.txt set filetype=markdown

    " its options are:
    let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
    let g:markdown_syntax_conceal = 0
    let g:markdown_minlines = 100

### Alternate JSON formatting, doesn't respect order

    autocmd FileType json command! -nargs=0 Format execute ':%! python -c "import sys, json; print json.dumps(json.load(sys.stdin), indent=2)"'

### Airline

Sections

    section A => %#__accent_bold#%{airline#util#wrap(airline#parts#mode(),0)}%#__restore__#%{airline#util#append(airline#parts#crypt(),0)}%{airline#util#append(airline#parts#paste(),0)}%{airline#util#append("",0)}%{airline#util#append(airline#parts#spell(),0)}%{airline#util#append("",0)}%{airline#util#append("",0)}%{airline#util#append(airline#parts#iminsert(),0)}
    section B => seems to be empty
    section C => %<%f%m %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#%#__accent_bold#%#__restore__#
    section X => %{airline#util#prepend("",0)}%{airline#util#prepend("",0)}%{airline#util#prepend("",0)}%{airline#util#prepend("",0)}%{airline#util#wrap(airline#parts#filetype(),0)}
    section Y => %{airline#util#wrap(airline#parts#ffenc(),0)}
    section Z => %p%% %#__accent_bold#%{g:airline_symbols.linenr}%l%#__restore__#%#__accent_bold#/%L%{g:airline_symbols.maxlinenr}%#__restore__#:%v

Hide the '[No Name]' buffer

    let g:airline#extensions#tabline#excludes = []

Other colorschemes to derive the technique from, in order to create a
Tango-like 16-color scheme.

* `dark_minimal`
* `solarized`
* `onedark`
* `term`
* `term_light`
* `tomorrow` => this is interesting because it takes the color from the syntax
  highlighting groups
* `monochrome`

### Async search

Our main requirements for search are:

* do one thing well (we still want it to work like Vim)
* must populate the quickfix list (to support global search+replace with cfdo)
* has to be asynchronous because Ack freezes the UI on large-ish directories,
  even with the fastest search backends like ripgrep

Alternative solutions are

* Ack <https://github.com/mileszs/ack.vim> in conjunction with Dispatch
  <https://github.com/tpope/vim-dispatch>, which however requires tmux.
  Ack sadly has no plans to support async operation natively.

* CtrlSF <https://github.com/dyng/ctrlsf.vim> the most popular.
  It works very well and it can be configured to work and appear just like
  Ack, but although it does populate the quickfix list with the results, it
  shows the results in a custom type of buffer.
  This could be an advantage because it would leave the quickfix window free
  for otherpurposes, but for now maintaining full feature parity with the
  existing Ack setup was a priority.

* vim-esearch <https://github.com/eugen0329/vim-esearch> is very powerful but
  overfeatured (the popup overlay in particular)

* agrep <https://github.com/ramele/agrep> similar to CtrlSF, doesn't seem to
  offer any advantage over it.

* FlyGrep <https://github.com/wsdjeg/FlyGrep.vim> it's a part of the SpaceVim
  distro also available as a stand-alone plugin.

* fzf.vim <https://github.com/junegunn/fzf.vim> although it's capable of
  populating the quickfix by pressing a sequence of shortcuts, it's a
  completely different concept, it doesn't load the results in a buffer, it
  shows them in real time in a terminal window. Text search is a different use
  case than file search, we want to keep the results visible until we close
  them explicitly, and we want to populate the quickfix automatically.

* Ferret <https://github.com/wincent/ferret> looks very nice but again
  overfeatured

### Get info about the window of the current buffer

* BAD

        function! GetCurrentWininfo()
          let l:qf_win_nr = winnr()
          let l:qf_win_info = {}

          for win_info in getwininfo()
            if win_info.winnr == l:qf_win_nr
              let l:qf_win_info = win_info
              break
            endif
          endfor

          return l:qf_win_info
        endfunction

* GOOD

        getwininfo(win_getid())[0].loclist != 1

### Support for other Vim plugins

    " ----------------- "
    " --- Syntastic --- "
    " ----------------- "

    let g:syntastic_javascript_checkers=['eslint']
    " let g:syntastic_go_checkers=['go']

    " let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
    let g:syntastic_mode_map = { 'mode': 'passive' }
    let g:syntastic_always_populate_loc_list=1
    let g:syntastic_auto_loc_list = 1

    " -------------- "
    " --- CtrlSF --- "
    " -------------- "

    " no need to specify the search tool (a.k.a. backend), there are sensible
    " defaults, preferring rg and then ag if available, see ':help g:ctrlsf_backend'
    " if executable('rg')
    "   let g:ctrlsf_backend = 'rg'
    " elseif executable('ag')
    "   let g:ctrlsf_backend = 'ag'
    " endif

    let g:ctrlsf_default_view_mode = 'compact'
    let g:ctrlsf_populate_qflist = 1
    let g:ctrlsf_regex_pattern = 1
    let g:ctrlsf_position = 'bottom'
    let g:ctrlsf_winsize = '100'

    let g:ctrlsf_extra_backend_args = {
        \ 'rg': s:rgdefaults,
        \ }

    " CtrlSF seems to force the handling of ignores internally, so `--glob='!...'`
    " patterns will be ignored. The only way to set up ignores is to add them to
    " this list
    let g:ctrlsf_ignore_dir = ['.git']
    let g:ctrlsf_auto_close = {'normal' : 0, 'compact': 0}

    " ----------- "
    " --- Ack --- "
    " ----------- "

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

    " -------------------- "
    " --- vim-dispatch --- "
    " -------------------- "

    " don't create shortcuts, as this is only installed to support Ack's
    " asynchronous behaviour
    let g:dispatch_no_maps = 1

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
    " However, to prevent a cognitive overload, it's been heavily streamlined.

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
    let g:airline#extensions#ale#enabled = 0

    " customise the airline layout:
    " - remove section X (filetype)
    " - remove section Y (file encoding and fileformat)
    " - remove section B (git branch etc.)
    let g:airline#extensions#default#layout = [
      \ [ 'a', 'c' ],
      \ [ 'x', 'z', 'error', 'warning', 'statistics' ]
    \ ]

### Brew packages to be reviewed

* binutils
* ed
* gdb
* unzip
* sqlite
