## R Programming Course | Programming Assignment 3 | Nov 2016
##
## Create a function which takes two arguments, the name of the state and an
## outcome argument. The function then calculates the hospoital state with the
## best (lowest) mortality for the specified state.
##
## Created by BCGuyatt

best <- function(state, outcome){
    
    # Read in the outcome dataset
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    # Create a data frame which references the correct column from data given 
    # the specified outcome
    indexname <- c("Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack",
                              "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure",
                              "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")

    # Check the outcome argument is valid for the dataset
    if (!any(c("heart attack", "heart failure", "pneumonia") == outcome)){stop("invalid outcome")}
    rn = which(c("heart attack", "heart failure", "pneumonia") == outcome)
    
    # Check the state argument is valid for the dataset
    # States are found within $State column of the datset
    if (!any(data$State == state)){stop("invalid state")}
    
    # Define the indexname column for reference via colname
    ic <- indexname[rn]
    # create an index row filter to find all hospitals from the specified state
    ir <- which(data$State == state & data[,ic] != "Not Available")
    pos <- sort(as.numeric(data[ir,ic]), decreasing = FALSE, na.last = NA, index.return = TRUE)
    
    # find the hospotal with the best mortality rate, if there are multiply 
    # names sort alphabetically and return the first hospital only
    hospital <- data$Hospital.Name[ir[pos$ix[1]]]
    
    # return the hospital name with the best mortatility rate
    return(hospital)
    
}