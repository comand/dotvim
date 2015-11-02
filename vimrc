" Preamble --------------------------------------------------------------- {{{

filetype off
source ~/.vim/bundles.vim
filetype plugin indent on

" }}}
" Paths ------------------------------------------------------------------ {{{

if has('win32')
    let s:tempdir = expand('$TEMP')
    set directory=.,$TEMP
else
    let s:tempdir = '/var/tmp'
endif

set undodir=~/.vim/tmp/undo//
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//

if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

" }}}
" User Interface --------------------------------------------------------- {{{

set encoding=utf-8

let g:is_posix = 1
"set synmaxcol=160
syntax on

" Color scheme
"colorscheme comand
let g:solarized_termcolors=256
set t_Co=256
colorscheme solarized

" No highlight search by default
set nohlsearch

" Don't redraw the screen when executing macros.
set lazyredraw

" History
set history=1000

" Undo
"set undofile
"set undoreload=10000

" Allow buffer switch without saving
set hidden

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
if has('unnamedplus')
    set clipboard=unnamedplus
else
    set clipboard=unnamed
endif

" Set window min width/height
set wmw=0 wmh=0

" Resize splits when the window is resized.
au VimResized * :wincmd =

" Automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
"set completeopt=menuone,menu,longest,preview
set completeopt=longest,menuone

" GUI
if has('gui_running')
    " Antialiased text
    set anti

    " Nice tab labels
    set guitablabel=%n\ %t\ %m

    " Italic comments
    hi Comment gui=italic
    hi doxygenBrief gui=italic

    " Oooooh... pretty fonts.
    if has('win32')
        set guifont=Consolas:h11
    else
        "set guifont=Consolas\ 11
        set guifont=Inconsolata\ 11
    endif

    " Enable spell checking.
    set spell

    " RMB on any misspelled word pops up the spell menu.
    set mousemodel=popup_setpos

    " Default window size
    set lines=60 columns=83

    " Remove GUI cruft.
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
endif

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
"set listchars+=tab:>>,trail:-
set listchars=tab:\ ·,eol:¬
set listchars+=trail:·
set listchars+=extends:»,precedes:«
set showbreak=↪

" Indents of 4 spaces, have them copied down lines
set tabstop=4
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
" File Format Options ---------------------------------------------------- {{{

augroup ft_perl
    au!
    au BufNewFile,BufRead *.t setf perl
    au FileType perl,tcl,css setlocal smartindent
augroup END

augroup ft_web
    au!
    au FileType html,xhtml,css,xml setlocal fo+=l ts=2 sw=2
augroup END

augroup ft_human
    au!
    au BufNewFile,BufRead *.txt setf human
    au FileType human setlocal wrap linebreak tw=78
augroup END

augroup ft_quickfix
    au!
    au FileType qf setlocal colorcolumn=0 nolist nocursorline nowrap tw=0
augroup END

function! VimrcFold()
    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth
    let foldedlinecount = v:foldend - v:foldstart

    let line = getline(v:foldstart)
    let line = '+ ' . substitute(strpart(line, 2), '\s-\+.*$', '', '')
    let rcount = windowwidth - len(line) - len(foldedlinecount) - 2
    let line = line . repeat(' ', rcount) . foldedlinecount .  ' »'

    return line
endfunction

augroup ft_vimrc
    au!
    au FileType vim setlocal fen fdm=marker fdt=VimrcFold()
augroup END

augroup ft_make
    au!
    au FileType make setlocal noet ts=8 sw=8 list
augroup END

augroup ft_perforce
    au!
    au FileType p4change setlocal noet tw=78
    au FileType p4client setlocal noet tw=0
augroup END

augroup ft_python
    au!
    au FileType python setlocal fo=croqt colorcolumn=+3 comments-=:%
augroup END

function! AddTags(tagdir, disabled)
    if exists("g:did_add_cpp_tag_files")
        return
    endif
    let tagfiles = split(globpath(a:tagdir, '*'), '\n')
    for tagfile in tagfiles
        if index(a:disabled, fnamemodify(tagfile, ":t")) == -1
            if filereadable(tagfile)
                let &tags=&tags . ',' . tagfile
            endif
        endif
    endfor
endfunction

augroup ft_cpp
    au!
    au FileType cpp setlocal cin cino=':0,g0,l1,t0,(0,W4,M1'
    au FileType cpp setlocal formatoptions=croql
    au FileType cpp setlocal colorcolumn=+3

    " Doxygen comments
    au FileType cpp setlocal comments-=://
    au FileType cpp setlocal comments+=://!,:///,://
    au FileType cpp let g:load_doxygen_syntax = 1

    " OmniCpp Setup 
    "au FileType cpp let OmniCpp_ShowPrototypeInAbbr = 1
    "au FileType cpp let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]

    " Tag files
    au FileType cpp call AddTags('~/.vim/tags', ['boost', 'opengl', 'oracle'])
augroup END

" }}}
" Build Configuration ---------------------------------------------------- {{{

" Make program
if !empty(findfile('SConscript', '.;')) || !empty(findfile('SConstruct', '.;'))
    set makeprg=scons
elseif !empty(findfile('Makefile', '.'))
    set makeprg=gmake
elseif !empty(findfile('build.xml', '.'))
    set makeprg=ant
endif

nnoremap <F6> :make<CR>
au QuickFixCmdPost make :cwin

" }}}
" Keystrokes: General ---------------------------------------------------- {{{

" Leader
let mapleader = ','
let g:mapleader = ','
let maplocalleader = ','
let g:maplocalleader = ','

" Map QQ to quit, like ZQ, only easier to type.
map QQ ZQ
map Q q

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
nnoremap <F1> :help<Space>
vmap <F1> <C-C><F1>
omap <F1> <C-C><F1>
map! <F1> <C-C><F1>

" }}}
" Keystrokes: Formatting ------------------------------------------------- {{{

" have Y behave analogously to D and C rather than to dd and cc (which is
" already done by yy):
noremap Y y$

" Search and replace word under cursor.
nnoremap <C-S> :%s/\<<C-R><C-W>\>/

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

" Toggle highlighting of search matches, and report the change.
nnoremap \th :set invhls hls?<CR>
nmap <F5> \th

" Toggle fold open/close
nnoremap <space> za
vnoremap <space> zf

" }}}
" Keystrokes: Misc ------------------------------------------------------- {{{

" Show the absolute path of the current buffer.
nnoremap <M-g> :echo expand("%:p")<CR>

" Change directory to current buffer
nnoremap <Leader>cd :cd %:p:h<CR>:pwd<CR>

" Close the current buffer
nnoremap <Leader>w :bdelete<CR>

" Always use magic regexes
"nnoremap / /\v
"vnoremap / /\v

" }}}
" Plugin Configuration --------------------------------------------------- {{{

" Airline {{{

let g:airline_powerline_fonts = 1
"let g:airline_theme = 'light'

" Turn off extensions I won't use.
let g:airline#extensions#bufferline#enabled = 0
let g:airline#extensions#ctrlp#enabled = 0
let g:airline#extensions#tagbar#enabled = 0
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#branch#enabled = 0

" Turn on others.
let g:airline#extensions#unite#enabled = 1

let g:airline_symbols = {}
let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline_symbols.branch = '⭠'
let g:airline_symbols.readonly = '⭤'
let g:airline_symbols.linenr = '⭡'

" }}}
" Alternate {{{

nmap <C-H> :A<CR>

" }}}
" Diff Mode {{{

if &diff
    nnoremap <C-R> :diffupdate<CR>
    nnoremap <C-N> ]c<CR>
    nnoremap <C-P> [c<CR>
    nnoremap <C-Q> :confirm qa<CR>
    nnoremap <C-O> do
endif

" }}}
" IndentLine {{{

let g:indentLine_char = "|"
let g:indentLine_first_char = "|"
let g:indentLine_fileType = ['python']
let g:indentLine_color_gui = "Grey85"

" }}}
" JSON {{{

let g:vim_json_syntax_conceal = 0
let g:vim_json_warnings = 0

" }}}
" ListToggle {{{

let g:lt_location_list_toggle_map = '<leader>l'
let g:lt_quickfix_list_toggle_map = '<leader>f'

" }}}
" Man mode {{{

source $VIMRUNTIME/ftplugin/man.vim
au FileType man set nomod nolist

" }}}
" Python-syntax {{{

let b:python_version_2 = 1
let python_highlight_builtins = 1
let python_highlight_builtin_objs = 1
let python_highlight_builtin_funcs = 1
let python_highlight_exceptions = 1
let python_highlight_string_formatting = 1
let python_highlight_string_format = 1
let python_highlight_string_templates = 1
let python_highlight_indent_errors = 1
let python_highlight_space_errors = 0
let python_print_as_function = 1

" }}}
" Syntastic {{{

let g:syntastic_mode_map = { 'passive_filetypes' : ['cpp', 'spec'] }
let g:syntastic_check_on_open = 1
let g:syntastic_python_checkers = ['pyflakes']
let g:syntastic_stl_format = "%E{Err: %e(%fe)}%B{, }%W{Warn: %w(%fw)}"

let g:syntastic_enable_signs = 1
let g:syntastic_error_symbol = "➤"
let g:syntastic_style_error_symbol = "▷"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_style_warning_symbol = "⚠"

" }}}
" Unite {{{

let g:unite_enable_start_insert = 1
let g:unite_winheight = 10
let g:unite_split_rule = 'botright'
let g:unite_prompt = '» '

" Always use the fuzzy matcher.
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom#source(
    \ 'file,file/new,buffer,line',
    \ 'matchers', 'matcher_fuzzy')

" Disable mru
let g:unite_source_mru_do_validate=0
let g:unite_source_mru_update_interval=0

if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
    let g:unite_source_grep_recursive_opt = ''
endif

"nnoremap <C-e> :<C-u>Unite file_rec/async<CR>
nnoremap <C-e> :<C-u>Unite file<CR>
nnoremap <C-b> :<C-u>Unite buffer<CR>
nnoremap <C-g> :<C-u>Unite grep:.<CR>
nnoremap <C-t> :<C-u>Unite tasklist<CR>
nnoremap <C-f> :<C-u>Unite -buffer-name=search -start-insert line<CR>

" }}}
" YouCompleteMe {{{

let g:ycm_confirm_extra_conf = 0
let g:ycm_always_populate_location_list = 1

"let g:ycm_server_use_vim_stdout = 1
"let g:ycm_server_log_level = 'debug'

nnoremap <Leader>j :YcmCompleter GoToDefinition<CR>
nnoremap <Leader>dd :YcmDiags<CR>

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" }}}

" }}}
