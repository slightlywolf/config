#!/bin/bash 
set -x

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
BASEDIR=$SCRIPTPATH/..

mv ~/.config/calcurse ~/.config/calcurse_backup || true

unlink ~/.calcurse || true
ln -s $BASEDIR/calcurse ~/.config/calcurse

