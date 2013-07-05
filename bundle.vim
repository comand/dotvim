set nocompatible

if has('vim_starting')
    if has('win32') || has('win64')
        " Use ~/.vim for user runtime on windows too.
        let &runtimepath=substitute(&runtimepath,
        \ '\(Documents and Settings\|Users\)[\\/][^\\/,]*[\\/]\zsvimfiles\>',
        \ '.vim', 'g')
    endif
    set runtimepath+=~/.vim/bundle/neobundle.vim
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shugo/neobundle.vim'

NeoBundle 'Shougo/vimproc', {
    \ 'build' : {
    \     'windows' : 'gmake -f make_mingw32.mak',
    \     'cygwin' : 'gmake -f make_cygwin.mak',
    \     'unix' : 'gmake -f make_unit.mak',
    \     },
    \ }

NeoBundle 'epmatsw/ag.vim'
NeoBundle 'hdima/python-syntax'
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'pydave/vim-perforce'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'SirVer/ultisnips'
NeoBundle 'sjbach/lusty'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'tpope/vim-abolish'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'Yggdroot/indentLine'

NeoBundle 'vim-scripts/argtextobj.vim'
NeoBundle 'vim-scripts/a.vim'
NeoBundle 'vim-scripts/genutils'
NeoBundle 'vim-scripts/OmniCppComplete'
NeoBundle 'vim-scripts/taglist.vim'
NeoBundle 'vim-scripts/TaskList.vim'

NeoBundle 'git://git-master/Grok.vim'

if empty($P4CONFIG)
    NeoBundleDisable 'pydave/vim-perforce'
endif

filetype plugin indent on

NeoBundleCheck
