# This script is called from the command line
# with an argument stating the R folder name.
args <- commandArgs(trailingOnly = TRUE)
r_dir <- args[1]

# Set the library variable for all packages
lib <- file.path(getwd(), r_dir, "library")

# devtools must be installed first
if (!require(devtools, lib.loc = lib)){
  install.packages(
    "devtools",
    repos= "https://cran.rstudio.com/",
    type = "binary",
    lib = lib,
    dependencies = TRUE,
    quiet = TRUE
  )
}
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
if (!require(readr, lib.loc = lib)){
  install_version(
    "readr",
    repos = "https://cran.rstudio.com/",
    # type = "binary",
    version = "0.2.2",
    lib = lib,
    dependencies = TRUE,
    quiet = TRUE
  )
}
library(readr, quietly = TRUE)

# Read the csv of additional CRAN packages to install and install them
cran_csv <- read_csv("CRAN_packages.csv")
if (nrow(cran_csv) > 0){
  for (r in 1:nrow(cran_csv)){
    pkg <- cran_csv$Package[r]
    ver <- cran_csv$Version[r]
    
    if (!require(pkg, character.only = TRUE, lib.loc = lib)){
      install_version(
        pkg,
        repos = "https://cran.rstudio.com/",
        type = "binary",
        version = ver,
        lib = lib,
        dependencies = TRUE,
        quiet = TRUE
      )
    }
  }
}

# Read the csv of GitHub packages to install and install them
gh_csv <- read_csv("GitHub_packages.csv")
if (nrow(gh_csv) > 0){
  for (r in 1:nrow(gh_csv)){
    pkg <- gh_csv$Package[r]
    repo <- gh_csv$repo[r]
    ref <- gh_csv$ref[r]
    auth_token <- gh_csv$auth_token[r]
    if (is.na(auth_token)){
      auth_token <- NULL
    }
    
    if (!require(pkg, character.only = TRUE, lib.loc = lib)){
      install_github(
        pkg,
        repo = repo,
        ref = ref,
        auth_token = auth_token,
        lib = lib,
        dependencies = TRUE,
        quiet = TRUE
      )
    }
  }
}

