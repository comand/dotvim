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
set tags+=~/.vim/tags/cpp
"set tags+=~/.vim/tags/opengl
set tags+=~/.vim/tags/qt
set tags+=~/.vim/tags/p4
"set tags+=~/.vim/tags/oracle
"set tags+=~/.vim/tags/boost

" CScope support
if has("cscope")
    " use both cscope and tags for 'ctrl-]', ':ta', and 'vim -t'
    "set cscopetag

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    "set csto=1

    " Search key bindings
    " ctrl-/
    "       +s: find all references to symbol under cursor
    "       +g: find global definition of symbol under cursor
    "       +c: find calls to function/method under cursor
    "       +t: find text under cursor
    "       +e: egrep search text under cursor
    "       +d: find functions that function under the cursor calls
    "       +f: open filename under cursor
    "       +i: find files that include the filename under cursor
    "
    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    "
    " display result in a hsplit
    "
    nmap <C-@>s :scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>

    " add any database in the current directory
    set nocsverb

    if filereadable("cscope.out")
        cs add cscope.out
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif

    set csverb
endif

