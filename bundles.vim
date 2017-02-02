" Preamble --------------------------------------------------------------- {{{

if has('vim_starting')
    set nocompatible

    if has('win32') || has('win64')
        " Use ~/.vim for user runtime on windows too.
        let &runtimepath=substitute(&runtimepath,
        \ '\(Documents and Settings\|Users\)[\\/][^\\/,]*[\\/]\zsvimfiles\>',
        \ '.vim', 'g')
    endif
endif

call plug#begin('~/.vim/bundles')

" }}}

Plug 'altercation/vim-colors-solarized'
Plug 'chrisbra/Recover.vim'
Plug 'ervandew/supertab'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-repeat'
Plug 'Valloric/ListToggle'
Plug 'vim-scripts/a.vim'
Plug 'Yggdroot/indentLine'
Plug 'szw/vim-g'
Plug 'jiangmiao/auto-pairs'
Plug 'skywind3000/asyncrun.vim'
Plug 'romainl/vim-qf'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'kana/vim-textobj-function'
Plug 'kana/vim-textobj-user'
Plug 'sgur/vim-textobj-parameter'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'Shougo/unite.vim'
Plug 'Shougo/unite-outline'
Plug 'junkblocker/unite-tasklist'
Plug 'tsukkee/unite-tag'

Plug 'bps/vim-textobj-python', {'for': 'python'}
Plug 'hdima/python-syntax', {'for': 'python'}

Plug 'elzr/vim-json', {'for': 'json'}
Plug 'Mizuchi/STL-Syntax', {'for': 'cpp'}
Plug 'octol/vim-cpp-enhanced-highlight', {'for': 'cpp'}
Plug 'lepture/vim-jinja', {'for': ['html', 'jinja']}

Plug 'Valloric/YouCompleteMe',
    \ {'do': 'CC=clang CXX=clang++ ' .
    \ './install.py --clang-completer --tern-completer --gocode-completer' }

" Postamble -------------------------------------------------------------- {{{

let g:sitebundles=expand('~/.vim/bundles-site.vim')
if filereadable(g:sitebundles)
    execute 'source' g:sitebundles
endif

call plug#end()

" }}}
