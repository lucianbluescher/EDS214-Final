#Spagetti trial and error code for 214 Final project
# Lucian Scher
# lucian@ucsb.edu

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

ymd(fig3data$sample_date)

# Long version of data with avg to use facet wrap removing original data

fig3data_long <- fig3data |>
  pivot_longer(cols = c(k, no3_n, mg, ca, nh4_n),
               names_to = "nutrient",
               values_to = "value") 
 # select(-nutrient, -value)

# Write function for finding rolling means

moving_average <- function(focal_date, dates, conc, win_size_wks) {
  # Which dates are in the window?
  is_in_window <- (dates > focal_date - (win_size_wks / 2) * 7) &
    (dates < focal_date + (win_size_wks / 2) * 7)
  # Find the associated concentrations
  window_conc <- conc[is_in_window]
  # Calculate the mean
  result <- mean(window_conc)
  
  return(result)
}


# Call Function
source("R/rolling_mean.R")
# Apply the function

fig3data_long$roll_mean <- sapply(
  fig3data_long$sample_date,
  moving_average,
  dates = fig3data_long$sample_date,
  conc = fig3data_long$value,
  win_size_wks = 9
)


# Graphing lines to show each nutrient by year with individual y-axiss

fig3plot <- ggplot(data = fig3data_long, 
                   aes(x = sample_date,
                   y = value,
                   group = sample_id,
                   color = sample_id,)) +
  geom_line() +
  facet_wrap(~nutrient, scales = "free_y")
            
fig3plot


# Rolling mean doesnt work becuase it goes by row not week
#fig3weeks_avg <- fig3data |> 
# mutate(avg_k = rollmean(k, k = 9, align = "center", fill = NA, na.rm = TRUE)) |> 
# mutate(avg_n03 = rollmean(no3_n, k = 9, align = "center", fill = NA, na.rm = TRUE)) |> 
# mutate(avg_mg = rollmean(mg, k = 9, align = "center", fill = NA, na.rm = TRUE)) |> 
# mutate(avg_ca = rollmean(ca, k = 9, align = "center", fill = NA, na.rm = TRUE)) |> 
# mutate(avg_nh4 = rollmean(nh4_n, k = 9, align = "center", fill = NA, na.rm = TRUE)) 