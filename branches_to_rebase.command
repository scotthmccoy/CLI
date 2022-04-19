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

function green {
    color "$1" 2
}

cd ~/Documents/XcodeProjects/Kurogo-iOS


ancestorA="devel-4.0"
ancestorB="devel-2.9"

# Get all feature branches
for featureBranch in $(git branch | grep -v \* | awk '{print $1}' | grep -v HEAD | grep -v devel- | grep -v master)
do
	# Determine whether the feature branch was branched from ancestorA or ancestorB
	branchedFrom=$(gitcca $featureBranch $ancestorA $ancestorB)

	# If it needs rebasing, print the branch name
	if [ "$(gitneedsrebase $featureBranch $branchedFrom)" = 'yes' ] ; then 
		green $featureBranch
	fi
done