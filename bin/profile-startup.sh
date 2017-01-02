#!/bin/bash

exec gvim \
    --cmd 'profile start profile.log' \
    --cmd 'profile func *' \
    --cmd 'profile file *' \
    -c 'profdel func *' \
    -c 'profdel file *' \
    -c 'qa!' \
    "$@"
