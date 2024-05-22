#!/bin/bash 
set -x

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
BASEDIR=$SCRIPTPATH/..

unlink ~/.tmux.conf || true
ln -s $BASEDIR/tmux/.tmux.conf ~/.tmux.conf 
