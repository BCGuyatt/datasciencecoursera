### Coursera | Data Scientist Toolbox | Getting and Cleaning Data | Week 4 Quiz
#
## Created by BCGuyatt | Doc 2016

# Load standard packages
packages <- c("data.table", "quantmod")
sapply(packages, library, character.only = TRUE, quietly = TRUE)
# and fix the issue with URL reading and https with knitr
#2€setInternet2(TRUE)

original_WD <- getwd()

#set wd to datasciencecoursera folder"
setwd(file.path("/Users","Ben","Documents","DataScienceCoursera","GettingCleaningData"))
current_wd <- getwd()

# QUESTION 1
# 
# The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
#     
#     https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
# 
# and load the data into R. The code book, describing the variable names is here:
#     
#     https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
# 
# Apply strsplit() to split all the names of the data frame on the characters "wgtp". What is the value of the 123 element of the resulting list?

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
fname <- file.path(current_wd, "getdata_ss06hid.csv")
download.file(url, fname)
dat <- data.table(read.csv(fname))

names <- colnames(dat)
nsplit <- strsplit(names, "wgtp")
nsplit[[123]]

# ANSWER
# > dat <- data.table(read.csv(fname))
# > names <- colnames(dat)
# > names <- colnames(dat)
# > nsplit <- strsplit(names, "wgtp")
# > nsplit[[123]]
# [1] ""   "15"





# QUESTION 2
# 
# Load the Gross Domestic Product data for the 190 ranked countries in this data set:
#     
#     https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
# 
# Remove the commas from the GDP numbers in millions of dollars and average them. What is the average?
# 
# Original data sources:
#     
#     http://data.worldbank.org/data-catalog/GDP-ranking-table

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
fname <- file.path(current_wd, "getdata_GDP.csv")
download.file(url, fname)
GDPdat <- data.table(read.csv(fname, skip = 4, nrows = 215, stringsAsFactors = FALSE))

GDPdat <- GDPdat[X != ""]
GDPdat <- GDPdat[, list(X, X.1, X.3, X.4)]
setnames(GDPdat, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP", 
                                               "Long.Name", "gdp"))
gdp <- as.numeric(gsub(",", "", GDPdat$gdp))

mean(gdp, na.rm = TRUE)

# ANSWER:
# > mean(gdp, na.rm = TRUE)
# [1] 377652.4





# QUESTION 3
# 
# In the data set from Question 2 what is a regular expression that would allow you to 
# count the number of countries whose name begins with "United"? Assume that the 
# variable with the country names in it is named countryNames. How many countries 
# begin with United?

isUnited <- grepl("^United", GDPdat$Long.Name)
summary(isUnited)

# ANSWER
# summary(isUnited)
# Mode   FALSE    TRUE    NA's 
# logical     211       3       0 






# QUESTION 4
# 
# Load the Gross Domestic Product data for the 190 ranked countries in this data set:
#     
#     https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
# 
# Load the educational data from this data set:
#     
#     https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
# 
# Match the data based on the country shortcode. Of the countries for which the end of the fiscal year is available, how many end in June?
# 
# Original data sources:
#     
#     http://data.worldbank.org/data-catalog/GDP-ranking-table
# 
# http://data.worldbank.org/data-catalog/ed-stats

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
f <- file.path(getwd(), "EDSTATS_Country.csv")
download.file(url, f)
dtEd <- data.table(read.csv(f))
dt <- merge(GDPdat, dtEd, all = TRUE, by = c("CountryCode"))
isFiscalYearEnd <- grepl("fiscal year end", tolower(dt$Special.Notes))
isJune <- grepl("june", tolower(dt$Special.Notes))
table(isFiscalYearEnd, isJune)

dt[isFiscalYearEnd & isJune, Special.Notes]

# ANSWER
# table(isFiscalYearEnd, isJune)
# isJune
# isFiscalYearEnd FALSE TRUE
# FALSE   203    3
# TRUE     19   13
# > dt[isFiscalYearEnd & isJune, Special.Notes]
# [1] Fiscal year end: June 30; reporting period for national accounts data: FY.
# [2] Fiscal year end: June 30; reporting period for national accounts data: FY.
# [3] Fiscal year end: June 30; reporting period for national accounts data: FY.
# [4] Fiscal year end: June 30; reporting period for national accounts data: FY.
# [5] Fiscal year end: June 30; reporting period for national accounts data: CY.
# [6] Fiscal year end: June 30; reporting period for national accounts data: CY.
# [7] Fiscal year end: June 30; reporting period for national accounts data: CY.
# [8] Fiscal year end: June 30; reporting period for national accounts data: FY.
# [9] Fiscal year end: June 30; reporting period for national accounts data: FY.
# [10] Fiscal year end: June 30; reporting period for national accounts data: CY.
# [11] Fiscal year end: June 30; reporting period for national accounts data: CY.
# [12] Fiscal year end: June 30; reporting period for national accounts data: FY.
# [13] Fiscal year end: June 30; reporting period for national accounts data: CY.
# 70 Levels:  ...




# QUESTION 5
# 
# You can use the quantmod (http://www.quantmod.com/) package to get historical stock 
# prices for publicly traded companies on the NASDAQ and NYSE. Use the following code 
# to download data on Amazon's stock price and get the times the data was sampled.
# 
# 
# 1
# 2
# 3
# library(quantmod)
# amzn = getSymbols("AMZN",auto.assign=FALSE)
# sampleTimes = index(amzn)
# How many values were collected in 2012? How many values were collected on Mondays in 2012?


amzn <- getSymbols("AMZN", auto.assign = FALSE)

sampleTimes <- index(amzn)
addmargins(table(year(sampleTimes), weekdays(sampleTimes)))


# ANSWER
# > sampleTimes <- index(amzn)
# > addmargins(table(year(sampleTimes), weekdays(sampleTimes)))
# 
# Friday Monday Thursday Tuesday Wednesday  Sum
# 2007     51     48       51      50        51  251
# 2008     50     48       50      52        53  253
# 2009     49     48       51      52        52  252
# 2010     50     47       51      52        52  252
# 2011     51     46       51      52        52  252
# 2012     51     47       51      50        51  250
# 2013     51     48       50      52        51  252
# 2014     50     48       50      52        52  252
# 2015     49     48       51      52        52  252
# 2016     48     44       48      49        49  238
# Sum     500    472      504     513       515 2504
