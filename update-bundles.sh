#!/bin/sh
vim -R -N -V1 -e -s -i NONE \
    --cmd "source ~/.vimrc" \
    --cmd "NeoBundleFetch 'Shugo/neobundle.vim'" \
    --cmd NeoBundleUpdate\! \
    --cmd NeoBundleClean \
    --cmd qall\!
echo
