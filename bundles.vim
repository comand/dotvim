if has('vim_starting')
    if has('win32') || has('win64')
        " Use ~/.vim for user runtime on windows too.
        let &runtimepath=substitute(&runtimepath,
        \ '\(Documents and Settings\|Users\)[\\/][^\\/,]*[\\/]\zsvimfiles\>',
        \ '.vim', 'g')
    endif
endif

filetype off

set runtimepath+=~/.vim/bundle/neobundle.vim
call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shugo/neobundle.vim'

NeoBundle 'Shougo/vimproc', {
    \ 'build' : {
    \     'windows' : 'make -f make_mingw32.mak',
    \     'cygwin' : 'make -f make_cygwin.mak',
    \     'unix' : 'make -f make_unix.mak',
    \     },
    \ }

NeoBundle 'hdima/python-syntax'
NeoBundle 'bling/vim-airline'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'SirVer/ultisnips'
NeoBundle 'tpope/vim-abolish'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'honza/vim-snippets'
NeoBundle 'junkblocker/unite-tasklist'

NeoBundle 'vim-scripts/argtextobj.vim'
NeoBundle 'vim-scripts/a.vim'
NeoBundle 'vim-scripts/genutils'
NeoBundle 'vim-scripts/OmniCppComplete'

NeoBundle 'git://git-master/Grok.vim'

if !empty($P4CONFIG)
    NeoBundle 'pydave/vim-perforce'
else
    NeoBundleDisable 'pydave/vim-perforce'
endif

NeoBundle 'chriskempson/base16-vim'
NeoBundle 'altercation/vim-colors-solarized'

filetype plugin indent on
