let g:syntastic_mode_map = { 'passive_filetypes' : ['cpp', 'spec'] }
let g:syntastic_check_on_open = 1
let g:syntastic_python_checkers = ['frosted']

let g:syntastic_enable_signs = 1
if has('gui_running')
    let g:syntastic_error_symbol = g:error_symbol
    let g:syntastic_style_error_symbol = g:error_symbol
    let g:syntastic_warning_symbol = g:warning_symbol
    let g:syntastic_style_warning_symbol = g:warning_symbol
endif
