let g:Powerline#Matches#matches = {
	\ 'bt_help'         : Pl#Match#Add('&bt'         , '^help$'),
	\ 'ft_man'          : Pl#Match#Add('&ft'         , '^man$'),
	\ 'ft_qf'           : Pl#Match#Add('&ft'         , '^qf$'),
	\ 'ft_vimpager'     : Pl#Match#Add('&ft'         , 'vimpager'),
	\ 'gundo_preview'   : Pl#Match#Add('bufname("%")', '^__Gundo_Preview__$'),
	\ 'gundo_tree'      : Pl#Match#Add('bufname("%")', '^__Gundo__$'),
	\ 'le_buffers'      : Pl#Match#Add('bufname("%")', 'LustyExplorer-Buffers'),
	\ 'le_files'        : Pl#Match#Add('bufname("%")', 'LustyExplorer-Files'),
	\ 'le_grep'         : Pl#Match#Add('bufname("%")', 'LustyExplorer-BufferGrep'),
    \ 'taglist'         : Pl#Match#Add('bufname("%")', '^__Tag_List__$'),
\ }
