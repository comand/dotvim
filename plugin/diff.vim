if &diff
    set diffopt+=internal,algorithm:patience
    set shortmess+=A
    nnoremap <C-R> :diffupdate<CR>
    nnoremap <C-N> ]c<CR>
    nnoremap <C-P> [c<CR>
    nnoremap QQ :confirm qa<CR>
    nnoremap <C-O> do
endif
