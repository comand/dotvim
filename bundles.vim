" Preamble --------------------------------------------------------------- {{{

if has('vim_starting')
    set nocompatible

    if has('win32') || has('win64')
        " Use ~/.vim for user runtime on windows too.
        let &runtimepath=substitute(&runtimepath,
        \ '\(Documents and Settings\|Users\)[\\/][^\\/,]*[\\/]\zsvimfiles\>',
        \ '.vim', 'g')
    endif

    set runtimepath+=~/.vim/bundle/neobundle.vim
endif

call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shugo/neobundle.vim'

" }}}

NeoBundle 'Shougo/vimproc', {
    \ 'build' : {
    \     'windows' : 'make -f make_mingw32.mak',
    \     'cygwin' : 'make -f make_cygwin.mak',
    \     'unix' : 'make -f make_unix.mak',
    \     },
    \ }

NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'bling/vim-airline'
NeoBundle 'bps/vim-textobj-python'
NeoBundle 'chrisbra/Recover.vim'
NeoBundle 'elzr/vim-json'
NeoBundle 'ervandew/supertab'
NeoBundle 'hdima/python-syntax'
NeoBundle 'honza/vim-snippets'
NeoBundle 'junkblocker/unite-tasklist'
NeoBundle 'kana/vim-textobj-function'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'Mizuchi/STL-Syntax'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'sgur/vim-textobj-parameter'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'SirVer/ultisnips'
NeoBundle 'tpope/vim-abolish'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tsukkee/unite-tag'
NeoBundle 'vim-scripts/a.vim'
NeoBundle 'Yggdroot/indentLine'

if v:version < 703 || (v:version == 703 && !has('patch584'))
    NeoBundleDisable 'Valloric/YouCompleteMe'
else
    NeoBundle 'Valloric/YouCompleteMe'
endif

let g:sitebundles=expand('~/.vim/bundles-site.vim')
if filereadable(g:sitebundles)
    execute 'source' g:sitebundles
endif

" Postamble -------------------------------------------------------------- {{{

call neobundle#end()

" }}}
