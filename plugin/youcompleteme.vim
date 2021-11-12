" debugging flags
"let g:ycm_server_use_vim_stdout = 1
"let g:ycm_server_log_level = 'debug'
"let g:ycm_server_keep_logfiles = 1

let g:ycm_always_populate_location_list = 1
let g:ycm_complete_in_comments = 1
let g:ycm_max_diagnostics_to_display = 100
let g:ycm_auto_hover = ''

if has('gui_running')
    let g:ycm_error_symbol = g:error_symbol
    let g:ycm_warning_symbol = g:warning_symbol
endif

let g:ycm_clangd_binary_path = "/home/comand/.local/opt/llvm-12/bin/clangd"

let g:ycm_filter_diagnostics = {
    \ "cpp": {
    \     "regex": [
    \       "must specify at least one argument for.*parameter of variadic macro",
    \       "XOPEN_SOURCE",
    \       "-fno-canonical-system-headers",
    \       "-fstack-reuse=none",
    \       "-ftrack-macro-expansion=0",
    \       "-fvect-cost-model=.*",
    \       "-mtune-ctrl=.*",
    \       "-Wno-unused-but-set-variable",
    \       ],
    \     }
    \ }

nnoremap <Leader>yg :YcmCompleter GoToImprecise<CR>
nnoremap <Leader>yf :YcmCompleter FixIt<CR>
nnoremap <Leader>yt :YcmCompleter GetType<CR>
nnoremap <Leader>ya :YcmDiags<CR>
nnoremap <Leader>yd :YcmShowDetailedDiagnostic<CR>

function! s:CustomizeYcmLocationWindow()
    " Set the window height, switch back to working window
    10wincmd _
    wincmd p
endfunction

autocmd User YcmLocationOpened call s:CustomizeYcmLocationWindow()

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabContextDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
