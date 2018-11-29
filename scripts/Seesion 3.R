# deplyr and tidyr
# Tidyverse way to arranging and manipulating data

library(tidyverse)
interviews <- read_csv("data/SAFI_clean.csv", na="NULL")

# selecta subset of columns
# no need to put inverted commas as tidyverse takes care of it
select(interviews, village, no_membrs, years_liv)
# we can use : for column names in tidyverse just like 1:5 in the column number
# the script below will select columns from village to rooms
select(interviews, village:rooms)

# filter