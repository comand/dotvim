#!/bin/sh
NEOBUNDLEDIR=~/.vim/bundle/neobundle.vim
if [[ ! -d $NEOBUNDLEDIR ]]; then
    git clone https://github.com/Shougo/neobundle.vim $NEOBUNDLEDIR
fi

vim -R -N -V1 -e -s -i NONE \
    --cmd "source ~/.vimrc" \
    --cmd "NeoBundleFetch 'Shugo/neobundle.vim'" \
    --cmd NeoBundleUpdate\! \
    --cmd messages \
    --cmd qall\!
echo
