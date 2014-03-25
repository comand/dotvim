#!/bin/sh
vim -R -N -V1 -e -s -i NONE --cmd "source ~/.vimrc" --cmd NeoBundleUpdate --cmd qall\!
echo
