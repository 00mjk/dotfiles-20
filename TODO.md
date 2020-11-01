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
