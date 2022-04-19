# Scripts
These scripts should be copied into your user directory and edited to point at the repo you'd like to use them with. Double-click to run.

## gitrebase.command
Rebases the current branch onto the tip of the develop branch it was branched from.

## branches_to_rebase.command
Prints a list of branches that are in need of rebasing (the develop branch that they were branched from has had new commits).

## gitprune.command
Deletes branches that are fully merged with `devel-4.0` or `devel-2.9`. Useful for cleaning up after your PRs have been merged.

## update_branches.command
Pulls devel-2.9 and devel-4.0


# Utilities
These scripts should be copied into `/usr/local/bin/`. They are useful in their own right but are mostly called by the other scripts.

## gitcca

Determines branch that the current branch was branched from (cca is short for Closest Common Ancestor)

Usage:
`gitcca featureBranch ancestorA ancestorB`

Example:
```
smccoy@mbp461smccoy Kurogo-iOS % gitcca origin/feature/swiftui-message-center devel-4.0 devel-2.9
devel-4.0
smccoy@mbp461smccoy Kurogo-iOS % 
```

## gitneedsrebase

Determines if a feature branch needs rebasing; if it is out of sync with a develop branch it was branched from. Prints "yes" or "no".

Usage:
`gitneedsrebase featureBranch rebaseOnto`

Example:
```
smccoy@mbp461smccoy Kurogo-iOS % gitneedsrebase feature/swiftui-message-center devel-4.0
yes
smccoy@mbp461smccoy Kurogo-iOS % 
```

# TODO
I'd like to convert the double-click-to-run scripts into ones that can live in `/usr/local/bin/`. They would have to either infer the names of the develop branches, or perhaps read them out of `.gitconfig`.
