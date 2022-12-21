#!/bin/sh
# This script is configure to open a Konsole Terminal in the chose environnement

#List of all usefull directory
DIRHOME="/home/julienb/"
DIRDOCS=$DIRHOME"Documents/"
DIRPROG=$DIRDOCS"epita/sup/prog/csharp/sherlock"

#Find the current tp / the last one
ls -td -- $DIRPROG/*/ > /tmp/cTP.txt
currentTP="$(head -n 1 /tmp/cTP.txt)"
rm -f /tmp/cTP.txt

slnFILE=$(locate .sln | grep $currentTP)
choices=""

#Choices for the DMENU
if [ -f "$slnFILE" ]; then
    choices="Configs\nHome\nProg-Folder\nRoot-Folder\nTP-Terminal\nTP-Rider"
else
    choices="Configs\nHome\nProg-Folder\nRoot-Folder\nTP-Terminal"
fi

chosen=$(echo -e "$choices" | dmenu -i)

case "$chosen" in
    Configs) exec bash $DIRDOCS"/dotfiles/term/term_config.sh" ;;
    Home) exec konsole --workdir $DIRHOME ;;
    Prog-Folder) exec konsole --workdir $DIRPROG ;;
    Root-Folder) exec konsole --workdir '/' ;;
    TP-Terminal) exec konsole --workdir $currentTP ;;
    TP-Rider) exec rider "$slnFILE" ;; 
esac
