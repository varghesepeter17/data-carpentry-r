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