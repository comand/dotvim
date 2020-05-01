" Preamble --------------------------------------------------------------- {{{

source ~/.vim/plug.vim
filetype plugin indent on
syntax enable

" }}}
" Paths ------------------------------------------------------------------ {{{

if has('win32') || has ('win64')
    let s:tempdir = expand('$TEMP')
    set directory=.,$TEMP
else
    let s:tempdir = '/var/tmp'
endif

set undodir=~/.vim/tmp/undo//
set directory=~/.vim/tmp/swap//

if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

" }}}
" User Interface --------------------------------------------------------- {{{

set encoding=utf-8

let g:is_posix = 1
"set t_Co=256
if (has("termguicolors"))
    set termguicolors
endif

set bg=light

" No highlight search by default
set nohlsearch

" Don't redraw the screen when executing macros.
set lazyredraw

" History
set history=1000

" Persistent Undo
set undofile

" Don't do backups.
set nobackup
set nowritebackup

" Allow buffer switch without saving
set hidden

" Always show sign column.
set signcolumn=yes

" Status line configuration
set report=0
set noruler
set laststatus=2
set noshowmode
set cmdheight=2
set showcmd

" Allow the cursor to move freely in virtual block mode (Ctrl-V)
set virtualedit+=block

" Find using cdpath
let &path = ',' . substitute($CDPATH, ':', ',', 'g')

" Save more information
set viminfo='50,<1000,s100

" Command-line completion
set wildmode=list:longest,full

" Write to the unnamed register as well as the * and + registers.
"
" XXX:comand 2020-03-26 unnamedplus doesn't work via XQuartz...
"if has('unnamedplus')
"    set clipboard=unnamedplus
"else
"    set clipboard=unnamed
"endif

" Set window min width/height
set wmw=0 wmh=0

" Resize splits when the window is resized.
augroup WinSize
    autocmd!
    autocmd VimResized * :wincmd =
augroup END

" Automatically open and close the popup menu / preview window
augroup Completion
    autocmd!
    autocmd CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
augroup END

"set completeopt=menuone,menu,longest,preview
set completeopt=longest,menuone

" GUI
if has('gui_running')
    " Antialiased text
    set anti

    " Nice tab labels
    set guitablabel=%n\ %t\ %m

    " Italic comments
    highlight Comment gui=italic
    highlight doxygenBrief gui=italic

    "set guifont=Inconsolata\ Nerd\ Font\ 12
    "set guifont=Input\ Mono\ Compressed\ Medium\ 11
    "set guifont="Cascadia Code PL 10"
    set guifont=JetBrainsMono\ Nerd\ Font\ Medium\ 10

    " Enable spell checking.
    set spell

    " RMB on any misspelled word pops up the spell menu.
    set mousemodel=popup_setpos

    " Default window size
    set lines=80 columns=120
    if !empty($WSL_DISTRO_NAME)
        set lines=60
    endif

    " Remove GUI cruft.
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
endif

if exists('g:gui_oni')
    set number
    set noswapfile
    set smartcase
    set noshowmode
    set noruler
    set laststatus=0
    set noshowcmd
endif

" http://vim.wikia.com/wiki/Automatically_quit_Vim_if_quickfix_window_is_the_last
au BufEnter * call MyLastWindow()
function! MyLastWindow()
    " If the window is quickfix go on
    if &buftype == 'quickfix'
        " If this window is last on screen quit without warning.
        if winbufnr(2) == -1
            quit!
        endif
    endif
endfunction

" }}}
" Folding ---------------------------------------------------------------- {{{

if has('folding')
    " Disable folding by default
    set nofoldenable
    set foldlevelstart=0
endif

" }}}
" Text Formatting -------------------------------------------------------- {{{

" Don't automatically wrap text.
set nowrap

" When in list mode, keep tabs normal width, display arrows,
" trailing spaces display '-' characters.
set listchars=tab:\ ·,eol:¬
set listchars+=trail:·
set listchars+=extends:»,precedes:«
set showbreak=↪

" Use heavy vertical line for vsplits (U2503), middle dot for folds.
set fillchars=vert:┃,fold:·

" Indents of 4 spaces, have them copied down lines
set tabstop=8
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab
set autoindent

" Keep N lines of the file visible above/below the cursor
set scrolloff=10

" Text breaks at 78 cols.
set textwidth=78

" Make searches case-insensitive, unless there is an upper case letter
set ignorecase
set smartcase

" Show 'best match so far' as strings are typed
set incsearch

" Assume /g flag is on for :s substitutions
set gdefault

" Allow <BkSpc> to delete line breaks, beyond the start of the current
" insertion, and over indentations:
set backspace=eol,start,indent

" Join sentences with one space, not two.
set nojoinspaces

" }}}
" Misc ------------------------------------------------------------------- {{{

if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat="%f:%l:%c:%m,%f:%l:%m
endif

let g:error_symbol = '✗'
let g:warning_symbol = '◆'

" }}}
" File Format Options ---------------------------------------------------- {{{

augroup ft_perl
    autocmd!
    autocmd BufNewFile,BufRead *.t setf perl
    autocmd FileType perl,tcl,css setlocal smartindent
augroup END

augroup ft_xml
    autocmd!
    autocmd FileType xml let g:xml_syntax_folding=1
    autocmd FileType xml setlocal foldmethod=syntax
augroup END

augroup ft_crontab
    autocmd!
    autocmd FileType crontab setlocal tw=0 nowrap
augroup END

augroup ft_web
    autocmd!
    autocmd FileType html,xhtml,css,xml setlocal fo+=l ts=2 sw=2
augroup END

augroup ft_human
    autocmd!
    autocmd BufNewFile,BufRead *.txt setfiletype human
    autocmd FileType human setlocal wrap linebreak tw=78
augroup END

augroup ft_quickfix
    autocmd!
    autocmd FileType qf setlocal colorcolumn=0 nolist nocursorline wrap tw=0
augroup END

function! VimrcFold()
    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth
    let foldedlinecount = v:foldend - v:foldstart

    let line = getline(v:foldstart)
    let line = '» ' . substitute(strpart(line, 2), '\s-\+.*$', '', '')
    let rcount = windowwidth - len(line) - len(foldedlinecount) - 1
    let line = line . repeat(' ', rcount) . foldedlinecount .  ' «'

    return line
endfunction

augroup ft_vimrc
    autocmd!
    autocmd FileType vim setlocal foldenable foldmethod=marker
    autocmd FileType vim setlocal foldtext=VimrcFold()
augroup END

augroup ft_make
    autocmd!
    autocmd FileType make setlocal noexpandtab tabstop=8 shiftwidth=8 list
augroup END

augroup ft_perforce
    autocmd!
    autocmd FileType p4change setlocal noexpandtab tw=78
    autocmd FileType p4client setlocal noexpandtab tw=0
augroup END

augroup ft_python
    autocmd!
    autocmd FileType python setlocal formatoptions=croqt
    autocmd FileType python setlocal colorcolumn=+3 comments-=:%
augroup END

augroup ft_cpp
    autocmd!
    "autocmd FileType cpp setlocal cindent cinoptions=':0,g0,l1,t0,(0,W4,M1'
    autocmd FileType cpp setlocal formatoptions=croql
    autocmd FileType cpp setlocal colorcolumn=+3

    " Doxygen comments
    autocmd FileType cpp setlocal comments-=://
    autocmd FileType cpp setlocal comments+=://!,:///,://
    autocmd FileType cpp let g:load_doxygen_syntax = 1
augroup END

augroup ft_yaml
    autocmd!
    autocmd FileType yaml setlocal sw=2 ts=2 sts=2
augroup END

" }}}
" Keystrokes: General ---------------------------------------------------- {{{

" Leader
let mapleader = ','
let g:mapleader = ','
let maplocalleader = ','
let g:maplocalleader = ','

" Map QQ to quit, like ZQ, only easier to type.
map QQ ZQ

" Disable Ex mode
nnoremap Q <Nop>

" }}}
" Keystrokes: Movement --------------------------------------------------- {{{

" have the h and l cursor keys wrap between lines (like <Space> and <BkSpc> do
" by default), and ~ converts case over line breaks; also have cursor keys
" wrap in insert mode.
set whichwrap+=h,l,~,[,]

" use <Ctrl>+N/<Ctrl>+P to cycle through buffers:
nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>

" have % bounce between angled brackets, as well as the default kinds:
set matchpairs+=<:>

" have <F1> prompt for a help topic, rather than displaying the introduction
" page.  Have it do this from any mode:
vmap <F1> <C-C><F1>
omap <F1> <C-C><F1>
map! <F1> <C-C><F1>

" Scroll wheel up to enter normal mode in terminal, RMB to exit.
function! ExitNormalMode()
    unmap <buffer> <silent> <RightMouse>
    call feedkeys("a")
endfunction

function! EnterNormalMode()
    if &buftype == 'terminal' && mode('') == 't'
        call feedkeys("\<c-w>N")
        call feedkeys("\<c-y>")
        map <buffer> <silent> <RightMouse> :call ExitNormalMode()<CR>
    endif
endfunction

tmap <silent> <ScrollWheelUp> <c-w>:call EnterNormalMode()<CR>

" }}}
" Keystrokes: Formatting ------------------------------------------------- {{{

" have Y behave analogously to D and C rather than to dd and cc (which is
" already done by yy):
noremap Y y$

" Search and replace word under cursor.
nnoremap <C-s> :%s/\<<C-R><C-W>\>/

" }}}
" Keystrokes: Toggles ---------------------------------------------------- {{{

" Toggle list on/off and report the change.
nnoremap \tl :set invlist list?<CR>
nmap <F2> \tl

" Toggle line numbering on/off, and report the change.
nnoremap \tn :set invnumber number?<CR>
nmap <F3> \tn
imap <F3> <C-O>\tn

" Toggle paste on/off and report the change, and where possible also have
" <F4> do this both in normal and insert mode.
nnoremap \tp :set invpaste paste?<CR>
nmap <F4> \tp
imap <F4> <C-O>\tp
set pastetoggle=<F4>

" }}}
" Keystrokes: Misc ------------------------------------------------------- {{{

" Show the absolute path of the current buffer.
nnoremap <M-g> :echo expand("%:p")<CR>

" Change directory to current buffer
nnoremap <Leader>cd :cd %:p:h<CR>:pwd<CR>

" Close the current buffer
nnoremap <Leader>w :bdelete<CR>

" Leave terminal input mode.
tnoremap <Leader><Esc> <C-\><C-n>

" Build
nnoremap <Leader>m :make<CR>

" }}}
" Custom Functions ------------------------------------------------------- {{{

" https://github.com/stoeffel/.dotfiles/blob/master/vim/visual-at.vim
function! ExecuteMacroOverVisualRange()
    echo "@".getcmdline()
    execute ":'<,'>normal @".nr2char(getchar())
endfunction

xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

" }}}
