complete <- function(directory, id = 1:332) {
    
    ## 'directory' is a char vector indicating the location of CSV files
    ## 'id' is the monitor id upon which to extract the data
    ## Function returns a data.frame of the form:
    ## id nobs
    ## 1 117
    ## 2 1041
    ## ...
    ## where 'id' is the monitor is and 'nobs' is the number of complete cases
    ##
    ## Created by BCGuyatt | R Programming Course | Coursera Oct 2016
    
    # get list of all files within the directory and calc number of files
    listfiles <- list.files(directory)
    
    # initialise datanobs matrix and add colnames
    datanobs <- matrix(0, nrow=length(id), ncol=2, byrow = TRUE)
    colnames(datanobs) <- c('id','nobs')
    
    for (i in 1:length(id)) {
    
        # read data from the ith data file
        data <- read.csv(file=file.path(directory, listfiles[id[i]]), sep=',', header=TRUE)
        
        # extract the data values not equal to NA
        datanobs[i,] <- c(data[i,4], length(which(!is.na(data[,2]))))
        
    } # end for
    
    # convert the datanobs matrix to a data frame and return
    complete <- as.data.frame(datanobs)
    return(complete)
    
}