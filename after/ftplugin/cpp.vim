"setlocal cindent cinoptions=':0,g0,l1,t0,(0,W4,M1'
setlocal formatoptions=croql
setlocal colorcolumn=+3

" Doxygen comments
setlocal comments-=://
setlocal comments+=://!,:///,://
let g:load_doxygen_syntax = 1

let b:ale_linters = ['clangtidy']
