# Libraries
library(here)
library(janitor)
library(tidyverse)
library(lubridate)
library(ggplot2)

MERGE CONFLiCT

# Get data into R using Here::Here function pulling only Fig3 data
BQ1 <- read.csv(here("data", "QuebradaCuenca1-Bisley.csv")) |> 
  clean_names() |> 
select("sample_id", "sample_date", "k", "no3_n", "mg", "ca", "nh4_n")

BQ2 <- read.csv(here("data", "QuebradaCuenca2-Bisley.csv")) |> 
  clean_names() |> 
  select("sample_id", "sample_date", "k", "no3_n", "mg", "ca", "nh4_n")

BQ3 <- read.csv(here("data", "QuebradaCuenca3-Bisley.csv")) |> 
  clean_names() |> 
  select("sample_id", "sample_date", "k", "no3_n", "mg", "ca", "nh4_n")

PRM <- read.csv(here("data", "RioMameyesPuenteRoto.csv")) |> 
  clean_names() |> 
  select("sample_id", "sample_date", "k", "no3_n", "mg", "ca", "nh4_n")


# trying full_join combine 4 data frames into 1 for graphing T
# fig3data should be all data needed for fig 3

BQ12 <- full_join(BQ1, BQ2)
BQ3PRM <- full_join(BQ3, PRM)

fig3data <- full_join(BQ12, BQ3PRM)

ymd(fig3data$sample_date)

(fig3data)


# Lets see if we can make it plot

fig3plot <- ggplot(data = fig3data, aes(x = sample_date, y = sample_id)) +
  geom_line() +
  facet_wrap(~ k + no3_n + mg + ca + nh4_n, scales = "free_y") # different panel for each variable

fig3plot

# Giving up because I realized I need to do the 9wk moving average first because it is doing every single day


