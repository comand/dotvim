#!/bin/sh -x
cd plugdir/YouCompleteMe
CC=clang CXX=clang++ ./install.py \
    --clang-completer \
    --go-completer \
    --rust-completer \
    --java-completer \
    --ts-completer \
    --clang-tidy
