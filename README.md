# SAGs R Repository
Central repo for managing R versions. This repo allows
us to manage R across multiple project repositories
without needing to include a separate R distribution in each one.
It also makes controlling and archiving R versions easier so that
our models stay reproducible into the reasonable future.

# Adding this to your repo
Bring it in as a
[submodule](https://github.com/blog/2104-working-with-submodules).

# Installation

## Installing Rtools
Double click "1 - Download Rtools.url" to install the
proper executable and run it (accepting all defaults).

Rtools is required by certain packages to compile for source code.

## Installing R
Double click setup.bat

This will install R to the repository directory.
Everything installed will be ignored by git, but will be
available to the local machine.

# Cleaning out the repo folder
Most of the time, simply delete the R folder.

If developing the repo, other files may clutter the folder,
and they will be ignored by git. To easily delete, open git bash
and use the following two commands to clean out the folder.
Make sure your programs (Rstudio, TrandCAD, etc.) are closed.

To see a preview of what files will be deleted:
git clean -nxd

To delete the files:
git clean -fxd

# Contributing to this repo
Instructions coming soon to a wiki page in the repo.
