let g:Powerline#Themes#comand#theme = Pl#Theme#Create(
	\ Pl#Theme#Buffer(''
		\ , 'paste_indicator'
		\ , 'mode_indicator'
		\ , 'fugitive:branch'
		\ , 'fileinfo'
		\ , 'syntastic:errors'
		\ , Pl#Segment#Truncate()
		\ , Pl#Segment#Split()
		\ , 'filetype'
		\ , 'scrollpercent'
		\ , 'lineinfo'
	\ ),
	\
	\ Pl#Theme#Buffer('gundo', Pl#Match#Any('gundo_tree')
		\ , ['static_str.name', 'Gundo']
		\ , ['static_str.buffer', 'Undo tree']
		\ , Pl#Segment#Truncate()
		\ , Pl#Segment#Split()
	\ ),
	\
	\ Pl#Theme#Buffer('gundo', Pl#Match#Any('gundo_preview')
		\ , ['static_str.name', 'Gundo']
		\ , ['static_str.buffer', 'Diff preview']
		\ , Pl#Segment#Truncate()
		\ , Pl#Segment#Split()
	\ ),
	\
	\ Pl#Theme#Buffer('bt_help'
		\ , ['static_str.name', 'Help']
		\ , 'filename'
		\ , Pl#Segment#Truncate()
		\ , Pl#Segment#Split()
		\ , 'scrollpercent'
	\ ),
	\
	\ Pl#Theme#Buffer('ft_vimpager'
		\ , ['static_str.name', 'Pager']
		\ , 'filename'
		\ , Pl#Segment#Truncate()
		\ , Pl#Segment#Split()
		\ , 'scrollpercent'
	\ ),
	\
	\ Pl#Theme#Buffer('le_buffers'
		\ , ['static_str.name', 'LustyExplorer']
		\ , ['static_str.buffer', 'Buffers']
		\ , Pl#Segment#Truncate()
		\ , Pl#Segment#Split()
	\ ),
	\
	\ Pl#Theme#Buffer('le_grep'
		\ , ['static_str.name', 'LustyExplorer']
		\ , ['static_str.buffer', 'Grep']
		\ , Pl#Segment#Truncate()
		\ , Pl#Segment#Split()
	\ ),
	\
	\ Pl#Theme#Buffer('le_files'
		\ , ['static_str.name', 'LustyExplorer']
		\ , ['static_str.buffer', 'Files']
		\ , Pl#Segment#Truncate()
		\ , Pl#Segment#Split()
	\ ),
	\
	\ Pl#Theme#Buffer('ft_man'
		\ , ['static_str.name', 'Man page']
		\ , 'filename'
		\ , Pl#Segment#Truncate()
		\ , Pl#Segment#Split()
		\ , 'scrollpercent'
	\ ),
	\
	\ Pl#Theme#Buffer('ft_qf'
		\ , ['static_str.name', 'Quickfix']
		\ , Pl#Segment#Truncate()
		\ , Pl#Segment#Split()
	\ ),
	\
	\ Pl#Theme#Buffer('taglist'
		\ , ['static_str.buffer', 'Tag List']
		\ , Pl#Segment#Truncate()
		\ , Pl#Segment#Split()
	\ ),
	\
\ )
