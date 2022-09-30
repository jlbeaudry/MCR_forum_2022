# MID-CAREER RESEARCHER FORUM WITH DVC(R) (September 2022)
# PREPROCESSING DATA SCRIPT
# JEN BEAUDRY

#### LOAD LIBRARY ####

library(here)
library(tidyverse)

source(here("..", "functions", "read_qualtrics.R"))
source(here("..", "functions", "meta_rename.R"))


#### LOAD DATA ####

df <- here::here("data", "mcr_forum_raw_data.csv") %>%
  read_qualtrics(legacy = FALSE) %>%
  select(-c("start_date":"user_language")) %>% 
  mutate(id = 1:n()) %>% 
  relocate(id)

# load metadata 

meta <- read_csv(here::here("data", "mcr_forum_metadata.csv"), lazy = FALSE) %>%
      filter(old_variable != "NA", old_variable != "exclude") # remove the instruction variables



##### RECODE VARIABLES #####
  
  # recode variable labels according to metadata
  
df <- meta_rename(df = df, metadata = meta, old = old_variable, new = new_variable)

  

#### WRITE DATA ####
  
# when done preprocessing, write the data to new files
# row.names gets rid of the first column from the dataframe.

write.csv(df, here::here("data", "mcr_forum_processed.csv"), row.names = FALSE)


