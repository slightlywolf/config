#!/bin/bash 
set -x

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
BASEDIR=$SCRIPTPATH/..

unlink ~/.config/nvim || true
ln -s $BASEDIR/nvim ~/.config/nvim 
