#!/bin/zsh


#Text coloring functions
function color {
    if tty -s
    then
        tput setaf $2
        echo "$1"
        tput setaf 0
        return
    fi
    
    echo "$1"
}

function red {
    color "$1" 1
}

function green {
    color "$1" 2
}


#exit script immediately if any command returns a non-zero exit code (indicating an error)
set -o errexit
trap "say 'Error pruning branches'" ERR

cd ~/Documents/XcodeProjects/Kurogo-iOS

green "Deleting branches fully merged into devel-4.0..."
git branch --merged devel-4.0 | grep -v HEAD | grep -v devel-4.0 | grep -v master | grep -v \* | awk '{print $1}' | xargs git branch -D

green "Deleting branches fully merged into devel-2.9..."
git branch --merged devel-2.9 | grep -v HEAD | grep -v devel-2.9 | grep -v master | grep -v \* | awk '{print $1}' | xargs git branch -D