let g:fzf_command_prefix = 'Fzf'
let g:fzf_buffers_jump = 1

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

if has('popupwin')
    let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.5 } }
else
    let g:fzf_layout = { 'window': 'rightbelow new' }
endif

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

nnoremap <F1> :FzfHelptags<CR>
cnoremap <C-f> :FzfHistory:<CR>
nnoremap q: :FzfHistory:<CR>
nnoremap q/ :FzfHistory/<CR>

nnoremap <C-e> :<C-u>FzfFiles<CR>
nnoremap <silent> <C-b> :<C-u>FzfBuffers<CR>
nnoremap <silent> <C-g> :<C-u>FzfRg<CR>
nnoremap <silent> <C-t> :<C-u>FzfBTags<CR>

nnoremap <silent> <Leader>fl :<C-u>FzfLines<CR>
nnoremap <silent> <Leader>fs :<C-u>FzfSnippets<CR>
nnoremap <silent> <Leader>ft :<C-u>FzfRg <C-R><C-W><CR>
nnoremap <silent> <Leader>fb :<C-u>FzfLines <C-R><C-W><CR>
nnoremap <silent> <Leader>fx  :<C-u>FzfRg XXX<CR>
