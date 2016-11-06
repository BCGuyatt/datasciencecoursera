## R Programming Course | Programming Assignment 3 | Nov 2016
##
## Function takes two arguments, outcome is a char vector which defines the 
## condition (eg, heart attack) and num is the ranking for that outcome. 
## Function returns the ranked hospital for each state in a data frame rankall
##
## Created by BCGuyatt

rankall <- function(outcome, num = "best"){
    
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
    
    # Define the indexname column for reference via colname
    ic <- indexname[rn]
    
    # calculate the number and names of unique states
    statenames <- sort(unique(data$State))
    
    # initialise the data frame which stores hospital name and state
    hospitalnames <- character(length(statenames))
    #row.names(hospitalnames) <- statenames
    
    for (i in 1:length(statenames)){  #loop through each state and return the ranked hospital name
        
        # create an index row filter to find all hospitals from the specified state
        ir <- which(data$State == statenames[i] & data[,ic] != "Not Available")
    
        # Now refer to num variable, to determine which hospital is returrned.
        if(is.character(num)){
            if(num == "best"){
                pos <- order(as.numeric(data[ir,ic]), data$Hospital.Name[ir], na.last = NA)
                hospital <- data$Hospital.Name[ir[pos[1]]]
            }else if(num == "worst"){
                pos <- order(as.numeric(data[ir,ic]), -rank(data$Hospital.Name[ir]), na.last = NA, decreasing = TRUE)
                hospital <- data$Hospital.Name[ir[pos[1]]]
            }else{
                stop("num is unrecognised")
            }
        }else if(is.numeric(num)){
            pos <- order(as.numeric(data[ir,ic]), data$Hospital.Name[ir], na.last = NA)
            if(num>length(pos)){
                hospital <- NA
            } else{
                hospital <- data$Hospital.Name[ir[pos[num]]]
            }
        }else{
            stop("num is neither integer nor character")
        }
        
        # now collect the hospital names in a data frame with the included state name
        hospitalnames[i] <- hospital
        
    }
    
    # create the data frame using the hospitalnames and statenames variables
    hospitalrankall <- data.frame(hospital = hospitalnames, state = statenames)
    row.names(hospitalrankall) <- statenames
    
    #return the data frame
    return(hospitalrankall)
    
}

##Nice use of subset for future reference:
##r <- rankall("heart failure", 10)
##as.character(subset(r, state == "NV")$hospital)