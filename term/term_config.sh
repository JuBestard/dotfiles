#!/bin/sh

DIRHOME='/home/julienb/'
DIRDOCS=$DIRHOME'/Documents/'
DIRPROG=$DIRDOCS'/epita/sup/prog/csharp/sherlock'

choices="Folder\ni3config\nvimrc"
chosen=$(echo -e "$choices" | dmenu -i)

case "$chosen" in
    Folder) exec konsole --workdir $DIRDOCS'scripts/' ;;
    i3config) exec konsole -e 'vim '$DIRHOME'.i3/config' ;;
    vimrc) exec konsole -e 'vim '$DIRHOME'
    .vimrc'
esac
