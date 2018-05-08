#!/bin/sh -x
cd plugdir/YouCompleteMe
CC=clang CXX=clang++ ./install.py \
    --clang-completer \
    --tern-completer \
    --gocode-completer \
    --rust-completer
