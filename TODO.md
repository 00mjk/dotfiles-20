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
  shows them in real time in a terminal window. Search is a different use case
  than file search, we want to keep the results visible until we close them
  explicitly, and we want to populate the quickfix automatically.

* Ferret <https://github.com/wincent/ferret> looks very nice but again
  overfeatured

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

    binutils \
    binutils is keg-only, which means it was not symlinked into /usr/local,
    because Apple's CLT provides the same tools.
    If you need to have binutils first in your PATH run:
      echo 'export PATH="/usr/local/opt/binutils/bin:$PATH"' >> ~/.zshrc
    For compilers to find binutils you may need to set:
      export LDFLAGS="-L/usr/local/opt/binutils/lib"
      export CPPFLAGS="-I/usr/local/opt/binutils/include"

    docker-compose \
    ==> Pouring docker-compose-1.27.3.catalina.bottle.tar.gz
    Error: The `brew link` step did not complete successfully
    The formula built, but is not symlinked into /usr/local
    Could not symlink bin/docker-compose
    Target /usr/local/bin/docker-compose
    already exists. You may want to remove it:
      rm '/usr/local/bin/docker-compose'
    To force the link and overwrite all conflicting files:
      brew link --overwrite docker-compose
    To list all files that would be deleted:
      brew link --overwrite --dry-run docker-compose
    Possible conflicting files are:
    /usr/local/bin/docker-compose -> /Applications/Docker.app/Contents/Resources/bin/docker-compose/docker-compose

    ==> Reinstalling ed
    ==> Pouring ed-1.16_1.catalina.bottle.tar.gz
    ==> Caveats
    All commands have been installed with the prefix "g".
    If you need to use these commands with their normal names, you
    can add a "gnubin" directory to your PATH from your bashrc like:
      PATH="/usr/local/opt/ed/libexec/gnubin:$PATH"
    ed is keg-only, which means it was not symlinked into /usr/local,
    because macOS already provides this software and installing another version in
    parallel can cause all kinds of trouble.
    If you need to have ed first in your PATH run:
      echo 'export PATH="/usr/local/opt/ed/bin:$PATH"' >> ~/.zshrc
    ==> Summary
    🍺  /usr/local/Cellar/ed/1.16_1: 17 files, 173.1KB

    ==> Reinstalling gdb
    ==> Pouring gdb-9.2_1.catalina.bottle.tar.gz
    ==> Caveats
    gdb requires special privileges to access Mach ports.
    You will need to codesign the binary. For instructions, see:
      https://sourceware.org/gdb/wiki/BuildingOnDarwin
    On 10.12 (Sierra) or later with SIP, you need to run this:
      echo "set startup-with-shell off" >> ~/.gdbinit
    ==> Summary
    🍺  /usr/local/Cellar/gdb/9.2_1: 55 files, 27.9MB

    ==> Reinstalling unzip
    ==> Pouring unzip-6.0_6.catalina.bottle.tar.gz
    ==> Caveats
    unzip is keg-only, which means it was not symlinked into /usr/local,
    because macOS already provides this software and installing another version in
    parallel can cause all kinds of trouble.
    If you need to have unzip first in your PATH run:
      echo 'export PATH="/usr/local/opt/unzip/bin:$PATH"' >> ~/.zshrc
    ==> Summary
    🍺  /usr/local/Cellar/unzip/6.0_6: 15 files, 514.5KB

    sqlite is keg-only, which means it was not symlinked into /usr/local,
    because macOS already provides this software and installing another version in
    parallel can cause all kinds of trouble.
    If you need to have sqlite first in your PATH run:
      echo 'export PATH="/usr/local/opt/sqlite/bin:$PATH"' >> ~/.zshrc
    For compilers to find sqlite you may need to set:
      export LDFLAGS="-L/usr/local/opt/sqlite/lib"
      export CPPFLAGS="-I/usr/local/opt/sqlite/include"
    For pkg-config to find sqlite you may need to set:
      export PKG_CONFIG_PATH="/usr/local/opt/sqlite/lib/pkgconfig"
    ==> Analytics
    install: 468,933 (30 days), 1,589,016 (90 days), 5,510,575 (365 days)
    install-on-request: 36,593 (30 days), 132,768 (90 days), 366,696 (365 days)
    build-error: 0 (30 days)
