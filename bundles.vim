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
NeoBundle 'chrisbra/Recover.vim'
NeoBundle 'ervandew/supertab'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'tpope/vim-abolish'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'Valloric/ListToggle'
NeoBundle 'vim-scripts/a.vim'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'szw/vim-g'
NeoBundle 'jiangmiao/auto-pairs'
NeoBundle 'skywind3000/asyncrun.vim'

NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes', {'depends': 'ultisnips'}

NeoBundle 'kana/vim-textobj-function'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'sgur/vim-textobj-parameter'

NeoBundle 'SirVer/ultisnips'
NeoBundle 'honza/vim-snippets', {'depends': 'ultisnips'}

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-outline', {'depends': 'unite.vim'}
NeoBundle 'junkblocker/unite-tasklist', {'depends': 'unite.vim'}
NeoBundle 'tsukkee/unite-tag', {'depends': 'unite.vim'}

NeoBundleLazy 'bps/vim-textobj-python',
    \ {'autoload':{'filetypes':['python']}}
NeoBundleLazy 'hdima/python-syntax',
    \ {'autoload':{'filetypes':['python']}}

NeoBundleLazy 'elzr/vim-json',
    \ {'autoload': {'filetypes':['json']}}
NeoBundleLazy 'Mizuchi/STL-Syntax',
    \ {'autoload': {'filetypes':['cpp']}}
NeoBundleLazy 'octol/vim-cpp-enhanced-highlight',
    \ {'autoload': {'filetypes':['cpp']}}
NeoBundleLazy 'lepture/vim-jinja',
    \ {'autoload': {'filetypes':['html','jinja']}}

if v:version >= 703
    NeoBundle 'Valloric/YouCompleteMe',
        \ {
        \ 'install_process_timeout': 400
        \ }
endif

let g:sitebundles=expand('~/.vim/bundles-site.vim')
if filereadable(g:sitebundles)
    execute 'source' g:sitebundles
endif

" Postamble -------------------------------------------------------------- {{{

call neobundle#end()

" }}}
