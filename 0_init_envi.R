# Run this code to initialize your environment

# Install "pacman" to make this easy for both of us
if (!requireNamespace("pacman", quietly = TRUE)) {
  install.packages("pacman")
}

# List of required packages
required_packages <- c("here", "janitor", "tidyverse", "lubridate", "ggplot2", "zoo", "dplyr", "roxygen2") 

# Library packages using pacman + install them if missing
pacman::p_load(char = required_packages)

