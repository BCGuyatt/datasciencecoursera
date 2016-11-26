### DataScience Specialization (DS) - Getting and Cleaning Data (GCD) - Week 2 Quiz
#
# How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page:
#   
# http://biostat.jhsph.edu/~jleek/contact.html
#
# (Hint: the nchar() function in R may be helpful)
#
## Created by BCGuyatt - Nov 2016

## QUESTION 3

con <- url("http://biostat.jhsph.edu/~jleek/contact.html")

html_code <- readLines(con)

close(con)

# print number of characterson 10th line of html object
p1 <- nchar(html_code[10])

# print number of characterson 20th line of html object
p2 <- nchar(html_code[20])

# print number of characterson 30th line of html object
p3 <- nchar(html_code[30])

# print number of characterson 100th line of html object
p4 <- nchar(html_code[100])

# combine and print answer
print(c(p1,p2,p3,p4))

## QUESTION 4 - reading in fixed width file formats (.for)

f <- read.fwf("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for", skip=4,c(12,7,4,9,4,9,4,9,4))

# print the sum of the fourth column
print(sum(f[,4]))

