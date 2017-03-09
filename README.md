# SAGs R Repository
Central repo for managing R versions. This repo allows
us to manage R across multiple project repositories
without needing to include an R distribution in each one.

# Adding this to your repo
Bring it in as a
[submodule](https://github.com/blog/2104-working-with-submodules).

# Installing R
Simply run setup.bat

This will install R to the repository directory.
Everything installed will be ignored by git, but will be
available to the local machine.

# Cleaning out the repo folder
Most of the time, simply delete the R folder.

If developing the repo, other files may clutter the folder,
and they are ignored by the .gitignore file. Open git bash
and use the following two commands to clean out the folder.
Make sure your programs (Rstudio, TrandCAD, etc.) are closed.

To see a preview of what files will be deleted
git clean -nxd

To delete the files
git clean -fxd