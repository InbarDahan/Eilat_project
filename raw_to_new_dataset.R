                                 # Raw data of ROV sampling to
                                  # processed
                                   # + adding the last samples to the general batch

# type1 meanings: 1 - sand, 2 - algae, 3 - corals

# packages:

library(dplyr)
library(tidyverse)
library(here)

# ______________________________________________________________


# load raw datasets: 'rovall' & 'ROV_ADD':

rov_all <- read.delim(here("data/raw", "rovall.csv"), sep = ',') # - data $ source

rov_27_8_23 <- read.delim(here("data/raw", "ROV20230827.csv"), sep = ',') # - data $ source

rov_06_06_23 <- read.delim(here("data/raw", "ROV060623.csv"), sep = ',') # - data $ source

rov_07_06_23 <- read.delim(here("data/raw", "ROV20230627.csv"), sep = ',') # - data $ source

rov_23_06_23 <- read.delim(here("data/raw", "ROV060623.csv"), sep = ',') # - data $ source

# binding all the independent dates:

b1 <- rbind(rov_27_8_23, rov_06_06_23)

b2 <- rbind(b1, rov_07_06_23)

rov_add <- rbind(b2, rov_23_06_23)

# ______________________________________________________________

# Create new df with only the relevant columns (f select):
# * depth (elevation)
# * date and time (datetimes)
# * location: lon (x1) + lat (y1)
# * substrate: Corals ('Type1 = 3') + percent cover ('subtype')

chosen_rov_all <- rov_all %>% 
  select (datetimes, x1, y1, elevation, type1, subtype)

chosen_rov_add <- rov_add %>% 
  select (datetimes, x, y, elevation, type1, subtype)   

# change columns and values names - the new name comes first:

rename_chosen_rov <- chosen_rov_all %>% 
 rename("lon" = "x1",
         "lat" = "y1",
         "depth" = "elevation",
         "substrate" = "type1",
         "precent_cover" = "subtype") # for columns


rename_chosen_add <- chosen_rov_add %>% 
  rename("lon" = "x",
         "lat" = "y",
         "depth" = "elevation",
         "substrate" = "type1",
         "precent_cover" = "subtype") # for columns

# ______________________________________________________________

# summary:
 ### substrate types at each data frame:

# rov: 1, 2, 3 (corals\hard substrate), 4, 5

# add: 1, 3, 4, " ", weird lines... -> needs to be reorganized and filtered 

# ______________________________________________________________

# removing missing data:

rename_chosen_add <- rename_chosen_add[-25,]

unique(rename_chosen_add$substrate)
unique(rename_chosen_rov$substrate)

# ______________________________________________________________


# Summarize the information - losing in the process some data 
    ## instead of having data on each unique substrate, separating only the hard substrate - corals

# ! I need to make sure that I am not using the ones that do not have data - I am just organizing the code here

rename_chosen_rov$substrate [rename_chosen_rov$substrate == '3'] <- 'corals' # for values
rename_chosen_rov$substrate [rename_chosen_rov$substrate != 'corals'] <- 'not corals' # for values 

rename_chosen_add$substrate [rename_chosen_add$substrate == '3'] <- 'corals' # for values
rename_chosen_add$substrate [rename_chosen_add$substrate != 'corals'] <- 'not corals' # for values

# ______________________________________________________________

# separate the columns date and time:

rename_chosen_rov_d = separate (rename_chosen_rov, col = datetimes , into = c ('date', 'time'), sep = ' ')  # separating the date and the hour to separate columns 

rename_chosen_add_d = separate (rename_chosen_add, col = datetimes , into = c ('date', 'time'), sep = 'T')  # separating the date and the hour to separate columns 
# something is wrong - the original formats are not dates and hours not sure that it is critical

# ______________________________________________________________

# unite the two data sets: 

new_corals_df <- rbind(rename_chosen_rov_d, rename_chosen_add_d)

# check unique 'substrates':
unique(new_corals_df$substrate)

# ______________________________________________________________

# saving the processed dfs:

# corals_df <- rename_chosen_rov # giving the whole df a new name
# write.csv(corals_df, here("data/processed" , 'corals_df.csv'), row.names = F)

# relevant - the new anf full rov processed data set: 
write.csv(new_corals_df, here("data/processed/new_occurence" , 'new_corals_df.csv'), row.names = F)
