#### Preamble ####
# Purpose: Prepare and clean the survey data downloaded from [...UPDATE ME!!!!!]
# Author: Timothey Regis, Ankhee Paul, Chen Shupeng, and Kashaun Eghdam
# Data: 2 November 2020
# Contact: k.eghdam@mail.utornto.ca
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the data from X and save the folder that you're 
# interested in to inputs/data 
# - Don't forget to gitignore it!


#### Workspace setup ####
library(haven)
library(tidyverse)
# Read in the raw data (You might need to change this if you use a different dataset)
raw_data <- read_dta("ns20200625.dta")
# Add the labels
raw_data <- labelled::to_factor(raw_data)
# Just keep some variables
reduced_data <-
  raw_data %>%
  select(vote_2020,
         census_region,
         race_ethnicity,
         gender,
         age,  
         language)  %>% 
  # turn age into a factor with 5 categories, removing all respondents under age 18
  mutate(age = case_when(age >= 18  & age <= 29 ~ '18 to 29',
                         age >= 30  & age <= 39 ~ '30 to 39',
                         age >= 40  & age <= 49 ~ '40 to 49',
                         age >= 50  & age <= 59 ~ '50 to 59',
                         age >= 60   ~ '60+')) %>%
  # Group all races other than "White" or "Black, or African American" into "Other" category
  mutate(race_ethnicity = case_when(race_ethnicity == "Black, or African American" ~ "Black, or African American",
                                    race_ethnicity == "White" ~ "White",
                                    race_ethnicity != "Black, or African American" | race_ethnicity != "White" ~ "Other")) %>%
  # remove all respondents containing at least one unanswered question 
  na.omit()



# calculate cell counts and save

cell_counts <- clean_data %>% 
  group_by(age_group, statefip, educ_group, decade_married) %>% 
  summarise(n = sum(perwt))%>% 
  mutate(state_name = str_to_lower(as.character(factor(statefip, 
                                                       levels = attributes(d_acs$statefip)$labels, 
                                                       labels = names(attributes(d_acs$statefip)$labels))))) %>% 
  ungroup() %>% 
  select(-statefip) %>% 
  select(census_region,race_ethnicity, gender,age,language)

saveRDS(cell_counts, "cell_counts.RDS")
