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
trap "say 'Error updating branches'" ERR

####################
## Script Contents #
####################

cd ~/Documents/XcodeProjects/Kurogo-iOS

green "Pulling devel-4.0"
git checkout devel-4.0
git pull

green "Pulling devel-4.0"
git checkout devel-2.9
git pull

green "Done!"
say "Done"