### DataScience Specialization (DS) - Getting and Cleaning Data (GCD) - Week 2 Quiz
#
# The sqldf package allows for execution of SQL commands on R data frames. We will use the sqldf package to practice the queries we might send with the dbSendQuery command in RMySQL.
#
# Download the American Community Survey data and load it into an R object called acs
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv
#
# Which of the following commands will select only the data for the probability weights pwgtp1 with ages less than 50?
#
## Created by BCGuyatt - Nov 2016

# load the sqldf package
install.packages("sqldf")
library(sqldf)

# the R package sqldf allows SQL commands to be used on R data frames
# the read.csv command read csv file data into an R data frame
# the csv file can be read directly from the url
acs <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv")

# lets explore the df
str(acs)

# we are interested in the pwgtp1 column of the df
# lets take a look
head(acs$pwgtp1)
tail(acs$pwgtp1)
class(acs$pwgtp1)

# question 2: check which following commands select only data for the probability 
# weightswith ages less than 50?
# sqldf("select * from acs where AGEP < 50")
# sqldf("select * from acs")
# sqldf("select pwgtp1 from acs")
# sqldf("select pwgtp1 from acs where AGEP < 50")

# just from pure inspection, the answer needs to be 4, as ...
# the first two select all columns by using *
# the third option, select pwgtp1 but does not filter the data by age
# the fourth selects the column pwgtp1 AND filters by age < 50 as desired
res <- sqldf("select pwgtp1 from acs where AGEP < 50")


### Question 3:
# Using the same data frame you created in the previous problem, what is the equivalent function to unique(acs$AGEP)
# Not all of the sql statement options conform.... only option 1 and option 4 return results
if(all(unique(acs$AGEP) == sqldf("select distinct AGEP from acs"))){message("Option 1 TRUE")}else{message("Option 1 FALSE")}

if(all(unique(acs$AGEP) == sqldf("select AGEP where unique from acs"))){message("Option 2 TRUE")}else{message("Option 2 FALSE")}

if(all(unique(acs$AGEP) == sqldf("select unique * from acs"))){message("Option 3 TRUE")}else{message("Option 3 FALSE")}

if(all(unique(acs$AGEP) == sqldf("select distinct pwgtp1 from acs"))){message("Option 4 TRUE")}else{message("Option 4 FALSE")}

# Only option 1 returns a true message.



sqldf("select AGEP where unique from acs")
sqldf("select unique * from acs")
sqldf("select distinct pwgtp1 from acs")