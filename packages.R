# This script is called from the command line
# with an argument stating the R folder name.
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
install.versions(
  "devtools",
  "1.12.0",
  lib = lib,
  dependencies = TRUE,
  quiet = TRUE
)
library(devtools, quietly = TRUE)

# Check that a development environment is present (Rtools)
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

# readr is installed next to read the CRAN/GitHub csv files
# trying to load tidyverse at this point causes errors
install.versions(
  "readr",
  "0.2.2",
  lib = lib,
  dependencies = TRUE,
  quiet = TRUE
)
library(readr, quietly = TRUE)

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
    
    if (!require(pkg, character.only = TRUE, lib.loc = lib)){
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
