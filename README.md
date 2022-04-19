# git_scripts

A collection of scripts I've found helpful for automating daily git chores. 

## Installation

1. Copy the the scripts into `/usr/local/bin/`
2. Specify develop branches in the repo's `.git/config` file. Example:
```
git config scripts.develop devel-4.0 devel-2.9
```

3. (Optional) Specify branches to ignore. Example:
```
git config scripts.protected main release
```


## List of Scripts

### gitisrebased
Prints "yes" if the branch is "rebased"; if its merge-base with its parent (see `gitparent`) is the tip of the parent branch. Otherwise, prints "no".   

### gitisrebasedlist
Prints a list of branches that are *not* rebased (see `gitisrebased`). Ignores branches specified in `scripts.develop` and `scripts.protected`.  

### gitparent
Prints the current branch's "parent branch" by finding the nearest commit to HEAD that resides on a branch other than the current branch and printing the name of that branch.

### gitprune
Deletes local branches that have been fully merged into the list of branches specified in `scripts.develop`. Will not delete branches specified in `scripts.develop` or `scripts.protected`. Useful for cleaning up after merging PRs.

### gitrebase
Rebases the current branch onto the tip of its parent branch (See `gitparent`).

### gitupdate
Pulls the branches specified in `scripts.develop`. 
