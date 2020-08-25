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

setlocal foldenable
setlocal foldmethod=marker
setlocal foldtext=VimrcFold()
