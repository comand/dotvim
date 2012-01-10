" * Pathogen {{{
" *

runtime bundle/pathogen/autoload/pathogen.vim
let g:pathogen_disabled = []

if !has('ruby')
    call add(g:pathogen_disabled, 'LustyExplorer')
endif

" Check and disable source control modules.
let p4path = findfile('p4', substitute($PATH, ':', ',', 'g'))
if empty(p4path)
    call add(g:pathogen_disabled, 'perforce')
elseif !executable(fnamemodify(p4path, ':p'))
    call add(g:pathogen_disabled, 'perforce')
endif

call pathogen#infect()

" }}}
" * Platform {{{
" *

if has('win32')
    set directory=.,$TEMP
endif

" }}}
" * User Interface {{{
" *

" Enable file type detection
filetype plugin indent on

" Syntax highlighting
syntax on
syntax sync fromstart
let g:is_posix = 1

" Color scheme
colorscheme comand

" No hilight search by default
set nohlsearch

" Show commands as they're typed
set showcmd

" Update the xterm title
set title

" Keep 50 lines of command history
set history=50

" Allow buffer switch without saving
set hidden

" Status line configuration
set report=0
set noruler
set laststatus=2

let g:hasGit = -1
function! ScmStatus() abort
    if g:hasGit == -1
        let g:hasGit = finddir('.git', '.;') != ""
    endif

    if g:hasGit == 1
        return fugitive#statusline()
    else
        return perforce#RulerStatus()
    endif
endfunction

set statusline=[%F%a]\ %(%r%m%h%w%y%)%=%{ScmStatus()}\ [ROW\ %04l\,\ COL\ %04c]\ [%P]

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
set completeopt=menuone,menu,longest,preview

" Disable folding by default
set nofoldenable

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

" }}}
" * Build Configuration {{{
" *

" Ctags
set tags=$SRCROOT/dev/.tags

" Refresh tags in the current tree.
map <C-F12> :!cd $SRCROOT/dev && ctags -R .<CR>

" Make program
set makeprg=/home/comand/bin/scons
nnoremap <F6> :make<CR>
au QuickFixCmdPost make :cwin

" }}}
" * File Format Options {{{
" *

autocmd FileType perl,tcl,css set smartindent
autocmd FileType html,xhtml,css,xml set fo+=l ts=2 sw=2
autocmd FileType twiki,confluencewiki set tw=0 wrap fo+=l
autocmd FileType sieve set ts=2 sw=2

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

" Toggle Gundo window.
nnoremap <F5> :GundoToggle<CR>

" Toggle highlighting of search matches, and report the change.
nnoremap \th :set invhls hls?<CR>
nmap <F8> \th

" }}}
" * Keystrokes: Misc {{{
" *

" Show the absolute path of the current buffer.
nnoremap <M-g> :echo expand("%:p")<CR>

" Quit with confirmation
nnoremap <leader>q :confirm qa<CR>

" Change directory to current buffer
map <leader>cd :cd %:p:h<CR>

" Open Qt doc for class name under the cursor.
function! QtClassDoc()
    let qt_dir = "/pixar/d2/sets/tools-39/doc/html/"
    let doc_file = qt_dir . tolower(expand("<cword>")) . ".html"
    silent execute "!xdg-open " . doc_file | redraw!
endfunction
map <leader>qt :call QtClassDoc()<CR>

" Lxr for the symbol under the cursor.
function! LxrSymbol()
    let qbase = "http://lxr.pixar.com/search?"
    let qtree  = "v=menv30"
    let qfile  = "filestring=.*\.%28h|cpp|py%29&advanced=1"
    let qopts  = "advanced=1&casesensitive=1"
    let qurl   = qbase . qtree . "&" . qfile . "&" . qopts . "&string=" . expand("<cword>")
    silent execute "!xdg-open \"" . qurl . "\"" | redraw!
endfunction
map <leader>lx :call LxrSymbol()<CR>

" }}}
" * Plugin Configuration {{{
" *

" SuperTab
"let g:SuperTabDefaultCompletionType = "context"

" Snippets
let g:UltiSnipsSnippetDirectories = ["UltiSnips", "snippets"]

" Perforce
let g:p4EnableRuler=1
let g:p4EnableActiveStatus=1
let g:p4OptimizeActiveStatus=1
let g:p4EnableMenu=1
let g:p4UseExpandedMenu=1
let g:p4CurDirExpr="(isdirectory(expand('%')) ? substitute(expand('%:p'), '\\\\$', '', '') : '')"

" Tag list
nmap <C-t> :TlistToggle<CR>
let Tlist_Close_On_Select=1
let Tlist_Display_Prototype=1
let Tlist_Display_Tag_Scope=0
let Tlist_Enable_Fold_Column=0
let Tlist_Exit_Only_Window=1
let Tlist_GainFocus_On_ToggleOpen=1
let Tlist_Show_One_File=1
let Tlist_WinWidth=50

" Directory explorer
nmap <C-e> :LustyFilesystemExplorer<CR>

" Buffer explorer
nmap <C-B> :LustyBufferExplorer<CR>
nmap <C-f> :LustyBufferGrep<CR>

" Alternate
nmap <C-H> :A<CR>

" Task list window position
let g:tlWindowPosition = 1

" CScope support
if has("cscope")
    " use both cscope and tags for 'ctrl-]', ':ta', and 'vim -t'
    "set cscopetag

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    "set csto=1

    " Search key bindings
    " ctrl-/
    "       +s: find all references to symbol under cursor
    "       +g: find global definition of symbol under cursor
    "       +c: find calls to function/method under cursor
    "       +t: find text under cursor
    "       +e: egrep search text under cursor
    "       +d: find functions that function under the cursor calls
    "       +f: open filename under cursor
    "       +i: find files that include the filename under cursor
    "
    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    "
    " display result in a hsplit
    "
    nmap <C-@>s :scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>

    " add any database in the current directory
    set nocsverb

    if filereadable("cscope.out")
        cs add cscope.out
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif

    set csverb
endif

" Diff Mode
if &diff
    nnoremap <C-R> :diffupdate<CR>
    nnoremap <C-N> ]c<CR>
    nnoremap <C-P> [c<CR>
    nnoremap <C-Q> :confirm qa<CR>
    nnoremap <C-O> do
endif

" Man pages
source $VIMRUNTIME/ftplugin/man.vim
au FileType man set nomod nolist

" }}}
