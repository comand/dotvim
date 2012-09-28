let g:Powerline#Segments#perforce#segments = Pl#Segment#Init(['perforce',
    \ exists('g:loaded_perforce'),
    \
    \ Pl#Segment#Create('status', '%{Powerline#Functions#perforce#GetStatus()}')
\ ])
