## R Programming Course | Programming Assignment 3 | Nov 2016
##
## Function takes three arguments, state which is a 2-char argument for the 
## US state (eg. texas = TX), outcome is a char vector which defines the 
## condition (eg, heart attack) and num is the ranking in the state for that
## outcome. 
## Created by BCGuyatt

rankhospital <- function(state, outcome, num = "best"){
    
    # Read in the outcome dataset
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    # Create a data frame which references the correct column from data given 
    # the specified outcome
    indexname <- c("Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack",
                   "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure",
                   "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")
    
    # Check the state argument is valid for the dataset
    # States are found within $State column of the datset
    if (!any(data$State == state)){stop("invalid state")}
    
    # Check the outcome argument is valid for the dataset
    if (!any(c("heart attack", "heart failure", "pneumonia") == outcome)){stop("invalid outcome")}
    rn = which(c("heart attack", "heart failure", "pneumonia") == outcome)
    
    # Define the indexname column for reference via colname
    ic <- indexname[rn]
    # create an index row filter to find all hospitals from the specified state
    ir <- which(data$State == state & data[,ic] != "Not Available")
    pos <- order(as.numeric(data[ir,ic]), data$Hospital.Name[ir], na.last = NA)
    
    # Now refer to num variable, to determine which hospital is returrned.
    if(is.character(num)){
        if(num == "best"){
            hospital <- data$Hospital.Name[ir[pos[1]]]
        }else if(num == "worst"){
            pos <- order(as.numeric(data[ir,ic]), -rank(data$Hospital.Name[ir]), na.last = NA, decreasing = TRUE)
            hospital <- data$Hospital.Name[ir[pos[1]]]
        }else{
            stop("num is unrecognised")
        }
    }else if(is.numeric(num)){
        if(num>length(pos)) stop("num is bigger than maximum identified position")
        hospital <- data$Hospital.Name[ir[pos[num]]]
    }else{
        stop("num is neither integer nor character")
    }

    # return the hospital name with the best mortatility rate
    return(hospital)
    
}