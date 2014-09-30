if did_filetype()
    finish
endif

if getline(1) =~ '^# A Perforce ' || getline(3) =~ '^# Checkin Specification'
    setfiletype perforce
elseif getline(1) =~ 'pypix'
    setfiletype python
endif
