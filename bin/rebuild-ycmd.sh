#!/bin/sh
cd plugdir/YouCompleteMe

if [[ $1 != patch ]]; then
    CC=clang CXX=clang++ ./install.py \
        --clang-completer \
        --go-completer \
        --rust-completer \
        --java-completer \
        --ts-completer \
        --clang-tidy
fi

echo -n "Finding ycm_core.so... "
ycmdir=$(readlink -e third_party/ycmd)
ycm_core=$(find $ycmdir -maxdepth 2 -type f -name ycm_core.so)
if [[ ! -f $ycm_core ]] ;then
    echo "Build failed or package changed - can't find ycm_core.so"
    exit 1
fi
echo $ycm_core

echo -n "Finding libclang.so... "
libclang=$(find $ycmdir -type f -name libclang.so.*)
if [[ -z $libclang ]]; then
    echo "Build failed or package changed - can't find libclang"
    exit 1
fi
echo $libclang

echo -n "Checking ycm_core RPATH... "
ycm_core_dir=${ycm_core%/*}
libclang_dir=${libclang%/*}
libclang_rpath=${libclang_dir#$ycm_core_dir/}
rpath=$(patchelf --print-rpath $ycm_core)
if [[ $rpath =~ $libclang_rpath ]]; then
    echo "OK"
else
    echo -n "patching... "
    patchelf --set-rpath "$rpath:\$ORIGIN/$libclang_rpath" $ycm_core
    echo "OK"
fi

echo "Done."
