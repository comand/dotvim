" Preamble --------------------------------------------------------------- {{{

filetype off
source ~/.vim/bundles.vim
filetype plugin indent on
set nocompatible

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
set synmaxcol=160
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

" Window title
let &titlestring="%{expand('%:p:h:t')}/%t @ %{expand($TREE)}:%{expand($FLAVOR)}"
set title

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
    "set guifont=SourceCodePro\ 10
    "set guifont=DroidSansMono\ 10
    set guifont=Consolas\ 11
    "set guifont=Inconsolata\ Medium\ 12
    "set guifont=Anonymous\ Pro\ 12

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

augroup filetypedetect
    au! BufRead,BufNewFile *.dox setf doxygen
augroup END

augroup ft_perl
    au!
    au BufNewFile,BufRead *.t setf perl
    au FileType perl,tcl,css setlocal smartindent
augroup END

augroup ft_web
    au!
    au FileType html,xhtml,css,xml setlocal fo+=l ts=2 sw=2
augroup END

augroup ft_sieve
    au!
    au BufNewFile,BufRead .sieverc setf sieve
    au FileType sieve setlocal ts=2 sw=2
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
    au BufNewFile,BufRead .vimrc setlocal fen fdm=marker foldtext=VimrcFold()
augroup END

augroup ft_make
    au!
    au FileType make setlocal noet ts=8 sw=8 list
augroup END

augroup ft_perforce
    au!
    au FileType perforce setlocal noet ts=4 sw=4 tw=78
augroup END

augroup ft_python
    au!
    au BufNewFile,BufRead SConscript*,SConstruct* setf python
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
    au FileType cpp let OmniCpp_ShowPrototypeInAbbr = 1
    au FileType cpp let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]

    " Tag files
    au FileType cpp call AddTags('~/.vim/tags', ['boost', 'opengl', 'oracle'])
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
nnoremap <C-S> :,$s/\<<C-R><C-W>\>/

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

" Quit with confirmation
nnoremap <Leader>q :confirm qa<CR>

" Change directory to current buffer
nnoremap <Leader>cd :cd %:p:h<CR>:pwd<CR>

" Close the current buffer
nnoremap <Leader>w :bdelete<CR>

" Always use magic regexes
nnoremap / /\v
vnoremap / /\v

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
" NeoComplete {{{

let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 2
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
let g:neocomplete#enable_auto_select = 0
let g:neocomplete#data_directory = '/var/tmp/neocomplete'

" Enable omni completion.
au FileType css setlocal omnifunc=csscomplete#CompleteCSS
au FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
au FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"au FileType python setlocal omnifunc=pythoncomplete#Complete
au FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Define keyword
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Configure python completion
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.python = '[^. \t]\.\w*'

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" <CR> closes popup and saves indent
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return neocomplete#smart_close_popup() . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction

" Key mappings.
inoremap <expr><C-g> neocomplete#undo_completion()
inoremap <expr><C-l> neocomplete#complete_common_string()
" <TAB> completion
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char
inoremap <expr><C-h> neocomplete#smart_close_popup() . "\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup() . "\<C-h>"
inoremap <expr><C-y> neocomplete#close_popup()
inoremap <expr><C-e> neocomplete#cancel_popup()

" Source configuration
"function s:configure_include_sources()
    "let instdir = finddir('inst', '.;')
    "if !empty(instdir)
        "let idirs = join(split(globpath(instdir, '*/*/include'), '\n'), ',')
        "if !empty(idirs)
            "call neocomplete#util#set_default_dictionary(
                "\ 'g:neocomplete#sources#include#paths',
                "\ 'cpp,h', '/dist/shows/shared/include,' . idirs)
        "endif
    "endif
"endfunction

"au FileType cpp,h call s:configure_include_sources()

" }}}
" Jedi {{{

let g:jedi#auto_vim_configuration = 0
let g:jedi#popup_select_first = 0
let g:jedi#popup_on_dot = 0

" }}}
" UltiSnips {{{

let g:UltiSnipsSnipptsDir = "~/.vim/UltiSnips"

" }}}
" Syntastic {{{

"let g:syntastic_mode_map = { 'passive_filetypes' : ['cpp'] }
let g:syntastic_enable_signs = 1
let g:syntastic_check_on_open = 1
let g:syntastic_python_checkers = ['pyflakes']
let g:syntastic_cpp_checkers = ['cppcheck']
let g:syntastic_stl_format = "%E{Err: %e(%fe)}%B{, }%W{Warn: %w(%fw)}"

" }}}
" Perforce {{{

let g:p4EnableRuler=0
let g:p4CurDirExpr="(isdirectory(expand('%')) ? substitute(expand('%:p'), '\\\\$', '', '') : '')"

" }}}
" IndentLine {{{

let g:indentLine_char = "|"
let g:indentLine_first_char = "|"
let g:indentLine_fileType = ['python']
let g:indentLine_color_gui = "Grey85"

" }}}
" Grok {{{

let g:grok_server = 'grok.pixar.com'
let g:grok_project = 'mainline'
map <Leader>gf :call grok#FullSearch()<CR>
map <Leader>gd :call grok#DefinitionSearch()<CR>
map <Leader>gs :call grok#SymbolSearch()<CR>
map <Leader>gx :call grok#XRef()<CR>

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
" Unite {{{

let g:unite_enable_start_insert = 1
let g:unite_winheight = 10
let g:unite_split_rule = 'botright'
let g:unite_prompt = '» '

" Always use the fuzzy matcher.
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])

" Disable mru
let g:unite_source_mru_do_validate=0
let g:unite_source_mru_update_interval=0

"nnoremap <C-e> :<C-u>Unite file_rec/async<CR>
nnoremap <C-e> :<C-u>Unite file<CR>
nnoremap <C-b> :<C-u>Unite buffer<CR>
nnoremap <C-f> :<C-u>Unite grep:.<CR>
nnoremap <leader>t :<C-u>Unite tasklist<CR>

" }}}

" }}}
" Build Configuration ---------------------------------------------------- {{{

" Tags
if !empty($SRCROOT)
    set tags=$SRCROOT/dev/.tags
else
    set tags=.tags
endif

" Make program
if !empty(findfile('SConscript', '.')) || !empty(findfile('SConstruct', '.'))
    set makeprg=scons
elseif !empty(findfile('Makefile', '.'))
    set makeprg=gmake
elseif !empty(findfile('build.xml', '.'))
    set makeprg=ant
endif

nnoremap <F6> :make<CR>
au QuickFixCmdPost make :cwin

" }}}
" Custom Functions ------------------------------------------------------- {{{

" Open Perforce timelapse view for the current file.
function! P4vc_Tlv()
    silent execute "!p4vc tlv " . expand("%")
endfunction
command! Tlv call P4vc_Tlv()

" Open Qt doc for class name under the cursor.
function! QtClassDoc(classname)
    let qt_dir = "/pixar/d2/sets/tools-39/doc/html/"
    let doc_file = qt_dir . tolower(a:classname) . ".html"
    silent execute "!xdg-open " . doc_file | redraw!
endfunction

map <Leader>qt :call QtClassDoc(expand("<cword>"))<CR>
command! -nargs=1 Qt call QtClassDoc(<f-args>)

" Launch a terminal in the current working directory
function! Terminal()
    silent execute "!gnome-terminal --working-directory=" . getcwd() | redraw!
endfunction
map <Leader>r :call Terminal()<CR>

function! RunTest()
    execute "!echo " . expand('%:t:r') . " | scons -u runtest"
endfunction
map <F7> :call RunTest()<CR>

" }}}
