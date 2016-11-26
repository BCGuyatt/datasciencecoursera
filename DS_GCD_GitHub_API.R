### Coursera DataScience Specialization - Getting and Cleaning Data Week 2
#
# Access GitHub from the API (using registered password and uid), collect data
# on instructor's repositories.
#
## Created by BCGuyatt - Nov 2016

# load library
install.packages("httr")
library(httr)
install.packages("httpuv")
library(httpuv)

#    Add your key and secret below.
myapp <- oauth_app("github",
                   key = "8201589d318df6b4b309",
                   secret = "2e4d6f8549a811bdc2e6b512afea0d88ae663de0")

# get OAuth credentials
GH_Token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# Now use the API to collect the data on instructors repositories
gtoken <- config(token = GH_Token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
rec <- content(req)

list(rec)

# using a for loop tick through the 'rec' object to find the "datasharing" repo
for(i in 1:length(rec)){ if(rec[[i]]$name == "datasharing"){index = i} }

# now we have located the index for the datasharing repo we can print the datecreated
print(rec[[index]]$created_at)
