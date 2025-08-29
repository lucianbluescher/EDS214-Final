# Run this code to initialize your environment

# Install "pacman" to make this easy for both of us
if (!requireNamespace("pacman", quietly = TRUE)) {
  install.packages("pacman")
}

# List of required packages
required_packages <- c("here", "janitor", "tidyverse", "lubridate", "ggplot2", "zoo", "dplyr", "roxygen2") 

# Library packages using pacman + install them if missing
pacman::p_load(char = required_packages)

# Get data into R using Here::Here function pulling only Fig3 data
BQ1 <- read.csv(here("data", "raw_data", "QuebradaCuenca1-Bisley.csv")) |> 
  clean_names() |> 
  select("sample_id", "sample_date", "k", "no3_n", "mg", "ca", "nh4_n")

BQ2 <- read.csv(here("data", "raw_data", "QuebradaCuenca2-Bisley.csv")) |> 
  clean_names() |> 
  select("sample_id", "sample_date", "k", "no3_n", "mg", "ca", "nh4_n")

BQ3 <- read.csv(here("data", "raw_data", "QuebradaCuenca3-Bisley.csv")) |> 
  clean_names() |> 
  select("sample_id", "sample_date", "k", "no3_n", "mg", "ca", "nh4_n")

PRM <- read.csv(here("data", "raw_data", "RioMameyesPuenteRoto.csv")) |> 
  clean_names() |> 
  select("sample_id", "sample_date", "k", "no3_n", "mg", "ca", "nh4_n")

# Using full_join for one data frame for all components of fig 3

BQ12 <- full_join(BQ1, BQ2)
BQ3PRM <- full_join(BQ3, PRM)

fig3data <- full_join(BQ12, BQ3PRM) |> 
  filter(year(sample_date) >= "1988" & year(sample_date) <= "1994") # Change dates to Fig 3 range

# Remove unneeded variables to clear up environment for the sake of tidy
rm(BQ1, BQ12, BQ2, BQ3, BQ3PRM, PRM)

# Pivot data to long form

fig3data <- fig3data |> pivot_longer(cols = c(k, no3_n, mg, ca, nh4_n),
                                     names_to = "nutrient",
                                     values_to = "value") 

# write.csv(fig3data, "data/fig3data.csv")
# Make new data frames that is just the nutrient, sample_date and sample_id
k <- fig3data |> 
  filter(nutrient == "k") |> 
  mutate(sample_date = as.Date(sample_date))

no3_n <- fig3data |> 
  filter(nutrient == "no3_n")|> 
  mutate(sample_date = as.Date(sample_date))

mg <- fig3data |> 
  filter(nutrient == "mg")|> 
  mutate(sample_date = as.Date(sample_date))

ca <- fig3data |> 
  filter(nutrient == "ca")|> 
  mutate(sample_date = as.Date(sample_date))

nh4_n <- fig3data |> 
  filter(nutrient == "nh4_n")|> 
  mutate(sample_date = as.Date(sample_date))

# Source rolling mean function
source(here("R", "rolling_mean.R"))

# Apply the function for k

rollmean_k <- k |>
  group_by(sample_id) |>
  mutate(
   rollmean = sapply( 
      sample_date,
      rolling_mean, 
        dates = sample_date,
        conc = value,
        win_size_wks = 9
    )
  )|> 
  select(-value)


# Apply the function for no3_n

rollmean_no3_n <- no3_n |>
  group_by(sample_id) |>
  mutate(
    rollmean = sapply(
      sample_date,
     rolling_mean,
        dates = sample_date,
        conc = value,
        win_size_wks = 9
    )
  ) |> 
  select(-value)

# Apply the function for mg

rollmean_mg <- mg |>
  group_by(sample_id) |>
  mutate(
   rollmean = sapply(
      sample_date,
      rolling_mean,
        dates = sample_date,
        conc = value,
        win_size_wks = 9
    )
  ) |> 
  select(-value)


# Apply the function for ca

rollmean_ca <- ca |>
  group_by(sample_id) |>
  mutate(
    rollmean = sapply(
      sample_date,
      rolling_mean,
        dates = sample_date,
        conc = value,
        win_size_wks = 9
    )
  )|> 
  select(-value)


# Apply the function for nh4_n

rollmean_nh4_n <- nh4_n |>
  group_by(sample_id) |>
  mutate(
    rollmean = sapply(
      sample_date,
      rolling_mean,
        dates = sample_date,
        conc = value,
        win_size_wks = 9
    )
  )|> 
  select(-value)

# Regroup data for plotting 

rollmean_all <- rollmean_k |> 
  full_join(rollmean_no3_n) |> 
  full_join(rollmean_mg) |> 
  full_join(rollmean_ca) |> 
  full_join(rollmean_nh4_n)

#write.csv(rollmean_all, "data/rollmean_all.csv") # Save intermediate data fram to data folder
