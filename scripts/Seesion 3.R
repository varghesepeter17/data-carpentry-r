# deplyr and tidyr
# Tidyverse way to arranging and manipulating data

library(tidyverse)
interviews <- read_csv("data/SAFI_clean.csv", na="NULL")

# select: select a subset of columns
# no need to put inverted commas as tidyverse takes care of it
select(interviews, village, no_membrs, years_liv)
# we can use : for column names in tidyverse just like 1:5 in the column number
# the script below will select columns from village to rooms
select(interviews, village:rooms)

# filter: select a subset of columns
# Select data for the village God
filter(interviews, village=="God")
# 2 conditions
filter(interviews, village=="God" | village=="Chirodzo")
filter(interviews, village=="God", rooms >2)

#segue
# doing the same thing again
# comparing vectors. This is a roundabout way to do this
filter(interviews, 1:nrow(interviews) %in% 1:10)

# Doing multiple things together
interviews2 <- filter(interviews, village=="God")
interviews_god <- select(interviews2, no_membrs, years_liv)
# many output variables like this may be a problem
# one way to overcome this is names the outputs sames so it is overwritten
#option 1
interviews_god <-select(filter(interviews, village=="God"), no_membrs, years_liv)
# problem: could be confusing

#better option
# piping in tidyverse
# break the line only after the pipe symbol
interviews_god <- interviews %>% filter(village=="God") %>% 
  select (no_membrs, years_liv)

# Task
interviews %>% filter(memb_assoc=="yes") %>%
  select(affect_conflicts, liv_count, no_meals)

# Add new variables obtained from the exisiting variables
# mutate is the function
interviews <- interviews %>% mutate(people_per_room = no_membrs/rooms)
# created a new variable people_per_room
# mutate keeps all the data and add a new columns into it
#
mean(interviews$no_membrs)
# This doesn't give intormation per village
# group_by is used for this purpose
interviews %>% group_by(village)
# creates a data frame grouped by village
interviews %>% group_by(village) %>%
  summarize(mean_no_membrs=mean(no_membrs))
# above gives mean number of members grouped by village

# group by village, select members of irrigation group
#summary of mean no of members
interviews %>% group_by(village) %>%
  filter(memb_assoc=="yes") %>%
  summarize(mean_no_membrs=mean(no_membrs))

# Group by multiple conditions
interviews %>% group_by(village, memb_assoc) %>%
  summarize(mean_no_membrs=mean(no_membrs))

# More than one output
interviews %>% group_by(village, memb_assoc) %>%
  summarize(mean_no_membrs=mean(no_membrs), 
            min_members=min(no_membrs))

#count function
interviews %>% count(village)
# count and sort
interviews %>% count (village, sort=TRUE)

# Task
interviews %>% group_by(village) %>%
  summarize(mean_no_membrs=mean(no_membrs), 
            min_members=min(no_membrs),
            max_members=max(no_membrs),
            n=n())

#Reshape data
# Split a variavle to multiple variables
# wall type is split into multiple variables
View(interviews %>% mutate(wall_type_logical=TRUE) %>%
  spread(key= respondent_wall_type, value =wall_type_logical))
# fill missing vaules with false
interviews <-interviews %>% mutate(wall_type_logical=TRUE) %>%
       spread(key= respondent_wall_type, value =wall_type_logical, fill=FALSE)

# The reverse is also possible
# Combine muliple variables into one
# ie, undo the previous steps

interviews <-interviews %>% gather(key=respondent_wall_type, value="wall_type_logical",
                                   burntbricks:sunbricks)

# Output has more rows. Now each respondant has 4 rows 
# Total no of rows is now x 4


# Prepare for plotting

interviews <- read_csv("data/SAFI_clean.csv", na="NULL")
interviews_plotting <- interviews %>%
  ## spread data by items_owned
  mutate(split_items = strsplit(items_owned, ";")) %>%
  unnest()%>%
  mutate(items_owned_logical = TRUE) %>%
  spread(key = split_items, value = items_owned_logical, fill = FALSE) %>%
  rename(no_listed_items = `<NA>`) %>%
  ## spread data by months_lack_food
  mutate(split_months = strsplit(months_lack_food, ";")) %>%
  unnest() %>%
  mutate(months_lack_food_logical = TRUE) %>%
  spread(key = split_months, value = months_lack_food_logical, fill = FALSE) %>%
  ## add some summary columns
  mutate(number_months_lack_food = rowSums(select(., Apr:Sept))) %>%
  mutate(number_items = rowSums(select(., bicycle:television)))

# Saving
write_csv(interviews_plotting, path = "data_output/interviews_plotting.csv")

