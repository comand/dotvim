" *
" * File Type Settings: C++
" *

" Formatting
setlocal cindent
setlocal cinoptions=:0,g0,l1,t0,(0,W4,M1
setlocal formatoptions=croql
setlocal colorcolumn=+3

" Doxygen comments
setlocal comments-=://
setlocal comments+=://!,:///,://

" Folding
"setlocal foldenable
"setlocal foldmethod=syntax
"setlocal foldlevelstart=2
"setlocal foldcolumn=3
"setlocal foldnestmax=2

" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1
let OmniCpp_MayCompleteDot = 1
let OmniCpp_MayCompleteArrow = 1
let OmniCpp_MayCompleteScope = 1
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]

" Load doxygen syntax for c/c++/idl
let g:load_doxygen_syntax = 1

" Tag files
setlocal tags+=~/.vim/tags/cpp
"setlocal tags+=~/.vim/tags/opengl
setlocal tags+=~/.vim/tags/qt
setlocal tags+=~/.vim/tags/p4
"setlocal tags+=~/.vim/tags/oracle
"setlocal tags+=~/.vim/tags/boost

