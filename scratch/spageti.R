# Libraries
library(here)
library(janitor)
library(tidyverse)



# Get data into R usuing Here::Here function pulling only Fig3 data
BQ1 <- read.csv(here("data", "QuebradaCuenca1-Bisley.csv")) |> 
  clean_names() |> select("sample_date", "k", "no3_n", "mg", "ca", "nh4_n")

BQ2 <- read.csv(here("data", "QuebradaCuenca2-Bisley.csv")) |> 
  clean_names() |> select("sample_date", "k", "no3_n", "mg", "ca", "nh4_n")

BQ3 <- read.csv(here("data", "QuebradaCuenca3-Bisley.csv")) |> 
  clean_names() |> select("sample_date", "k", "no3_n", "mg", "ca", "nh4_n")

PRM <- read.csv(here("data", "RioMameyesPuenteRoto.csv")) |> 
  clean_names() |> select("sample_date", "k", "no3_n", "mg", "ca", "nh4_n")

