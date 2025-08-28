# Run this code to initilize your environment

# Libraries
library(here)
library(janitor)
library(tidyverse)
library(lubridate)
library(ggplot2)
library(zoo)
library(dplyr)

# Get data into R using Here::Here function pulling only Fig3 data
BQ1 <- read.csv(here("raw_data", "QuebradaCuenca1-Bisley.csv")) |> 
  clean_names() |> 
  select("sample_id", "sample_date", "k", "no3_n", "mg", "ca", "nh4_n")

BQ2 <- read.csv(here("raw_data", "QuebradaCuenca2-Bisley.csv")) |> 
  clean_names() |> 
  select("sample_id", "sample_date", "k", "no3_n", "mg", "ca", "nh4_n")

BQ3 <- read.csv(here("raw_data", "QuebradaCuenca3-Bisley.csv")) |> 
  clean_names() |> 
  select("sample_id", "sample_date", "k", "no3_n", "mg", "ca", "nh4_n")

PRM <- read.csv(here("raw_data", "RioMameyesPuenteRoto.csv")) |> 
  clean_names() |> 
  select("sample_id", "sample_date", "k", "no3_n", "mg", "ca", "nh4_n")

# Using full_join for one data frame for all components of fig 3

BQ12 <- full_join(BQ1, BQ2)
BQ3PRM <- full_join(BQ3, PRM)

fig3data <- full_join(BQ12, BQ3PRM) |> 
  filter(year(sample_date) <= "1994") # Change dates to Fig 3 range

