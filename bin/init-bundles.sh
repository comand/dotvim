#!/bin/sh
NEOBUNDLEDIR=~/.vim/bundle/neobundle.vim

if [[ -d $NEOBUNDLEDIR ]]; then
    echo "Neobundle already installed"
else
    git clone https://github.com/Shougo/neobundle.vim $NEOBUNDLEDIR
    $NEOBUNDLEDIR/bin/neoinstall
fi
