#!/bin/bash
NEOBUNDLEDIR=~/.vim/bundle/neobundle.vim

if [[ ! -d $NEOBUNDLEDIR ]]; then
    git clone https://github.com/Shougo/neobundle.vim $NEOBUNDLEDIR
fi

$NEOBUNDLEDIR/bin/neoinstall
