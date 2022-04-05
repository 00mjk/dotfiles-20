Notable dotfile repositories
----------------------------

* <https://github.com/seejohnrun/dotfiles>
* <https://github.com/fabi1cazenave/dotFiles/>
* <https://github.com/ygt-mikekchar/dotfiles>
* <https://github.com/nicknisi/dotfiles>
* <https://github.com/ChristianChiarulli/nvim>
* <https://github.com/terminalforlife/VimConfig>
* <https://github.com/terminalforlife/BashConfig>
* <https://github.com/benawad/dotfiles>
* <https://github.com/ztlevi/dotty>
* ___Making Vim Amazing___, in particular the custom presentation mode
  <https://github.com/awesome-streamers/awesome-streamerrc/tree/master/ThePrimeagen>
* ___Presentations___ in Vim
  - <https://github.com/sdaschner/dotfiles>
  - <https://youtu.be/GDa7hrbcCB8>
* <https://gist.github.com/benawad/b768f5a5bbd92c8baabd363b7e79786f>
* <https://github.com/garybernhardt/dotfiles/blob/main/.vimrc>
* <https://github.com/mathiasbynens/dotfiles>

Vim plugins
-----------

* <https://github.com/regedarek/ZoomWin>
* <https://github.com/szw/vim-maximizer>
* <https://psliwka/vim-smoothie>
* <https://ryanoasis/vim-devicons>
* <https://nanotee/zoxide.vim>
* <https://gerw/vim-HiLinkTrace>
* <https://tpope/vim-unimpaired>
* <https://tomtom/tcomment_vim>
* <https://liuchengxu/vista.vim>
* <https://tpope/vim-dispatch>
* <https://github.com/JimmyHuang454/EasyCompleteYou>
* <https://github.com/jayli/vim-easycomplete>
* <https://github.com/prabirshrestha/asyncomplete.vim>
* <https://github.com/fourjay/vim-yamsong> forces sorting of the content

Vim colorschemes
----------------

* <https://altercation/vim-colors-solarized>
* <https://rakr/vim-one>
* <https://arcticicestudio/nord-vim>
* <https://lifepillar/vim-gruvbox8>
* <https://jsit/disco.vim>
* <https://sonph/onehalf>
* <https://romainl/apprentice>
* <https://jeffkreeftmeijer/vim-dim>, also see <https://jeffkreeftmeijer.com/vim-16-color/>
* <https://noahfrederick/vim-noctu>

ANSI colorscheme tools
----------------------

* <https://terminal.sexy/>
* <https://bottosson.github.io/misc/colorpicker/>
* <https://www.hsluv.org/>

macOS old installation notes
----------------------------

* Other GNU utilities:

  - autoconf
  - binutils
  - ed
  - emacs
  - flex
  - gdb
  - gnu-units
  - m4
  - screen
  - util-linux
  - awscli
  - amazon-ecs-cli
  - git-remote-codecommit
  - terraform

* Other formulae:

  - bmon
  - cmark
  - colordiff
  - fff
  - figlet
  - glow
  - graphviz
  - htmlq
  - httpie
  - just
  - kubectx
  - lazygit
  - libpq
  - lolcat (requires Ruby)
  - mdcat
  - ncdu
  - nethogs
  - nload
  - pandoc (requires basictex cask - which provides the pdflatex binary - for markdown to pdf conversion)
  - plantuml
  - pyenv
  - ranger
  - rbenv
  - ruby
  - ruby-build
  - slurm
  - terraform
  - the_silver_searcher
  - trash
  - timewarrior (time tracking)
  - timetrap (to be installed as a Ruby gem, no brew package)
  - perl
  - ruby-install
  - ruby
  - imagemagick
  - blueutil
  - golangci-lint
  - mupdf-tools
  - pre-commit
  - yq
  - zsh-syntax-highlighting
  - python
  - lf
  - ffmpeg

* Miscellanea

      # echo "[setup] Python post-install setup"
      # brew link --overwrite --force python@3.9

      # echo "[setup] Install Vim configuration"
      # "${CURRDIR}/vim"

      # TODO: Link Chrome Dictionary to Dropbox
      # $HOME/Library/Application\ Support/Google/Chrome/Default/Custom\ Dictionary.txt

      # --- iTerm utilities ---

      # echo "[setup] Install some of the iTerm2 utilities"
      # "${CURRDIR}/iterm2-utils"

      # echo "[setup] Install Golang"
      # "${CURRDIR}/golang"
      # "${CURRDIR}/golang-zsh-completion"
      # "${CURRDIR}/golang-packages"

      # echo "[setup] Install Rust"
      # "${CURRDIR}/rust"

      # pipx install --force glances
      # pipx install --force ydiff

      # pipx install --force pgcli
      # Fatal error from pip prevented installation. Full pip output in file:
      #     ~/.local/pipx/logs/cmd_2021-05-31_11.58.22_pip_errors.log
      #
      # pip seemed to fail to build package:
      #     pgcli
      #
      # Some possibly relevant errors from pip install:
      #     Error: pg_config executable not found.
      #     ERROR: Cannot install pgcli==0.15.4, pgcli==0.16.0, pgcli==0.16.1, pgcli==0.16.2, pgcli==0.16.3, pgcli==0.17.0, pgcli==0.18.0, pgcli==0.19.0, pgcli==0.19.1, pgcli==0.19.2, pgcli==0.20.0, pgcli==0.20.1, pgcli==1.0.0, pgcli==1.1.0, pgcli==1.10.0, pgcli==1.10.1, pgcli==1.10.2, pgcli==1.10.3, pgcli==1.11.0, pgcli==1.2.0, pgcli==1.3.0, pgcli==1.3.1, pgcli==1.4.0, pgcli==1.5.0, pgcli==1.5.1, pgcli==1.6.0, pgcli==1.7.0, pgcli==1.8.0, pgcli==1.8.1, pgcli==1.8.2, pgcli==1.9.0, pgcli==1.9.1, pgcli==2.0.0, pgcli==2.0.1, pgcli==2.0.2, pgcli==2.1.0, pgcli==2.1.1, pgcli==2.2.0, pgcli==3.0.0 and pgcli==3.1.0 because these package versions have conflicting dependencies.
      #     ERROR: ResolutionImpossible: for help visit https://pip.pypa.io/en/latest/user_guide/#fixing-conflicting-dependencies
      #
      # Error installing pgcli.

    * Other casks:

      - alacritty
      - calibre
      - cryptomator
      - dash
      - devdocs
      - docker
      - font-go
      - google-drive
      - homebrew/cask-drivers/logitech-camera-settings
      - homebrew/cask/menubar-stats
      - homebrew/cask/stats
      - istat-menus
      - libreoffice
      - mdrp
      - menubar-stats
      - menumeters
      - onedrive
      - postman
      - signal
      - stats
      - telegram
      - the-unarchiver
      - thunderbird
      - tunnelbear
      - vagrant
      - vlc
      - whatsapp
      - font-dejavu
      - font-dejavu-sans-mono-nerd-font
      - font-inconsolata
      - font-inconsolata-nerd-font
      - font-mulish
      - istat-menus
      - font-jetbrains-mono-nerd-font

    * Casks requiring Rosetta 2 on arm64
      - temurin (formerly adoptopenjdk)
      - microsoft-teams
      - sdformatter
      - bitwarden (when installed outside of the App Store)
      - authy (when installed outside of the App Store)
      - dropbox

    * Open Spotlight preferences to disable 'Developer' results (source code files)

    "

    # this requires the gotop command to be aliased, because it does not respect
    # the XDG_CONFIG_HOME convention, and it will not automatically load the
    # configuration from this custom location
    # backup_and_symlink "$DOTFILES_DIR/gotop.conf" "$LOCAL_CONFIG/gotop/gotop.conf"
    # backup_and_symlink "$DOTFILES_DIR/gotop.procs.layout" "$LOCAL_CONFIG/gotop/layouts/procs"
    # backup_and_symlink "$SCRIPTS_DIR/mob" "$LOCAL_BIN/mob"
    # backup_and_symlink "$SCRIPTS_DIR/ssh-modern-keygen" "$LOCAL_BIN/ssh-modern-keygen"
    # the bash version of only dirs is too slow
    # backup_and_symlink "$SCRIPTS_DIR/onlydirs" "$LOCAL_BIN/onlydirs"

    # Automatically run the 'time' commmand if total user time + system time is
    # greater than the specified value (in seconds). This isn't great because it
    # operates on all commands, so that for example it will print the result of
    # 'time' every time vim is closed
    #
    # REPORTTIME=3

Additional zsh options
----------------------

    setopt alwaystoend
    setopt autocd
    setopt autopushd
    setopt completeinword
    setopt extendedhistory
    setopt histignorespace
    setopt histverify
    setopt interactivecomments
    setopt longlistjobs
    setopt monitor
    setopt noflowcontrol
    setopt pushdignoredups
    setopt pushdminus
    setopt sharehistory
    setopt zle

Zsh command line highlighting
-----------------------------

    # # Assuming it was installed with Homebrew
    # ZSH_HIGHLIGHT_SOURCE=$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    # [[ -f $ZSH_HIGHLIGHT_SOURCE ]] && source $ZSH_HIGHLIGHT_SOURCE || true
    # uncomment if receiving error "highlighters directory not found"
    # export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/highlighters

Vim PlantUML Previewer
----------------------

    Plug 'tyru/open-browser.vim'

    " plantuml-previewer.vim requires adoptopenjdk
    " (https://github.com/weirongxu/plantuml-previewer.vim/issues/40)
    Plug 'weirongxu/plantuml-previewer.vim'

    "--------------------------"
    "--- plantuml-previewer ---"
    "--------------------------"

    au FileType plantuml let g:plantuml_previewer#plantuml_jar_path = $HOME . '/.local/bin/plantuml.jar'

    "--------------------"
    "--- open-browser ---"
    "--------------------"

    " let g:openbrowser_browser_commands = [{'background': 1, 'name': 'open', 'args': ['{browser}', '{uri}']}]

    " let g:openbrowser_browser_commands = [
    " \ {
    " \   'background': 1,
    " \   'name': 'open',
    " \   'args': [
    " \     '-a /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome',
    " \     '{uri}',
    " \   ],
    " \ },
    " \]

Vim unused highlights
---------------------

" RED Lumy: ff9292
" RED VS Code: d7997f

    " highlight SpellBad      ctermbg=none  ctermfg=1     cterm=reverse
    " highlight SpellBad      ctermbg=none  ctermfg=13 cterm=none,reverse
    " highlight SpellBad      ctermbg=8  ctermfg=9 cterm=none,underline
    " highlight SpellBad      ctermbg=8  ctermfg=15 cterm=none

" white on red unusable in the light version
" highlight SpellBad      ctermbg=9  ctermfg=15 cterm=none,underline

" remove any highlighting from CursorLine, or it will make YCM's (YouCompleteMe)
" signature help unusable.
" highlight CursorLine    ctermbg=0                   cterm=none              ctermul=4

" highlight MatchParen    ctermbg=none  ctermfg=none  cterm=none,bold,reverse
" highlight MatchParen    ctermbg=none  ctermfg=7     cterm=none,bold,reverse
" highlight Special                     ctermfg=5

Vim - Other unused settings
---------------------------

    " Easy insertion of a trailing ; or , from insert mode
    imap ;; <Esc>A;<Esc>
    imap ,, <Esc>A,<Esc>

Colorscheme notes
=================

HSLuv 02
--------

normal: S=60,	L=80

- red			H=355
- green		H=121
- yellow		H=68.5
- blue			H=218
- magenta	H=274
- cyan			H=173

bright: S=100, L=80

(same hues)

HSLuv 03
--------

background = 1a1a1a (26, 26, 26)
foreground = a2a2a2 (162, 162, 162)

normal: S=80,	L=50

- red			H=12
- green		H=120
- yellow		H=35
- blue			H=242
- magenta	H=276 // adjusted manually
- cyan			H=196

bright: S=70, L=65

(same hues)

OKHSL 01
--------

normal: S=60,	L=60

- red			H=360
- green		H=136
- yellow		H=62
- blue			H=255
- magenta	H=312
- cyan			H=196

bright: S=70, L=70

- red			H=0

(same hues)

Vim, highlight current match
============================

    Highlight matches when jumping to next
    --------------------------------------

    " More instantly better Vim, https://youtu.be/aHm36-na4-4
    "
    " http://radar.oreilly.com/2013/10/more-instantly-better-vim.html
    "

    " This rewires n and N to do the highlighing...
    nnoremap <silent> n   n:call HLNext(0.4)<cr>
    nnoremap <silent> N   N:call HLNext(0.4)<cr>

    " Highlight the match in red...
    function! HLNext (blinktime)
        let [bufnum, lnum, col, off] = getpos('.')
        let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
        let target_pat = '\c\%#'.@/
        let ring = matchadd('ErrorMsg', target_pat, 101)
        redraw
        exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
        call matchdelete(ring)
        redraw
    endfunction

    " StackOverflow: https://vi.stackexchange.com/a/18555
    " ---------------------------------------------------
    let g:searchString = ''

    function! HighlightSearch(timer)
        if (g:firstCall)
            let g:originalStatusLineHLGroup = execute("hi StatusLine")
            let g:firstCall = 0
        endif
        if (exists("g:searching") && g:searching)
            let searchString = getcmdline()
            if searchString == ""
                let searchString = "."
            endif
            let newBG = search(searchString) != 0 ? "green" : "red"
            if searchString == "."
                set whichwrap+=h
                normal h
                set whichwrap-=h
            endif
            execute("hi StatusLine ctermfg=" . newBG)
            let g:highlightTimer = timer_start(50, 'HighlightSearch')
            let g:searchString = searchString
        else
            let originalBG = matchstr(g:originalStatusLineHLGroup, 'ctermfg=\zs[^ ]\+')
            execute("hi StatusLine ctermfg=" . originalBG)
            if exists("g:highlightTimer")
                call timer_stop(g:highlightTimer)
                call HighlightCursorMatch()
            endif
        endif
    endfunction
    function! HighlightCursorMatch()
        try
            let l:patt = '\%#'
            if &ic | let l:patt = '\c' . l:patt | endif
            exec 'match IncSearch /' . l:patt . g:searchString . '/'
        endtry
    endfunction
    nnoremap n n:call HighlightCursorMatch()<CR>
    nnoremap N N:call HighlightCursorMatch()<CR>
    augroup betterSeachHighlighting
        autocmd!
        autocmd CmdlineEnter * if (index(['?', '/'], getcmdtype()) >= 0) | let g:searching = 1 | let g:firstCall = 1 | call timer_start(1, 'HighlightSearch') | endif
        autocmd CmdlineLeave * let g:searching = 0
    augroup END

zsh complete aliases
--------------------

the "completealiases" option prevents aliases on the command line from being internally substituted
before completion is attempted, so we might need to disable it

old Docker aliases
------------------

    alias rmimages='docker rmi $(docker images -a -q)'
    alias rmcontainers='docker rm $(docker ps -a -f status=exited -q)'
    alias dkcont-nuke='docker ps -aq | xargs --no-run-if-empty docker stop | xargs --no-run-if-empty docker rm -v'
    alias dkimg-nuke=$'docker ps --filter=status=exited --quiet  | xargs --no-run-if-empty docker rm && docker images --filter=dangling=true --quiet | xargs --no-run-if-empty docker rmi && docker volume ls --filter=dangling=true --quiet | awk \'$0 ~ "^[0-9a-f]{64}$"\' | xargs --no-run-if-empty docker volume rm'
    alias rmkube='docker stop $(docker ps -q --filter name=k8s); docker rm $(docker ps -aq --filter name=k8s)'

unused aliases
--------------

    # --- bundler --- #

    alias be='bundle exec'

    # --- glow --- #

    alias glow='glow --pager'

    # --- gotop --- #

    alias gotop="gotop -C $HOME/.config/gotop/gotop.conf"

    # --- git --- #

    # width refers to each column if side-by-side; we set it to half the current
    # number of columns in the terminal
    alias yd='ydiff --width $(expr $(stty size | cut -d" " -f2) / 2) --side-by-side'

unused config
-------------

    # -------------- #
    # --- DIRENV --- #
    # -------------- #

    # do not print anything when changing env vars
    export DIRENV_LOG_FORMAT=

    # ------------------------ #
    # --- FFF FILE MANAGER --- #
    # ------------------------ #

    export FFF_HIDDEN=1 # show hidden files by default
    export FFF_COL2=7 # status line background
    export FFF_COL5=0 # status line foreground
    export FFF_COL4=4 # cursor (blue)

    export FFF_CD_ON_EXIT=1
    f() {
        fff "$@"
        cd "$(cat "${XDG_CACHE_HOME:=${HOME}/.cache}/fff/.fff_d")"
    }

    # -------------- #
    # --- Golang --- #
    # -------------- #

    if [[ -d "/usr/local/go/bin" ]]; then
      PATH="/usr/local/go/bin:$PATH"
    fi

    default_local_go="${HOME}/.go/1.18"

    if [[ -d "${default_local_go}" ]]; then
      export PATH="${default_local_go}/bin:$PATH"
      export GOPATH="${default_local_go}"
    fi

    # ---------------- #
    # --- TIMETRAP --- #
    # ---------------- #

    # another timetracker
    export SHEET_FILE="$HOME/.config/tt/time-entries.json"

    # ------------ #
    # --- Tmux --- #
    # ------------ #

    update_auth_sock() {
      SOCK="/tmp/ssh-agent-$USER-screen"

      if test $SSH_AUTH_SOCK && [ $SSH_AUTH_SOCK != $SOCK ]
      then
        rm -f /tmp/ssh-agent-$USER-screen
        ln -sf $SSH_AUTH_SOCK $SOCK
        export SSH_AUTH_SOCK=$SOCK
      fi
    }

    update_auth_sock()

    # ----------------------------------- #
    # --- Kubernetes CLI autocomplete --- #
    # ----------------------------------- #

    # TODO: this is very slow, because `kubectl completion bash` is slow,
    #       replace with a file containing the output of the kubectl command
    if [[ -n "$(command -v kubectl)" ]]; then
      source <(kubectl completion bash)
    fi

    # ---------------- #
    # --- Minikube --- #
    # ---------------- #

    export MINIKUBE_WANTKUBECTLDOWNLOADMSG=false
    export MINIKUBE_WANTUPDATENOTIFICATION=false
    export MINIKUBE_WANTREPORTERRORPROMPT=false
    export MINIKUBE_HOME=$HOME
    export CHANGE_MINIKUBE_NONE_USER=true

    mkdir -p $HOME/.kube
    touch $HOME/.kube/config

    export KUBECONFIG=$HOME/.kube/config

    # ------------- #
    # --- rbenv --- #
    # ------------- #

    # SLOW: rbenv init takes more than 150 ms. Use alias when needed.
    if [[ $(command -v rbenv) ]]; then
      eval "$(rbenv init -)"
    fi
    export PATH="$HOME/.rbenv/bin:$PATH"
    alias _init_rbenv='eval "$(rbenv init -)"'

    # ----------- #
    # --- NVM --- #
    # ----------- #

    # SLOW: nvm init takes more than 700 ms. Use alias when needed.
    # export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    # [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    # alias _init_nvm='[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"'

    #------------#
    #--- Jump ---#
    #------------#

    # [ -n "$(command -v jump)" ] && eval "$(jump shell zsh)"
