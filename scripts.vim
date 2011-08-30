if getline(1) =~ '^# A Perforce ' || getline(3) =~ '^# Checkin Specification'
    setfiletype perforce
elseif getline(1) =~ '^%TOC'
    setfiletype twiki
endif
