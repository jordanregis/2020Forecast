#### Preamble ####
# Purpose: Prepare and clean the survey data downloaded from [...UPDATE ME!!!!!]
# Author: Timothey Regis, Ankhee Paul, Chen Shupeng, and Kashaun Eghdam
# Data: 2 November 2020
# Contact: k.eghdam@mai.utornto.ca
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
clean_data <-
  raw_data %>%
  select(vote_2020,
         census_region,
         race_ethnicity,
         gender,
         age,  
         language)  %>%
  # grouping age into 5 categories and removing all respondents under 18 and over 100 years old
  mutate(age_group = cut(age, 
                         breaks = c(18, 30, 40, 50, 60, 100), 
                         right = FALSE,
                         labels = c("18 to 29", 
                                    "30 to 39", 
                                    "40 to 49", 
                                    "50 to 59",
                                    "60 +")
  ),
  # group all other races besides "White" and "Black, or African American" into an "Other" category
  race_ethnicity = case_when(race_ethnicity == "Black, or African American" ~ "Black, or African American",
                             race_ethnicity == "White" ~ "White",
                             race_ethnicity != "Black, or African American" | race_ethnicity != "White" ~ "Other"),
  # group all other languages besides "English" and "Spanish" into an "Other" category
  language = case_when(language == "Yes, we speak Spanish." ~ "Spanish",
                       language == "Yes, we speak a language other than Spanish or English." ~ "Other",
                       language == "No, we speak only English." ~ "English") )%>%
  # remove all respondents containing at least one unanswered question 
  na.omit()
