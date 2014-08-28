" Preamble --------------------------------------------------------------- {{{

if has('vim_starting')
    if has('win32') || has('win64')
        " Use ~/.vim for user runtime on windows too.
        let &runtimepath=substitute(&runtimepath,
        \ '\(Documents and Settings\|Users\)[\\/][^\\/,]*[\\/]\zsvimfiles\>',
        \ '.vim', 'g')
    endif
endif

set runtimepath+=~/.vim/bundle/neobundle.vim
call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shugo/neobundle.vim'

" }}}

NeoBundle 'ervandew/supertab'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'bling/vim-airline'
NeoBundle 'git://git-master/Grok.vim'
NeoBundle 'hdima/python-syntax'
NeoBundle 'honza/vim-snippets'
NeoBundle 'junkblocker/unite-tasklist'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'SirVer/ultisnips'
NeoBundle 'tpope/vim-abolish'
NeoBundle 'vim-scripts/argtextobj.vim'
NeoBundle 'vim-scripts/a.vim'
NeoBundle 'vim-scripts/genutils'
NeoBundle 'Yggdroot/indentLine'

NeoBundle 'Shougo/vimproc', {
    \ 'build' : {
    \     'windows' : 'make -f make_mingw32.mak',
    \     'cygwin' : 'make -f make_cygwin.mak',
    \     'unix' : 'make -f make_unix.mak',
    \     },
    \ }

if v:version < 703 || (v:version == 703 && !has('patch584'))
    NeoBundleDisable 'Valloric/YouCompleteMe'
else
    NeoBundle 'Valloric/YouCompleteMe'
endif

if !empty($P4CONFIG)
    NeoBundle 'pydave/vim-perforce'
else
    NeoBundleDisable 'pydave/vim-perforce'
endif

