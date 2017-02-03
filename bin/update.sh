#!/bin/sh

curl -s -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim -N -u ~/.vim/vimrc -c "try | PlugUpdate! | finally | qall! | endtry" \
    -U NONE -i NONE -V1 -e -s
