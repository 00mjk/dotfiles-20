[] `[vim]` suggest different style for Search dark yellow for some terminal
   colorschemes, in the rare cases where the default is not readble
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
