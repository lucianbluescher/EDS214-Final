# Get data into R using Here::Here function pulling only Fig3 data
bq1 <- read.csv(here("data", "raw_data", "QuebradaCuenca1-Bisley.csv")) |> 
  clean_names() |> 
  select("sample_id", "sample_date", "k", "no3_n", "mg", "ca", "nh4_n")

bq2 <- read.csv(here("data", "raw_data", "QuebradaCuenca2-Bisley.csv")) |> 
  clean_names() |> 
  select("sample_id", "sample_date", "k", "no3_n", "mg", "ca", "nh4_n")

bq3 <- read.csv(here("data", "raw_data", "QuebradaCuenca3-Bisley.csv")) |> 
  clean_names() |> 
  select("sample_id", "sample_date", "k", "no3_n", "mg", "ca", "nh4_n")

prm <- read.csv(here("data", "raw_data", "RioMameyesPuenteRoto.csv")) |> 
  clean_names() |> 
  select("sample_id", "sample_date", "k", "no3_n", "mg", "ca", "nh4_n")

# Using full_join for one data frame for all components of fig 3

bq12 <- full_join(bq1, bq2)
bq3prm <- full_join(prm, prm)

fig_3_data <- full_join(bq12, bq3prm) |> 
  filter(year(sample_date) >= "1988" & year(sample_date) <= "1994") # Change dates to Fig 3 range

# Remove unneeded variables to clear up environment for the sake of tidy
rm(bq1, bq12, bq2, bq3, bq3prm, prm)

# Pivot data to long form

fig_3_data <- fig_3_data |> pivot_longer(cols = c(k, no3_n, mg, ca, nh4_n),
                                     names_to = "nutrient",
                                     values_to = "value") 

 #write.csv(fig_3_data, "outputs/fig_3_data.csv")
# Make new data frames that is just the nutrient, sample_date and sample_id
k <- fig_3_data |> 
  filter(nutrient == "k") |> 
  mutate(sample_date = as.Date(sample_date))

no3_n <- fig_3_data |> 
  filter(nutrient == "no3_n")|> 
  mutate(sample_date = as.Date(sample_date))

mg <- fig_3_data |> 
  filter(nutrient == "mg")|> 
  mutate(sample_date = as.Date(sample_date))

ca <- fig_3_data |> 
  filter(nutrient == "ca")|> 
  mutate(sample_date = as.Date(sample_date))

nh4_n <- fig_3_data |> 
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

#write.csv(rollmean_all, "output/rollmean_all.csv") # Save intermediate data fram to data folder
