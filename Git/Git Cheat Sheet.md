# Git Cheat Sheet – Helpful Git Commands with Examples

https://www.freecodecamp.org/news/git-cheat-sheet-helpful-git-commands-with-examples/

<!-- TOC -->
* [Git Cheat Sheet – Helpful Git Commands with Examples](#git-cheat-sheet--helpful-git-commands-with-examples)
  * [The Working Directory and the Staging Area](#the-working-directory-and-the-staging-area)
  * [Working with Branches](#working-with-branches)
  * [Merging in Git](#merging-in-git)
  * [Git Remotes](#git-remotes)
  * [Stashing in Git](#stashing-in-git)
  * [Git Tagging](#git-tagging)
  * [Reverting Changes in Git](#reverting-changes-in-git)
  * [Viewing History Logs](#viewing-history-logs)
  * [Git Diffs](#git-diffs)
  * [How to Configure Git](#how-to-configure-git)
  * [Git Security](#git-security)
  * [Rebasing in Git](#rebasing-in-git)
  * [What is Cherry-Picking?](#what-is-cherry-picking)
  * [Cleaning Up in Git](#cleaning-up-in-git)
  * [Git Subtree](#git-subtree)
  * [How to Search in Git](#how-to-search-in-git)
  * [Submodules in Git](#submodules-in-git)
<!-- TOC -->

## The Working Directory and the Staging Area

The working directory is the environment where you actively make changes to your files, representing the current state of your project.But these
changes are local to your machine and not yet part of the version history.

On the other hand, the staging area, also known as the index, serves as an intermediary space between the working directory and the repository. It
acts as a checkpoint where you can selectively organize changes before they are committed to the repository's history

`git checkout .`

This command discards all changes in the working directory, reverting files to their last committed state. This command is useful for quickly undoing
local modifications and restoring the working directory to a clean state.

`git reset -p`

This command allows you to interactively reset changes in the working directory. It provides a way to selectively undo modifications, giving you
fine-grained control over which changes to keep or discard.

`git add <file>`
This command adds a specific file to the staging area in Git. This prepares the file for inclusion in the next commit, allowing you to selectively
choose which changes to include in your version history.

`git add -p`

Allows you to interactively stage changes from your working directory by breaking them into chunks (hunks). This lets you review and selectively add
parts of the changes to the index before committing.

`git add -i`

Enters the interactive mode of adding files. Provides a text-based interactive menu where you can select various actions to perform, such as staging
individual changes, updating files, or viewing the status.

`git rm <file>`

Removes a file from the working directory and stages the removal.

`git rm --cached <file>`

Removes the specified file from the staging area (index) but leaves it intact in your working directory. This effectively un-tracks the file from
version control.

`git mv <old_path> <new_path>`

This command is used to move or rename a file or directory within a Git repository. It automatically stages the change, making it ready for the next
commit.

`git commit -m "message"`

This command is used to create a new commit in your Git repository. It saves the changes that have been staged (added to the index) along with a
descriptive message.

## Working with Branches

`git branch <branch_name>`

Creates a new branch.

`git checkout <branch_name>`

Switches to the specified branch and updates the working directory.

`git checkout -b rgarzon origin/rgarzon`

Creates a new branch named `rgarzon` based on the remote branch `origin/rgarzon` and switches to it. This is useful for starting work on a feature or bug fix that exists in the remote repository.


`git branch -vv`

Lists all branches with their last commit information, showing which branch is tracking which remote branch and whether it is ahead or behind.

`git branch --set-upstream-to=origin/rgarzon rgarzon`

Sets the upstream branch for the local branch `rgarzon` to track the remote branch `origin/rgarzon`. This allows you to use `git push` and `git pull`


`git branch`

Lists all branches.

`git branch -d <branch_name>`

Deletes a branch.

`git push --delete <remote> <branch>`

Deletes a remote branch.

`git branch -m <old_name> <new_name>`

Renames a branch.

`git checkout -b <new_branch>`

Creates and switches to a new branch named <new_branch>, based on the current branch.

`git switch <branch>`

Switches the working directory to the specified branch.

`git show-branch <branch>`

Displays a summary of the commit history and branch relationships for all or selected branches, showing where each branch diverged.

`git show-branch --all`

Same as above, but for all branches and their commits.

`git branch -r`

Lists all remote branches that your local repository is aware of.

`git branch -a`

Lists all branches in your repository, including both local and remote branches (the ones the local repository is aware of).

`git branch --merged`

Lists all branches that have been fully merged into the current branch, and can be safely deleted if no longer needed.

`git branch --no-merged`

Lists all branches that have not been fully merged into your current branch, showing branches with changes that haven't been integrated yet.

## Merging in Git

`git merge <branch>`

Integrates the changes from the specified branch into your current branch, combining their histories.

`git merge --no-ff <branch>`

Merges the specified branch into your current branch, always creating a new merge commit even if a fast-forward merge is possible.

`git merge --squash <branch>`

Combines all the changes from the specified branch into a single commit, preparing the changes for a commit in the current branch without merging the
branch’s history. This allows you to manually edit the commit message.

`git merge --abort`

Cancels an ongoing merge process and restores the state of your working directory and index to what it was before the merge started.

`git merge -s ours <branch>` or
`git merge —-strategy=ours <branch>`

These commands are functionally the same, but the second is the expanded (more explicit) version, while `git merge -s ours <branch>` is the shorthand
version (which is commonly used). You'll see this a few times throughout this guide.

The `git merge —-strategy=ours <branch>` command (`git merge -s ours <branch>` for short) performs a merge using the "ours" strategy, which keeps the
current branch's changes and discards changes from the specified branch. This effectively merges the histories without integrating the changes from
the other branch.

`git merge --strategy=theirs <branch>`

Merges the specified branch into the current branch using the "theirs" strategy, which resolves all conflicts by favoring changes from the branch
being merged. Note that the "theirs" strategy is not a built-in strategy and usually requires custom scripting or is used with tools to handle
conflict resolution.

## Git Remotes

`git fetch`

Fetches changes from a remote repository but does not merge them into your current branch.

`git pull`

Fetches changes from a remote repository and immediately merges them into your current branch.

`git push`

Uploads your local branch's changes to a remote repository.

`git remote`

Lists the names of remote repositories configured for your local repository.

`git remote -v`

Displays the URLs of the remote repositories associated with your local repository, showing both the fetched and pushed URLs.

`git remote add <name> <url>`

Adds a new remote repository with the specified name and URL to your local repository configuration.

`git remote remove <name>` or
`git remote rm <name>`

Deletes the specified remote repository connection from your local git configuration. git remote rm <name> is the shorthand version of the command.

`git remote rename <old_name> <new_name>`

Changes the name of an existing remote repository connection in your local Git configuration

`git remote set-url <name> <newurl>`

Changes the URL of an existing remote repository connection in your local Git configuration.

`git fetch <remote>`

Retrieves the latest changes from the specified remote repository, updating your local copy of the remote branches without merging them into your
local branches.

`git pull <remote>`

Fetches changes from the specified remote repository and merges them into your current branch.

`git remote update`

Fetches updates for all remotes tracked by the repository.

`git push <remote> <branch>`

Uploads the specified branch from your local repository to the given remote repository.

`git push <remote> --delete <branch>`

Removes the specified branch from the remote repository.

`git remote show <remote>`

Displays detailed information about the specified remote repository, including its URL, fetch and push configurations, and the branches it tracks.

`git ls-remote <repository>`

Lists references (such as branches and tags) and their commit IDs from the specified remote repository. This command allows you to view the branches
and tags available in a remote repository without cloning it.

`git push origin <branch> --set-upstream`

Pushes the local branch <branch> to the remote repository origin and sets up the local branch to track the remote branch. This lets future git push
and git pull commands default to this remote branch.

`git remote add upstream <repository>`

Adds a new remote named upstream to your local repository, pointing to the specified <repository>. This is commonly used to track the original
repository from which you forked, while origin typically refers to your own fork.

`git fetch upstream`

Retrieves updates from the upstream remote repository, updating your local references to the branches and tags from that remote without modifying your
working directory or merging changes.

`git pull upstream <branch>`

Fetches updates from the <branch> of the upstream remote repository and merges those changes into your current branch. This is often used to integrate
changes from the original repository into your own local branch.

`git push origin <branch>`

Uploads the local branch <branch> to the origin remote repository, making your branch and its commits available on the remote.

## Stashing in Git

Git stashing is a feature that allows you to temporarily save changes in your working directory that are not yet ready to be committed.

`git stash` or
`git stash -m "message"`

Temporarily saves your uncommitted changes, allowing you to switch branches or perform other operations without committing incomplete work.

`git stash show`

Displays a summary of the changes in the most recent stash entry, showing which files were modified.

`git stash list`

Shows all the stashed changes in your repository, displaying them in a numbered list.

`git stash pop`

Applies the most recent stash and then immediately removes it from the stash list.

`git stash drop`

Removes the most recent stash entry from the stash list without applying it to your working directory.

`git stash apply`

Reapplies the most recently stashed changes to your working directory without removing them from the stash list.

`git stash clear`

Clears and removes all stashed entries, permanently deleting all saved changes in your stash.

`git stash branch <branch>`

Creates a new branch named <branch> from the commit where you were before stashing your changes. Then it applies the stashed changes to that new
branch.

## Git Tagging

Git tagging is a feature that allows you to mark specific points in your repository's history as important with a meaningful name, often used for
releases or significant milestones.

Unlike branches, tags are typically immutable and do not change, serving as a permanent reference to a particular commit.

`git tag <tag_name>`

Creates a new tag with the specified name pointing to the current commit (typically used to mark specific points in the commit history, like
releases).

`git tag -a <tag_name> -m "message"`

Creates an annotated tag with the specified name and message, which includes additional metadata like the tagger's name, email, and date, and points
to the current commit.

`git tag -d <tag_name>`

Deletes the specified tag from your local repository.

`git tag -f <tag> <commit>`

Forces a tag to point to a different commit.

`git show <tag_name>`

Displays detailed information about the specified tag, including the commit it points to and any associated tag messages or annotations.

`git push origin <tag_name>`

Uploads the specified tag to the remote repository, making it available to others.

`git push origin --tags`

Pushes all local tags to the remote repository, ensuring that all tags are synchronized with the remote.

`git push --follow-tags`

Pushes both commits and tags.

`git fetch --tags`

Retrieves all tags from the default remote repository and updates your local repository with them, without affecting your current branches.

## Reverting Changes in Git

Reverting changes in Git involves undoing modifications made to a repository's history. You can do this using several commands, such as `git revert`.
It creates a new commit that negates the changes of a specified previous commit, effectively reversing its effects while preserving the commit
history.

Another method is using `git reset`, which changes the current HEAD to a specified commit and can update the staging area and working directory
depending on the chosen options (--soft, --mixed, or --hard).

You can also use `git checkout` to discard changes in the working directory, reverting files to their state in the last commit.

`git checkout -- <file>`

Discards changes in the specified file from the working directory, reverting it to the state of the last commit and effectively undoing any
modifications that haven't been staged.

`git revert <commit>`

Creates a new commit that undoes the changes in the specified commit, effectively reversing its effects while preserving the history.

`git revert -n <commit>`

Reverts a commit but does not commit the result.

`git reset`

Resets the current HEAD to the specified state, and optionally updates the staging area and working directory, depending on the options used (--soft,
--mixed, or --hard).

`git reset --soft <commit>`

Moves HEAD to the specified commit, while keeping the index (staging area) and working directory unchanged, so all changes after the specified commit
remain staged for committing. This is useful when you want to undo commits but keep the changes ready to be committed again.

`git reset --mixed <commit>`

Moves HEAD to the specified commit and updates the index (staging area) to match that commit. But it leaves the working directory unchanged, so
changes after the specified commit are kept but are untracked.

`git reset --hard <commit>`

Moves HEAD to the specified commit and updates both the index (staging area) and working directory to match that commit. It discards all changes and
untracked files after the specified commit.

## Viewing History Logs

`git log`
Displays the commits log.

`git log --oneline`
Displays a summary of commits with one line each.

`git log --graph --all`
Shows a graphical representation of the commit history.

`git log --stat`
Displays file statistics along with the commit history.

`git log --pretty=format:"%h %s"`
Formats the log output according to the specified format.

`git log --pretty=format:"%h - %an, %ar : %s"`
Provides a more human-readable format for logs.

`git log --author=<author>`
Shows commits made by the specified author.

`git log --before=<date>`
Shows commits made before the specified date.

`git log --after=<date>`
Shows commits made after the specified date (same as git log --since=<date>)

`git log --cherry-pick`
Omits commits that are equivalent between two branches.

`git log --follow <file>`
Shows commits for a file, including renames.

`git log --show-signature`
Displays GPG signature information for commits.

`git shortlog`
Summarizes git log output by author.

`git shortlog -sn`
Summarizes git log output by author, with commit counts.

`git log --simplify-by-decoration`
Shows only commits that are referenced by tags or branches.

`git log --no-merges`
Omits merge commits from the log.

`git whatchanged`
Lists commit data in a format similar to a commit log.

`git diff-tree --pretty --name-only --root <commit>`
Shows detailed information for a commit tree.

`git log --first-parent`
Only shows commits of the current branch and excludes those merged from other branches.

## Git Diffs

`git diff --stat`

Shows a summary of changes between your working directory and the index (staging area), helping you see what files have been modified and how many
lines have been added or removed.

`git diff --stat <commit>`

Views changes between a commit and the working directory.

`git diff --stat <commit1> <commit2>`

Provides a summary of changes between two commits, showing which files were altered and the extent of changes between them.

`git diff --stat <branch1> <branch2>`

Summarizes the differences between the two branches, indicating the files changed and the magnitude of changes.

`git diff --name-only <commit>`

Shows only the names of files that changed in the specified commit.

`git diff --cached`

Shows the differences between the staged changes (index) and the last commit, helping you review what will be included in the next commit.

`git diff HEAD`

Shows the differences between the working directory and the latest commit (HEAD), allowing you to see what changes have been made since the last
commit.

`git diff <branch1> <branch2>`

Shows the differences between the tips of two branches, highlighting the changes between the commits at the end of each branch.

`git difftool`

Launches a diff tool to compare changes.

`git difftool <commit1> <commit2>`

Uses the diff tool to show the differences between two specified commits.

`git difftool <branch1> <branch2>`

Opens the diff tool to compare changes between two branches.

`git cherry <branch>`

Compares the commits in your current branch against another branch and shows which commits are unique to each branch. It is commonly used to identify
which commits in one branch have not been applied to another branch.

## How to Configure Git

`git config --global user.name "Your Name"`
Sets the user name on a global level.

`git config --global user.email "your_email@example.com"`
Sets the user email on a global level.

`git config --global core.editor <editor>`
Sets the default text editor.

`git config --global core.excludesfile <file>`
Sets the global ignore file.

`git config --list`
Lists all the configuration settings.

`git config --list --show-origin`
Lists all config variables, showing their origins.

`git config <key>`
Retrieves the value for the specified key.

`git config --get <key>`
Retrieves the value for the specified configuration key.

`git config --unset <key>`
Removes the specified configuration key.

`git config --global --unset <key>`
Removes the specified configuration key globally.

## Git Security

Git GPG security involves using GNU Privacy Guard (GPG) to sign commits and tags, ensuring their authenticity and integrity. By configuring a GPG key
and enabling automatic signing, you can verify that commits and tags were created by a trusted source. This helps prevent tampering and ensures the
integrity of the repository's history.

`git config --global user.signingKey <key>`
Configures the GPG key for signing commits and tags.

`git config --global commit.gpgSign true`
Automatically signs all commits with GPG.

## Rebasing in Git

Git rebasing re-applies your changes on top of another branch's history, creating a cleaner and more linear project history.

In practice, this helps integrate updates smoothly by avoiding unnecessary merge commits, ensuring that the commit sequence is straightforward, and
making it easier to understand the evolution of the project.

`git rebase <branch>`

The git rebase command is used to re-apply commits on top of another base tip. It allows you to move or combine a sequence of commits to a new base
commit. This is commonly used to:

1. Keep a linear project history.
2. Integrate changes from one branch into another.
3. Update a feature branch with the latest changes from the main branch.

The basic usage is git rebase <branch>, which will rebase the current branch onto the specified branch.

`git rebase --interactive <branch>`

Starts an interactive rebase session, allowing you to modify commits starting from <base> up to the current HEAD. This lets you reorder, squash, edit,
or delete commits, providing a way to clean up and refine commit history before pushing changes. Shorter version: `git rebase -i <branch>`

`git rebase --continue`
Continues the rebase process after resolving conflicts.

`git rebase --abort`
Aborts the rebase process and returns to the original branch.

`git fetch --rebase`
Fetches from the remote repository and rebases local changes.

## What is Cherry-Picking?

Git cherry-picking is a process that allows you to apply the changes introduced by a specific commit from one branch into another branch. This is
particularly useful when you want to selectively incorporate individual changes from different branches without merging the entire branch.

`git cherry-pick <commit>`
Applies the changes introduced by an existing commit.

`git cherry-pick --continue`
Continues cherry-picking after resolving conflicts.

`git cherry-pick --abort`
Aborts the cherry-pick process.

`git cherry-pick --no-commit <commit>`
Cherry-picks a commit without automatically committing and allows further changes. Shorter version: git cherry-pick -n <commit>

## Cleaning Up in Git

Cleaning up in Git involves removing unnecessary files, references, and branches that are no longer needed. This helps to keep your repository
organized and efficient.

`git fetch --prune`
Removes references that no longer exist on the remote.

`git remote prune <name>`
Prunes all stale remote-tracking branches.

`git fetch origin --prune`
Cleans up outdated references from the remote repository.

`git clean -f`
Removes untracked files from the working directory, forcing the deletion of files not being tracked by Git.

`git clean -fd`
Removes untracked files and directories from the working directory, including any files and directories not tracked by Git.

`git clean -i`
Enters interactive mode for cleaning untracked files.

`git clean -X`
Removes only ignored files from the working directory.

## Git Subtree

Git subtree is a mechanism for managing and integrating subprojects into a main repository. Unlike submodules, which treat the subproject as a
separate entity with its own repository, subtrees allow you to include the contents of another repository directly within a subdirectory of your main
repository.

This approach simplifies the workflow by eliminating the need for multiple repositories and enabling seamless integration, merging, and pulling of
updates from the subproject

`git subtree add --prefix=<dir> <repository> <branch>`
Adds a repository as a subtree.

`git subtree merge --prefix=<dir> <branch>`
Merges a subtree.

`git subtree pull --prefix=<dir> <repository> <branch>`
Pulls in new changes from the subtree's repository.

## How to Search in Git

git grep is a powerful search command in Git that allows users to search for specific strings or patterns within the files of a repository. It
searches through the working directory and the index, providing a quick and efficient way to locate occurrences of a specified pattern across multiple
files.

`git grep <pattern>`
Searches for a string in the working directory and the index.

`git grep -e <pattern>`
Searches for a specific pattern.

## Submodules in Git

Submodules in Git are a way to include and manage external repositories within your own repository. They are particularly useful for reusing code
across multiple projects, maintaining dependencies, or integrating third-party libraries.

By using submodules, you can keep your main repository clean and modular, while still ensuring that all necessary components are included and
version-controlled.

`git submodule init`

Initializes submodules in your repository. This command sets up the configuration necessary for the submodules, but doesn't actually clone them.

`git submodule update`

Clones and checks out the submodules into the specified paths. This is typically run after git submodule init.

`git submodule add <repository> <path>`

Adds a new submodule to your repository at the specified path, linking it to the specified repository.

`git submodule status`

Displays the status of all submodules, showing their commit hashes and whether they are up-to-date, modified, or uninitialized.

`git submodule foreach <command>`

Runs the specified command in each submodule. This is useful for performing batch operations across all submodules.

`git submodule sync`

Synchronizes the submodule URLs in your configuration file with those in the .gitmodules file, ensuring they are up-to-date.

`git submodule deinit <path>`

Unregisters the specified submodule, removing its configuration. This doesn't delete the submodule's working directory.

`git submodule update --remote`

Fetches and updates the submodules to the latest commit from their remote repositories.

`git submodule set-url <path> <newurl>`

Changes the URL of the specified submodule to the new URL.

`git submodule absorbgitdirs`

Absorbs the submodule's Git directory into the superproject to simplify the structure.