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
# as n_row is 131, n_row/2 is 65.5. R will take 65
interviews_middle <- interviews[ceiling(n_rows / 2), ]
# Task 6
interviews_head <- interviews[-(7:nrow(interviews)), ]

