## Use this file to follow along with the live coding exercises.
## The csv file containing the data is in the 'data/' directory.
## If you want to save plots you created, place them in the 'figures/' directory.
## You can create additional R files in the 'scripts/' directory.

library(tidyverse)
# Since I am aleady in the project, just give path from the project
# Telling R how missing values look like in the file. Here it is NULL
# read_csv2 is used for column seperator
interviews <- read_csv("data/SAFI_clean.csv", na="NULL")
# Output shows how R inferred the data types. Run the above line and see the output

# To see the output in tidyverse
interviews
# To see as data frame
as.data.frame(interviews)
# To see spreadsheet view. You can view all data
# can be used for exploring the data (sort, filter etc). This can only be used for view
View(interviews)

##Inspect data

# get diamensions
dim(interviews)
nrow(interviews)
ncol(interviews)
# See first few entries
head(interviews)
head(as.data.frame(interviews))
# See last few entries
tail(interviews)
# get object names
names(interviews)

# Getting summaries.
#Give brief summary of things
str(interviews)
summary(interviews)

# Each column in a data frame is a vector; each column can only be one data type

# Access parts of data
# Accessing first row first column
# first row, second columns
interviews[1,1]
# first row 6 th column
interviews[1,6]
# selecting multiple
interviews [1:5, 6]
interviews [1, 1:6]
# get an entire row
interviews [1,1:ncol(interviews)]
# better option
interviews [1, ]
# for columns
interviews [ ,1]
interviews [1:6]

# Select coulmn by name
interviews[("respondent_wall_type")]
# can use negative to drop rows or columns
# Removed the first column below
interviews[, -1]

# Excercise
# Task 1
interviews_100 <- interviews [100, ]
# Task 2
interviews[nrow(interviews), ]
tail(interviews)
# Task 3
interviews[nrow(interviews), ]
# Task 4
interviews_last <- interviews[nrow(interviews), ]
# Task 5
interviews_middle <-interviews[nrow(interviews)/2, ]
# This method is not correct. See below
n_row <- nrow(interviews)
# as n_row is 131, n_row/2 is 65.5. R will take 65. 
interviews_middle <- interviews[ceiling(n_rows / 2), ]
# Task 6
interviews_head <- interviews[-(7:nrow(interviews)), ]


### Session 2 

# Create a character vector and change it to a factor
respondent_floor_type <- factor(c('earth', 'cement', 'cement', 'earth'))
# There are two levels for the facotrs. this is different from character
# Default is sorted in alphabetical order
levels(respondent_floor_type)
nlevels(respondent_floor_type)

# Change the order of the levels
respondent_floor_type
respondent_floor_type <- factor(respondent_floor_type, levels=c('earth', 'cement'))

# Levels can be changed
# Second level is changed to brick
levels(respondent_floor_type)[2] <- "brick"
respondent_floor_type

# you can convert factor to character
as.character(respondent_floor_type)

# Using numbers as factors
year_fct <-factor(c(1990, 1983, 1977, 1998, 1990))
year_fct
as.numeric(year_fct)
# factors are saved in the memory as numbers. See above.
# workaround 
as.numeric(as.character(year_fct))
# R recommended way
as.numeric(levels(year_fct))[year_fct]
# Here output from as.numeric (ie, numbers) to index the year_fct to get the numbers correctly

# Use exaples from the dataset
affect_conflicts <-interviews$affect_conflicts # or affect_conflicts <-interviews[,'affect_conflicts'] 
affect_conflicts <- as.factor(affect_conflicts)
affect_conflicts
# Plot the number of times each level appears in the 
plot(affect_conflicts)
# original plot has variables arrnged in alphabetic order. NA is not shwoing up as well

affect_conflicts <- interviews$affect_conflicts
# replace the missing data with "undetermined"
# is.na is used to find allthe missing values.select only the missing values and assign undetermined
affect_conflicts[is.na(affect_conflicts)] <- "undetermined"
affect_conflicts <-factor(affect_conflicts)
plot(affect_conflicts)

affect_conflicts

#Task
# Convert more_once to "more than once
levels(affect_conflicts)[2] <- "more than once"
# Arrange the factors as required
affect_conflicts <- factor(affect_conflicts, levels=c('never', 'once', 'more than once', 
                                                      'frequently', 'undetermined'))
plot(affect_conflicts)

#Segue
# outside tidyverse package you use read.csv. then use 'stringsAsFactors=FALSE
# eg interviews <- read.csv("data/SAFI_clean.csv", na="NULL", stringsAsFactors=FALSE)

# Priblem with dates
# Str funtion to get an overview of the data
str(interviews)
# can see that R stored the date in POSIXct format
# Use lubridate library

library(lubridate)
dates <- interviews$interview_date
head(dates)
# ymd year-date-month format
# This is required if only read.csv was used instead of read_csv
# dates <-ymd_hms(dates)

# Create new variables for day, month, year
interviews$day <- day(dates)
interviews$month <-month(dates)
interviews$year <-year(dates)

str(interviews)
