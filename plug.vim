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

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -s -fLo ~/.vim/autoload/plug.vim --create dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugdir')

" }}}

Plug 'lifepillar/vim-solarized8'
Plug 'chrisbra/Recover.vim'
Plug 'ervandew/supertab'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/syntastic'
Plug 'simnalamburt/vim-mundo'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'mhinz/vim-signify'
Plug 'vim-scripts/a.vim'
Plug 'vim-scripts/BufOnly.vim'
Plug 'Yggdroot/indentLine'
Plug 'haya14busa/incsearch.vim'
Plug 'wsdjeg/vim-fetch'
Plug 'RRethy/vim-illuminate'
Plug 'junegunn/vim-peekaboo'
Plug 'tweekmonster/startuptime.vim'

Plug '~/.fzf'
  Plug 'junegunn/fzf.vim'

Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'ryanoasis/vim-devicons'

Plug 'kana/vim-textobj-user'
  Plug 'kana/vim-textobj-function'
  Plug 'kana/vim-textobj-indent'
  Plug 'sgur/vim-textobj-parameter'
  Plug 'bps/vim-textobj-python', {'for': 'python'}

Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'

Plug 'hdima/python-syntax', {'for': 'python'}
Plug 'elzr/vim-json', {'for': 'json'}
Plug 'Mizuchi/STL-Syntax', {'for': 'cpp'}
Plug 'octol/vim-cpp-enhanced-highlight', {'for': 'cpp'}
Plug 'lepture/vim-jinja', {'for': ['html', 'jinja']}
Plug 'rust-lang/rust.vim', {'for': ['rust']}
Plug 'JamshedVesuna/vim-markdown-preview', {'for': 'markdown'}

if v:version > 704
Plug 'Valloric/YouCompleteMe'
endif

" Postamble -------------------------------------------------------------- {{{

let g:siteplug=expand('~/.vim/plug-site.vim')
if filereadable(g:siteplug)
    execute 'source' g:siteplug
endif

call plug#end()

" }}}
