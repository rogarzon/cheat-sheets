# Git Cheat Sheet – Helpful Git Commands with Examples

https://www.freecodecamp.org/news/git-cheat-sheet-helpful-git-commands-with-examples/

<!-- TOC -->
* [Git Cheat Sheet – Helpful Git Commands with Examples](#git-cheat-sheet--helpful-git-commands-with-examples)
  * [The Working Directory and the Staging Area](#the-working-directory-and-the-staging-area)
  * [Working with Branches](#working-with-branches)
  * [Merging in Git](#merging-in-git)
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

git merge <branch>
Integrates the changes from the specified branch into your current branch, combining their histories.

git merge --no-ff <branch>
Merges the specified branch into your current branch, always creating a new merge commit even if a fast-forward merge is possible.

git merge --squash <branch>
Combines all the changes from the specified branch into a single commit, preparing the changes for a commit in the current branch without merging the branch’s history. This allows you to manually edit the commit message.

git merge --abort
Cancels an ongoing merge process and restores the state of your working directory and index to what it was before the merge started.
