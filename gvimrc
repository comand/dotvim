" Antialiased text
set anti
colorscheme comand

" Nice tab labels
set guitablabel=%n\ %t\ %m

" Italic comments
hi Comment gui=italic
hi doxygenBrief gui=italic

" Oooooh... pretty fonts.
"set guifont=Consolas\ 12
set guifont=Anonymous\ Pro\ 12

" Enable spell checking.
set spell

" RMB on any misspelled word pops up the spell menu.
set mousemodel=popup_setpos

" Default window size
set lines=50 columns=83

" Remove GUI cruft.
set guioptions-=m
set guioptions-=T

let &titlestring=expand('%:p:h:t') . "/%t @ %{expand($TREE)}:%{expand($FLAVOR)}"
