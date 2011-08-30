" local syntax file - set colors on a per-machine basis:
" vim: tw=0 ts=4 sw=4
" Vim color file
" Maintainer:	Cory Omand <comand@pixar.com>
" Last Change:	2006 June 29
" Based On:     zellner.vim

set background=light
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "comand"

hi Comment term=bold ctermfg=Blue guifg=Blue
hi Normal guifg=black guibg=white
hi Constant term=underline ctermfg=Magenta guifg=Magenta
hi Special term=bold ctermfg=Magenta guifg=Magenta
hi Identifier term=underline ctermfg=Blue guifg=Blue
hi Statement term=bold ctermfg=Brown gui=NONE guifg=Brown
hi PreProc term=underline ctermfg=Red guifg=Red
hi Type term=underline ctermfg=Blue gui=NONE guifg=Blue
hi Visual term=reverse ctermfg=Black ctermbg=Yellow gui=NONE guifg=Black guibg=Yellow
hi Search term=reverse ctermfg=Black ctermbg=Cyan gui=NONE guifg=Black guibg=Cyan
hi Tag term=bold ctermfg=DarkGreen guifg=DarkGreen
hi Error term=reverse ctermfg=15 ctermbg=9 guibg=Red guifg=White
hi Todo term=standout ctermbg=Yellow ctermfg=Black guifg=Blue guibg=Yellow
hi StatusLine term=bold,reverse cterm=NONE ctermfg=Yellow ctermbg=DarkGray gui=NONE guifg=Yellow guibg=DarkGray
hi String term=underline ctermfg=DarkGreen guifg=DarkGreen
hi! link MoreMsg Comment
hi! link ErrorMsg Visual
hi! link WarningMsg ErrorMsg
hi! link Question Comment
hi link Character	Constant
hi link Number	Constant
hi link Boolean	Constant
hi link Float		Number
hi link Function	Identifier
hi link Conditional	Statement
hi link Repeat	Statement
hi link Label		Statement
hi link Operator	Statement
hi link Keyword	Statement
hi link Exception	Statement
hi link Include	PreProc
hi link Define	PreProc
hi link Macro		PreProc
hi link PreCondit	PreProc
hi link StorageClass	Type
hi link Structure	Type
hi link Typedef	Type
hi link SpecialChar	Special
hi link Delimiter	Special
hi link SpecialComment Special
hi link Debug		Special

hi FoldColumn  gui=bold    guifg=grey65     guibg=Grey90
hi Folded      gui=italic  guifg=Black      guibg=Grey90
hi LineNr      gui=NONE    guifg=grey60     guibg=Grey90

hi doxygenBrief gui=italic guifg=#006600
hi doxygenComment gui=italic guifg=#669966
hi doxygenSmallSpecial gui=bold guifg=#006600
hi doxygenParam gui=bold guifg=#669966
hi doxygenSpecial gui=bold guifg=#669966
hi doxygenHtmlSpecial gui=bold guifg=#669966
hi doxygenPrev gui=bold guifg=#669966
hi doxygenSymbol gui=bold guifg=#006600
hi doxygenBOther gui=bold guifg=#669966
hi doxygenSpecialTypeOnelineDesc gui=italic,bold guifg=Blue
hi doxygenSpecialOnelineDesc gui=italic guifg=Blue
hi doxygenSpecialMultilineDesc gui=italic guifg=Blue
hi doxygenSpecialHeading gui=italic guifg=Blue
hi doxygenFormula gui=italic guifg=Blue

