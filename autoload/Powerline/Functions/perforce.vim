function! Powerline#Functions#perforce#GetStatus()
    let ruler = perforce#RulerStatus()
    "let ruler = substitute(ruler, '\v\[([^:]+):(\S) (#\d+)/(\d+)\]', '\1/\2', 'g')
    return ruler
endfunction
