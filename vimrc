" * NeoBundle {{{
" *

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
    \     'windows' : 'make -f make_mingw32.mak',
    \     'cygwin' : 'make -f make_cygwin.mak',
    \     'unix' : 'make -f make_unit.mak',
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
NeoBundle 'davidhalter/jedi-vim'

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

" }}}
" * Platform {{{
" *

set encoding=utf-8

if has('win32')
    set directory=.,$TEMP
endif

" }}}
" * User Interface {{{
" *

" Syntax highlighting
syntax on
syntax sync fromstart
let g:is_posix = 1

" Color scheme
colorscheme comand
set t_Co=256

" No hilight search by default
set nohlsearch

" Show commands as they're typed
set showcmd

" Update the xterm title
set title

" Keep 1000 lines of command history
set history=1000

" Allow buffer switch without saving
set hidden

if has('persistent_undo')
    set undofile
    set undolevels=1000  " Maximum number of changes that can be undone.
    set undoreload=10000 " Maximum number of lines to save for undo on a reload.
endif

" Status line configuration
set report=0
set noruler
set laststatus=2

" Allow the cursor to move freely in virtual block mode (Ctrl-V)
set virtualedit=block

" Find using cdpath
let &path = ',' . substitute($CDPATH, ':', ',', 'g')

" Remember info for 10 files, no marks, don't re-highlight search patterns,
" only save up to 100 lines of registers, restrict input buffer
"set viminfo=/10,'10,f0,h,\"100,@10
set viminfo='50,\"1000,s100

" Command-line completion
set wildmode=list:longest,full

" When in list mode, keep tabs normal width, display arrows,
" trailing spaces display '-' characters.
"set listchars+=tab:>>,trail:-
set listchars=tab:\ ·,eol:¬
set listchars+=trail:·
set listchars+=extends:»,precedes:«

" Set window min width/height
set wmw=0
set wmh=0

" Automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
"set completeopt=menuone,menu,longest,preview
set completeopt=longest,menuone

" Disable folding by default
if has('folding')
    set nofoldenable
endif

" }}}
" * Text Formatting {{{
" *

" Don't automatically wrap text.
set nowrap

" Indents of 4 spaces, have them copied down lines
set tabstop=4
set shiftwidth=4
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
" * Build Configuration {{{
" *

" Tags
if !empty($SRCROOT)
    set tags=$SRCROOT/dev/.tags
else
    set tags=.tags
endif

" Make program
if !empty(findfile('SConscript')) || !empty(findfile('SConstruct'))
    set makeprg=scons
elseif !empty(findfile('Makefile'))
    set makeprg=gmake
elseif !empty(findfile('build.xml'))
    set makeprg=ant
endif

nnoremap <F6> :make<CR>
au QuickFixCmdPost make :cwin
"noremap <F6> :silent! :make \| :redraw! \| :botright :cw<cr>

" }}}
" * File Format Options {{{
" *

autocmd FileType perl,tcl,css set smartindent
autocmd FileType html,xhtml,css,xml set fo+=l ts=2 sw=2
autocmd FileType twiki,confluencewiki set tw=0 wrap fo+=l
autocmd FileType sieve set ts=2 sw=2
autocmd FileType human set wrap linebreak tw=78

" }}}
" * Keystrokes: General {{{
" *

let mapleader = ','
let g:mapleader = ','

" }}}
" * Keystrokes: Movement {{{
" *

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
" * Keystrokes: Formatting {{{
" *

" have Y behave analogously to D and C rather than to dd and cc (which is
" already done by yy):
noremap Y y$

" Search and replace word under cursor.
nnoremap <C-S> :,$s/\<<C-R><C-W>\>/

" }}}
" * Keystrokes: Toggles {{{
" *

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

" Toggle Gundo window.
nnoremap <F10> :GundoToggle<CR>

" Toggle fold open/close
nnoremap <space> za
vnoremap <space> zf

" }}}
" * Keystrokes: Misc {{{
" *

" Show the absolute path of the current buffer.
nnoremap <M-g> :echo expand("%:p")<CR>

" Quit with confirmation
nnoremap <leader>q :confirm qa<CR>

" Change directory to current buffer
map <leader>cd :cd %:p:h<CR>

" Change working directory to buffer automatically
"set autochdir
" Switch directory back to buffer
"nnoremap ,cd :cd %:p:h<CR>

" }}}
" * Plugin Configuration {{{
" *

" NeoComplete {{{
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" <CR> closes popup and saves indent
function! s:my_cr_function()
    return neocomplete#smart_close_popup() . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction

" Neocomplete.vim plugin key-mappings.
inoremap <expr><C-g> neocomplete#undo_completion()
inoremap <expr><C-l> neocomplete#complete_common_string()
" <TAB> completion
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char
inoremap <expr><C-h> neocomplete#smart_close_popup() . "\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup() . "\<C-h>"
inoremap <expr><C-y> neocomplete#close_popup()
inoremap <expr><C-e> neocomplete#cancel_popup()

" }}}

" Jedi {{{
let g:neocomplete#enable_auto_select = 0
let g:jedi#popup_select_first = 0
let g:jedi#auto_vim_configuration = 0
"}}}

" UltiSnips {{{
let g:UltiSnipsSnippetDirectories = ["UltiSnips", "snippets"]
" }}}

" Syntastic {{{
let g:syntastic_mode_map = { 'passive_filetypes' : ['cpp'] }
let g:syntastic_check_on_open = 1
let g:syntastic_python_checkers = ['pyflakes']
" }}}

" Perforce {{{
let g:p4EnableRuler=0
let g:p4CurDirExpr="(isdirectory(expand('%')) ? substitute(expand('%:p'), '\\\\$', '', '') : '')"
" }}}

" Tag list {{{
nmap <F9> :TlistToggle<CR>
let Tlist_Close_On_Select=1
let Tlist_Display_Prototype=1
let Tlist_Display_Tag_Scope=0
let Tlist_Enable_Fold_Column=0
let Tlist_Exit_Only_Window=1
let Tlist_GainFocus_On_ToggleOpen=1
let Tlist_Show_One_File=1
let Tlist_WinWidth=50
" }}}

" Lusty {{{
nmap <C-e> :LustyFilesystemExplorer<CR>
nmap <C-B> :LustyBufferExplorer<CR>
nmap <C-f> :LustyBufferGrep<CR>
" }}}

" Task list {{{
let g:tlWindowPosition = 1
nnoremap <silent> <F8> :TaskList<CR>
" }}}

" Powerline {{{
let g:Powerline_symbols = 'fancy'
let g:Powerline_theme = 'comand'
let g:Powerline_colorscheme = 'comand'
let g:Powerline_cache_file = expand('$TEMP') . '/Powerline_comand_comand_fancy.cache'
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
map <leader>gf :call grok#FullSearch()<CR>
map <leader>gd :call grok#DefinitionSearch()<CR>
map <leader>gs :call grok#SymbolSearch()<CR>
map <leader>gx :call grok#XRef()<CR>
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
let python_highlight_all = 1
" }}}

" }}}
" * Custom Functions {{{
" *

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

map <leader>qt :call QtClassDoc(expand("<cword>"))<CR>
command! -nargs=1 Qt call QtClassDoc(<f-args>)

" Launch a terminal in the current working directory
function! Terminal()
    silent execute "!gnome-terminal --working-directory=" . getcwd() | redraw!
endfunction
map <leader>r :call Terminal()<CR>

"}}}
