" Vim/GVim RC file
"

let mapleader = ','

if has('win32')
    set directory=.,$TEMP
endif

" *
" * Plugins
" *

filetype off

let g:pathogen_disabled = []

if !has('ruby')
    call add(g:pathogen_disabled, 'LustyExplorer')
endif

" XXX:comand 2011-12-18 WBN if this could check for 'p4' in $PATH.
if !findfile('$HOME/bin/p4')
    call add(g:pathogen_disabled, 'perforce')
endif

call pathogen#infect()

" enable file type detection
filetype plugin indent on

" *
" * User Interface
" *

" turn on syntax highlighting
syntax enable
syntax sync fromstart
colorscheme comand

" Turn off scroll bar.
set guioptions-=r

" No hilight search by default
set nohlsearch

" Searches don't wrap
"set nowrapscan

" Update the xterm title
set title

" keep 50 lines of command history
set history=50

" Allow buffer switch without saving
set hidden

" status line configuration
set report=0
set noruler
set laststatus=2

function! ScvStatus()
    if exists('perforce_loaded')
        return perforce#RulerStatus()
    endif
    return ""
endfunction

set statusline=[%F%a]\ %(%r%m%h%w%y%)%=%{ScvStatus()}\ [ROW\ %04l\,\ COL\ %04c]\ [%P]

" remember info for 10 files, no marks, don't rehighlight search patterns,
" only save up to 100 lines of registers, restrict input buffer
"set viminfo=/10,'10,f0,h,\"100,@10
set viminfo='50,\"1000,s100

" command-line completion
set wildmode=list:longest,full

" display current mode and partially typed commands
set showmode
set showcmd 

" when in list mode, keep tabs normal width, display arrows,
" trailing spaces display '-' characters.
set listchars+=tab:>>,trail:-

" Set window min width/height
set wmw=0
set wmh=0

" *
" * Text Formatting -- General
" *

" don't make it look like there are line breaks when there aren't
set nowrap

" indents of 4 spaces, have them copied down lines
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent

" Keep N lines of the file visible above/below the cursor
set scrolloff=10

" Normally don't automatically format text as typed, except in comments
"set formatoptions-=t
set textwidth=78

" treat lines starting with a quote mark as comments (e.g. vimrc)
set comments+=b:\"

" Read tags
set tags=$SRCROOT/dev/.tags
set tags+=~/.vim/tags/cpp
"set tags+=~/.vim/tags/opengl
set tags+=~/.vim/tags/qt
set tags+=~/.vim/tags/p4
"set tags+=~/.vim/tags/oracle
"set tags+=~/.vim/tags/boost

" Refresh tags in the current tree.
map <C-F12> :!cd $SRCROOT/dev && ctags -R .<CR>

" Search and replace word under cursor.
nnoremap <C-S> :,$s/\<<C-R><C-W>\>/

" Reselect visual block after in/dedent.
"vnoremap < <gv
"vnoremap > >gv

" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1
let OmniCpp_MayCompleteDot = 1
let OmniCpp_MayCompleteArrow = 1
let OmniCpp_MayCompleteScope = 1
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]

"let g:SuperTabDefaultCompletionType = "context"

" Automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

" *
" * Text Formatting -- Specific File Formats
" *

" add new file types
augroup filetype
    au!
    au BufNewFile,BufEnter *.txt set filetype=human
    au BufNewFile,BufEnter *.t   set filetype=perl
    au BufNewFile,BufEnter *.i   set filetype=c
    au BufNewFile,BufEnter *.dox set filetype=doxygen
    au BufNewFile,BufEnter *.menva set filetype=menva
    au BufNewFile,BufEnter .sieverc set filetype=sieve
    au BufNewFile,BufEnter SConscript* set filetype=python
    au BufEnter */itsalltext/menv30-wiki.pixar.com* set filetype=twiki
    au BufEnter */itsalltext/wiki.pixar.com* set filetype=confluencewiki
    au BufEnter *.twiki set filetype=twiki
    au BufEnter *.cwiki set filetype=confluencewiki
augroup END

" load doxygen syntax for c/c++/idl
let g:load_doxygen_syntax = 1

" in human-language files, automatically format to 78 chars
autocmd FileType human set fo+=t tw=78

autocmd FileType perforce set textwidth=78 noet ts=4 sw=4

" for C-like programming, turn on auto-indent, set options
autocmd FileType c,cpp set cin cino=:0,g0,l1,t0,(0,W4,M1 fo=croq ts=4 et cc=+3

" for actual C (not C++), if starting a new line in the middle of a
" comment, automatically insert the comment leader chars.
autocmd FileType c set formatoptions+=ro

" for Perl, Tcl and CSS programming, have things in braces indent themselves
autocmd FileType perl,tcl,css set smartindent

" for HTML, generally format text, but if a long line has been created,
" leave it alone when editing.
autocmd FileType html,xhtml,xml set formatoptions+=tl

" for both CSS and HTML
autocmd FileType html,xhtml,css,xml set et ts=2 sw=2

" in makefiles, don't expand tabs
autocmd FileType make set noet tw=78 sw=8 ts=8 fo+=t list

autocmd FileType doxygen,cpp.doxygen set comments-=:// comments+=://!:///,://
autocmd FileType cpp nmap <C-,> :make<cr>

autocmd FileType twiki set tw=0 wrap

autocmd FileType confluencewiki set tw=0 wrap

" sieve
autocmd FileType sieve set ts=2 sw=2 et

set makeprg=/home/comand/bin/scons
nnoremap <F6> :make<CR>
au QuickFixCmdPost make :cwin

nnoremap <M-g> :echo expand("%:p")<CR>

augroup Python
    au!
    "au BufNewFile *.py 0read ~/.vim/templates/python.py
    au FileType python set ai si sts=4 sw=4 tw=78 fo=croqt cc=+3
    au FileType python inoremap # X#
    "nmap <F7> :w\|!pychecker %<cr>
    set omnifunc=pythoncomplete#Complete
    set comments-=:%
augroup END

" *
" * Folding Setup
" *

"if has('folding')
"    " Per-filetype folding settings
"    set nofoldenable
"    set fdls=2 fdc=3 fdn=2
"    au FileType python set fen fdm=indent
"    au FileType c,cpp  set fen fdm=syntax 
"
"    nmap <F12> zi
"
"    " Set a nicer foldtext function
"    set foldtext=MyFoldText()
"    function! MyFoldText()
"      let line = getline(v:foldstart)
"      if match( line, '^[ \t]*\(\/\*\|\/\/\)[*/\\]*[ \t]*$' ) == 0
"        let initial = substitute( line, '^\([ \t]\)*\(\/\*\|\/\/\)\(.*\)', '\1\2', '' )
"        let linenum = v:foldstart + 1
"        while linenum < v:foldend
"          let line = getline( linenum )
"          let comment_content = substitute( line, '^\([ \t\/\*]*\)\(.*\)$', '\2', 'g' )
"          if comment_content != ''
"            break
"          endif
"          let linenum = linenum + 1
"        endwhile
"        let sub = initial . ' ' . comment_content
"      else
"        let sub = line
"        let startbrace = substitute( line, '^.*{[ \t]*$', '{', 'g')
"        if startbrace == '{'
"          let line = getline(v:foldend)
"          let endbrace = substitute( line, '^[ \t]*}\(.*\)$', '}', 'g')
"          if endbrace == '}'
"            let sub = sub.substitute( line, '^[ \t]*}\(.*\)$', '...}\1', 'g')
"          endif
"        endif
"      endif
"      let n = v:foldend - v:foldstart + 1
"      let info = " " . n . " lines"
"      let sub = sub . "                                                                                                                  "
"      let num_w = getwinvar( 0, '&number' ) * getwinvar( 0, '&numberwidth' )
"      let fold_w = getwinvar( 0, '&foldcolumn' )
"      let sub = strpart( sub, 0, winwidth(0) - strlen( info ) - num_w - fold_w - 1 )
"      return sub . info
"    endfunction
"endif

" *
" * Search & Replace
" *

" make searches case-insensitive, unless there is an upcase letter
set ignorecase
set smartcase

" show 'best match so far' as strings are typed
set incsearch

" assume /g flag is on for :s substitutions
set gdefault

" *
" * Completion and Spelling
" *

" correct common typos in insert mode
iabbrev alos        also
iabbrev aslo        also
iabbrev becuase     because
iabbrev teh         the
iabbrev bianry      binary
iabbrev seperate    separate
iabbrev tpyo        typo
iabbrev colour      color
iabbrev centre      center
iabbrev cheque      check
iabbrev prnt        print
iabbrev prnit       print
iabbrev wran        warn

" quick replacements for dates
iabbrev TODAY <C-R>=strftime("%B %e, %Y")<CR>
iabbrev NOW <C-R>=strftime("%a %B %e %T %Y")<CR>

" Java stuff
if &ft == 'java'
    iabbrev psfi        private static final int
    iabbrev psfl        private static final long
    iabbrev psff        private static final float
    iabbrev psfb        private static final boolean
    iabbrev psfs        private static final String
    iabbrev pesfi       protected static final int
    iabbrev pesfl       protected static final long
    iabbrev pesff       protected static final float
    iabbrev pesfb       protected static final boolean
    iabbrev pesfs       protected static final String
    iabbrev Psfi        public static final int
    iabbrev Psfl        public static final long
    iabbrev Psff        public static final float
    iabbrev Psfb        public static final boolean
    iabbrev Psfs        public static final String
    iabbrev psvm        public static void main(String[] args) {<CR>}
endif

" Perl Stuff
if &ft == 'perl'
    iabbrev #! #!/bin/perl -w
endif

" *
" * Keystrokes -- Moving Around
" *

" have the h and l cursor keys wrap between lines (like <Space> and <BkSpc> do
" by default), and ~ converts case over line breaks; also have cursor keys
" wrap in insert mode.
set whichwrap+=h,l,~,[,]

" page down with <Space> (like in lynx), page up with '-' or <BkSpc>
" noremap <Space> <PageDown>
" noremap <BS> <PageUp>
" noremap - <PageUp>
" [<Space> by default is like l, <BkSpc> like h, and - like k]

" scroll the window (but leaving the cursor in the same place) by a couple of
" lines up/down with <Ins>/<Del>
noremap <Ins> 2<C-Y>
noremap <Del> 2<C-E>
" [<Ins> by default is like i, and <Del> like x]

" use <F6> to cycle through split windows (and <Shift>+<F6> to cycle
" backwards, where possible)
"nnoremap <F6> <C-W>w
"nnoremap <S-F6> <C-W>W

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

" *
" * Keystrokes -- Formatting
" *

" have Y behave analogously to D and C rather than to dd and cc (which is
" already done by yy):
noremap Y y$

" *
" * Keystrokes -- Toggles
" *

" Keystrokes to toggle options are defined here.  They are all set to normal
" mode keystrokes beginning \t but some function keys (which won't work in all
" terminals) are also mapped.

" have \th ("toggle highlight") toggle highlighting of search matches, and
" report the change:
nnoremap \th :set invhls hls?<CR>
nmap <F8> \th

nnoremap <F5> :GundoToggle<CR>

" have \tp ("toggle paste") toggle paste on/off and report the change, and
" where possible also have <F4> do this both in normal and insert mode:
nnoremap \tp :set invpaste paste?<CR>
nmap <F4> \tp
imap <F4> <C-O>\tp
set pastetoggle=<F4>

" have \tn ("toggle number") toggle line numbering on/off, and report the
" change:
nnoremap \tn :set invnumber number?<CR>
nmap <F3> \tn
imap <F3> <C-O>\tn

" have \tl ("toggle list") toggle list on/off and report the change:
nnoremap \tl :set invlist list?<CR>
nmap <F2> \tl

" *
" * Keystrokes -- Insert Mode
" *

" allow <BkSpc> to delete line breaks, beyond the start of the current
" insertion, and over indentations:
set backspace=eol,start,indent

" *
" * Misc Applications
" *

let g:UltiSnipsSnippetDirectories = ["UltiSnips", "snippets"]
"let g:UltiSnipsJumpForwardTrigger = "<c-k>"
"let g:UltiSnipsJumpForwardTrigger = "<c-j>"

let g:p4EnableRuler=1
let g:p4EnableActiveStatus=1
let g:p4OptimizeActiveStatus=1
let g:p4EnableMenu=1
let g:p4UseExpandedMenu=1
let g:p4CurDirExpr="(isdirectory(expand('%')) ? substitute(expand('%:p'), '\\\\$', '', '') : '')"

" Spell checking
"set spelllang=en_us
"nmap <C-S><C-S> :setlocal spell!<CR>

" Tag list
nmap <C-j> :TlistToggle<CR>
let Tlist_Close_On_Select=1
let Tlist_Display_Prototype=1
let Tlist_Display_Tag_Scope=0
let Tlist_Enable_Fold_Column=0
let Tlist_Exit_Only_Window=1
let Tlist_GainFocus_On_ToggleOpen=1
let Tlist_Show_One_File=1
let Tlist_WinWidth=50

" Directory Explorer Stuff
nmap <C-e> :LustyFilesystemExplorer<CR>

" Buffer explorer
"nmap <C-B> \be
"let g:bufExplorerShowRelativePath=1
"let g:bufExplorerSortBy='number'
nmap <C-B> :LustyBufferExplorer<CR>
nmap <C-f> :LustyBufferGrep<CR>

" Alternate
nmap <C-H> :A<CR>

" Quick and dirty hex editor
augroup Binary
    au!
    au BufReadPre   *.bin let &bin=1
    au BufReadPost  *.bin if &bin | %!xxd
    au BufReadPost  *.bin set ft=xxd | endif
    au BufWritePre  *.bin if &bin | %!xxd -r
    au BufWritePre  *.bin endif
    au BufWritePost *.bin if &bin | %!xxd
    au BufWritePost *.bin set nomod | endif
augroup END

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

" Find using cdpath
let &path = ',' . substitute($CDPATH, ':', ',', 'g')
map ,e :e <C-R>=expand("%:p:h") . "/" <CR>

function! QtClassDoc()
    let qt_dir = "/pixar/d2/sets/tools-37/doc/html/"
    let doc_file = qt_dir . tolower(expand("<cword>")) . ".html"
    silent execute "!xdg-open " . doc_file | redraw!
endfunction
map ,c :call QtClassDoc()<CR>

function! LxrSymbol()
    let qbase = "http://lxr.pixar.com/search?"
    let qtree  = "v=menv30"
    let qfile  = "filestring=.*\.%28h|cpp|py%29&advanced=1"
    let qopts  = "advanced=1&casesensitive=1"
    let qurl   = qbase . qtree . "&" . qfile . "&" . qopts . "&string=" . expand("<cword>")
    silent execute "!xdg-open \"" . qurl . "\"" | redraw!
endfunction
map ,l :call LxrSymbol()<CR>

nnoremap ,q :confirm qa<CR>

let g:tlWindowPosition = 1

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

