Remarkable dofile repositories
------------------------------

* <https://github.com/seejohnrun/dotfiles>
* <https://github.com/fabi1cazenave/dotFiles/>
* <https://github.com/ygt-mikekchar/dotfiles>

Vim plugins to consider
-----------------------

* <https://github.com/regedarek/ZoomWin>
* <https://github.com/szw/vim-maximizer>

macOS old installation notes
----------------------------

    # ------------------ #
    # --- Next steps --- #
    # ------------------ #

    echo "

    -------------
    --- NOTES ---
    -------------

    * Many packages installed depend on the shell configuration provided.
      Run './scripts/dotfiles' to install it.

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

Vim colorschemes
----------------

    " Colorschemes
    " ------------

    " Plug 'altercation/vim-colors-solarized'
    " Plug 'rakr/vim-one'
    " Plug 'arcticicestudio/nord-vim' nord-vim only works if the terminal itself is using the 16-color Nord theme
    " Plug 'lifepillar/vim-gruvbox8'
    " Plug 'jsit/disco.vim'
    " Plug 'sonph/onehalf', { 'rtp': 'vim' }
    " Plug 'romainl/apprentice'
    " Plug 'jeffkreeftmeijer/vim-dim'
    " Plug 'noahfrederick/vim-noctu'

Other vim plugins
-----------------

    " Eye-candy
    " ---------

    " Plug 'psliwka/vim-smoothie'
    " Plug 'ryanoasis/vim-devicons'
    " Plug 'nanotee/zoxide.vim'

    " Power-ups
    " ---------

    " Plug 'gerw/vim-HiLinkTrace'
    " Plug 'tpope/vim-unimpaired'
    " Plug 'tomtom/tcomment_vim'
    " Plug 'liuchengxu/vista.vim'
    " Plug 'tpope/vim-dispatch'

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
