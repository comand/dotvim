" Preamble --------------------------------------------------------------- {{{

source ~/.vim/plug.vim
filetype plugin indent on
syntax enable

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
set t_Co=256
if (has("termguicolors"))
    set termguicolors
endif

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

    " Oooooh... pretty fonts.
    if has('win32')
        set guifont=Consolas:h11
    else
        set guifont=Inconsolata\ Nerd\ Font\ 12
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
    autocmd FileType qf setlocal colorcolumn=0 nolist nocursorline nowrap tw=0
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
    autocmd FileType cpp setlocal cindent cinoptions=':0,g0,l1,t0,(0,W4,M1'
    autocmd FileType cpp setlocal formatoptions=croql
    autocmd FileType cpp setlocal colorcolumn=+3

    " Doxygen comments
    autocmd FileType cpp setlocal comments-=://
    autocmd FileType cpp setlocal comments+=://!,:///,://
    autocmd FileType cpp let g:load_doxygen_syntax = 1
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
vmap <F1> <C-C><F1>
omap <F1> <C-C><F1>
map! <F1> <C-C><F1>

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

nmap <F7> <Plug>QfCtoggle
nmap <F8> <Plug>QfLtoggle

" }}}
" Plugin Configuration --------------------------------------------------- {{{

" Asyncrun {{{

command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>
nnoremap <F6> :Make<CR>

" }}}
" Airline {{{

let g:airline_detect_spell = 0
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

" }}}
" Alternate {{{

nmap <C-H> :A<CR>

" }}}
" AutoPairs {{{

" Don't interfere with trying to close blocks within blocks...
let g:AutoPairsMultilineClose=0

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
" Fzf {{{

let g:fzf_command_prefix = 'Fzf'

" Customize fzf colors
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

nnoremap <F1> :FzfHelptags<CR>

cnoremap <C-f> :FzfHistory:<CR>
nnoremap q: :FzfHistory:<CR>
nnoremap q/ :FzfHistory/<CR>

nnoremap <C-e> :<C-u>FzfFiles<CR>
nnoremap <C-b> :<C-u>FzfBuffers<CR>
nnoremap <C-g> :<C-u>Rg<CR>

nnoremap <Leader>fl :<C-u>FzfLines<CR>
nnoremap <Leader>fm :<C-u>FzfMaps<CR>
nnoremap <Leader>fs :<C-u>FzfSnippets<CR>
nnoremap <Leader>ft :<C-u>Rg <C-R><C-W><CR>
nnoremap <Leader>fb :<C-u>FzfLines <C-R><C-W><CR>
nnoremap <Leader>fx  :<C-u>Rg XXX<CR>

" }}}
" Incsearch {{{

map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(gincsearch-stay)

" Very.
let g:incsearch#magic = '\v'

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
" NERDTree {{{

map <F5> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen=1

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
" Solarized {{{

" Color scheme
let g:solarized_termcolors=256
colorscheme solarized

" Set the sign column to the solarized line number column background.
highlight! link SignColumn LineNr

" }}}
" Syntastic {{{

let g:syntastic_mode_map = { 'passive_filetypes' : ['cpp', 'spec'] }
let g:syntastic_check_on_open = 1
let g:syntastic_python_checkers = ['frosted']
let g:syntastic_stl_format = "%E{Err: %e(%fe)}%B{, }%W{Warn: %w(%fw)}"

let g:syntastic_enable_signs = 1
let g:syntastic_error_symbol = "\uF101"
let g:syntastic_style_error_symbol = "\uF101"
let g:syntastic_warning_symbol = "\uF105"
let g:syntastic_style_warning_symbol = "\uF105"

" }}}
" Vim-G {{{

nnoremap <Leader>gg :Google<CR>
vnoremap <Leader>gg :Google<CR>

" }}}
" Vim-Plug {{{

let g:plug_window = '-tabnew'
let g:plug_pwindow = 'vertical rightbelow new'

function! s:scroll_preview(down)
  silent! wincmd P
  if &previewwindow
    execute 'normal!' a:down ? "\<c-e>" : "\<c-y>"
    wincmd p
  endif
endfunction

function! s:setup_extra_keys()
  nnoremap <silent> <buffer> J :call <sid>scroll_preview(1)<cr>
  nnoremap <silent> <buffer> K :call <sid>scroll_preview(0)<cr>
  nnoremap <silent> <buffer> <c-n> :call search('^  \X*\zs\x')<cr>
  nnoremap <silent> <buffer> <c-p> :call search('^  \X*\zs\x', 'b')<cr>
  nmap <silent> <buffer> <c-j> <c-n>o
  nmap <silent> <buffer> <c-k> <c-p>o
  nmap <silent> <buffer> q tabclose
endfunction

augroup PlugDiffExtra
  autocmd!
  autocmd FileType vim-plug call s:setup_extra_keys()
augroup END

" }}}
" YouCompleteMe {{{

" debugging flags
"let g:ycm_server_use_vim_stdout = 1
"let g:ycm_server_log_level = 'debug'
"let g:ycm_server_keep_logfiles = 1

let g:ycm_confirm_extra_conf = 0
let g:ycm_always_populate_location_list = 1
let g:ycm_complete_in_comments = 1
let g:ycm_max_diagnostics_to_display = 100

nnoremap <Leader>gd :YcmCompleter GetDoc<CR>
nnoremap <Leader>jd :YcmCompleter GoToImprecise<CR>
nnoremap <Leader>yf :YcmCompleter FixIt<CR>
nnoremap <Leader>dd :YcmDiags<CR>

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
"let g:SuperTabDefaultCompletionType = '<C-n>'
let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabContextDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" }}}

" }}}
