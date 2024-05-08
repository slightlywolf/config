#!/bin/bash 
set -x

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
BASEDIR=$SCRIPTPATH/..

sh $BASEDIR/symlink_tmux.sh

sh $BASEDIR/symlink_nvim.sh

sh $BASEDIR/symlink_calcurse.sh
