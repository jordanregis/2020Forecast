#### Preamble ####
# Purpose: Prepare and clean the survey data downloaded from [...UPDATE ME!!!!!]
# Author: Timothey Regis, Ankhee Paul, Chen Shupeng, and Kashaun Eghdam
# Data: 2 November 2020
# Contact: k.eghdam@mail.utornto.ca
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the ACS data and saved it to inputs/data
# - Don't forget to gitignore it!


#### Workspace setup ####
library(haven)
library(tidyverse)
# Read in the raw data. 
raw_strat_data <- read_dta("usa_00002.dta.gz")
# Add the labels
raw_strat_data <- labelled::to_factor(raw_strat_data)

clean_strat_data <-
  raw_strat_data %>%
  # Reselect and Name Data
  select(region,sex,age,race,language) %>% 
  rename(gender = sex, race_ethnicity = race, census_region = region) %>%
  # group age of respondents into 5 categories, removing all respondents younger than 18 and older than 100
  mutate(age_group = cut(as.numeric(age), 
                         breaks = c(18, 30, 40, 50, 60, 100), 
                         right = FALSE,
                         labels = c("18 to 29", 
                                    "30 to 39", 
                                    "40 to 49", 
                                    "50 to 59",
                                    "60 +")
  ),
  # Shrink region category into 4 categories to match the survey datas
  census_region = case_when(census_region == "new england division" ~ "Northeast",
                            census_region == "middle atlantic division" ~ "Northeast",
                            census_region == "east north central div" ~ "Midwest",
                            census_region == "west north central div" ~ "Midwest",
                            census_region == "south atlantic division" ~ "South",
                            census_region == "east south central div" ~ "South",
                            census_region == "west south central div" ~ "South",
                            census_region == "mountain division" ~ "West",
                            census_region == "pacific division" ~ "West"
  ),
  # group all other languages besides "English" and "Spanish" into an "Other" category
  language = case_when(language == "english" ~ "English",
                       language == "spanish" ~ "Spanish",
                       language != "english" | language != "spanish" ~ "Other"
  ),
  # group all other races besides "White" and "Black, or African American" into an "Other" category
  race_ethnicity = case_when(race_ethnicity == "black/african american/negro" ~ "Black, or African American",
                             race_ethnicity == "white" ~ "White",
                             race_ethnicity != "black/african american/negro" | race_ethnicity != "white" ~ "Other"
  ),
  # Capitalize Gender in order to match survey dataset 
  gender = case_when(gender == "male" ~ "Male",
                     gender == "female" ~ "Female")) %>%
  # take out all responses with at least 1 unanswered question
  na.omit()
