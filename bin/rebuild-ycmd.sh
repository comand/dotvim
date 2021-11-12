#!/bin/bash

cd plugdir/YouCompleteMe

if [[ -d /opt/rh/devtoolset-10 ]]; then
    . /opt/rh/devtoolset-10/enable
fi
if [[ -d /opt/rh/rh-python38 ]]; then
    . /opt/rh/rh-python38/enable
fi

CC=gcc CXX=g++ python3 ./install.py \
    --clangd-completer \
    --go-completer \
    --rust-completer \
    --java-completer \
    --ts-completer
