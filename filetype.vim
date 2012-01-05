" Custom file type detection
if exists('did_load_filetypes')
    finish
endif
augroup filetypedetect
    au! BufRead,BufNewFile *.txt setf human
    au! BufRead,BufNewFile *.t   setf perl
    au! BufRead,BufNewFile *.dox setf doxygen
    au! BufRead,BufNewFile *.menva setf menva
    au! BufRead,BufNewFile .sieverc setf sieve
    au! BufRead,BufNewFile SConscript*,SConstruct setf python
    au! BufRead,BufNewFile */itsalltext/menv30-wiki.pixar.com*,*.twiki setf twiki
    au! BufRead,BufNewFile */itsalltext/wiki.pixar.com*,*.cwiki setf confluencewiki
augroup END
