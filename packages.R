# This script sets up library that R will have available. It starts by
# installing 4 packages:
# "versions"
#   All other package installations use this package to control the package 
#   version number. However, the latest version of this package is always
#   installed. As a result, changes to this package could change the behavior of
#   this script.
# "devtools"
#   Used first to make sure Rtools is installed. Later used to install any
#   github repositories.
# "Rcpp"
#   Allows R to use C++. Required by a number of packages. Trying to install
#   this through dependency installation led to lots of problems. Installing
#   by itself fixed those issues.
# "tidyverse"
#   Installs lots of packages as dependencies. This eliminates the need to keep
#   track of them all. Also used to read the csv file that list any additional
#   CRAN or github packages needed.
#
# Once these four packages are complete, this script reads the CRAN and GitHub
# csv files. Each lists any packages needed along with their versions.
#
# In this way, you can be 99% confident that the exact same R environment will
# be created on multiple machines. The only uncontrolled package is the initial
# "versions" package.
#
# One final note concerning packages in private repositories. They are not
# handled by this script. After setting up R, any private repos must be
# installed manually.


# This script is called from the command line
# with an argument holding the R folder name.
args <- commandArgs(trailingOnly = TRUE)
r_dir <- args[1]

# Set the library variable for all packages
lib <- file.path(getwd(), r_dir, "library")

# install package "versions"
install.packages(
  "versions",
  repos= "https://cran.rstudio.com/",
  lib = lib,
  dependencies = TRUE,
  quiet = TRUE
)
library(versions, quietly = TRUE)

# Install package "devtools"
install.versions(
  "devtools",
  "1.12.0",
  lib = lib,
  dependencies = TRUE,
  quiet = TRUE
)
library(devtools, quietly = TRUE)

# Check that a development environment is present (Rtools).
# This is required to install packages from GitHub.
setup <- setup_rtools()
suppressWarnings(
  suppressMessages(
    tryCatch(
      has_devel(),
      error = function(e) {
        cat("\nRtools not found. Install Rtools before running 2 - setup.bat")
        quit(save = "no", status = 1)
      }
    )
  )
)

# Install package "Rcpp"
install.versions(
  "Rcpp",
  "0.12.11",
  lib = lib,
  dependencies = TRUE,
  quiet = TRUE
)

# Install package "tidyverse"
install.versions(
  "tidyverse",
  "1.1.1",
  lib = lib,
  dependencies = TRUE,
  quiet = TRUE
)
library(tidyverse, quietly = TRUE)

# Read the csv of additional CRAN packages to install and install them
cran_csv <- read_csv("CRAN_packages.csv")
if (nrow(cran_csv) > 0){
  install.versions(
    cran_csv$Package,
    cran_csv$Version,
    lib = lib,
    dependencies = TRUE,
    quiet = TRUE
  )
}

# Read the csv of GitHub packages to install and install them
gh_csv <- read_csv("GitHub_packages.csv")
if (nrow(gh_csv) > 0){
  for (r in 1:nrow(gh_csv)){
    pkg <- gh_csv$Package[r]
    repo <- gh_csv$repo[r]
    ref <- gh_csv$ref[r]
    
    if (suppressWarnings(!require(pkg, character.only = TRUE, lib.loc = lib))){
      install_github(
        repo = repo,
        ref = ref,
        lib = lib,
        dependencies = TRUE,
        quiet = TRUE
      )
    }
  }
}
