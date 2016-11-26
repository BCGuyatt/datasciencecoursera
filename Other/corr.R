corr <- function(directory, threshold = 0) {
    
    ## 'directory' is a char vector indicating the location of CSV files
    ## 'threshold' is a numeric value indicating the number of completely_
    ## observed values required before the correlation can be calculated.
    ## Return a numeric value of the correlation between sulfate and nitrate_
    ## in the eligible data sets.
    ##
    ## Created by BCGuyatt | R Programming Course | Coursera Oct 2016
    
    # load the boot library which contains the corr function
    library(stats)
    
    # get list of all files within the directory and calc number of files
    listfiles <- list.files(directory)
    nr <- length(listfiles)
    
    # initialise the cr matrix with a colname
    cr <- matrix(data=NA, nrow=nr, ncol=1, byrow = TRUE)
    colnames(cr) <- 'corr'
    
    for (i in 1:nr) {
        
        # read data from the ith data file
        data <- read.csv(file=file.path(directory, listfiles[i]), sep=',', header=TRUE)
        # count number of values which are not NAs
        NonNA <- length(which(!is.na(data[,2])))
        
        # if number of NonNAs is greater than threshold than perform corr calculation_
        # else skip this row and leave data entry as original NA
        if (NonNA > threshold) {
            cr[i] <- cor(data[,2], data[,3], use = 'na.or.complete')
        } # end if
        
    } # end for
    
    # cr should be a row vector of values and NAs, remove the NAs before returning the object.
    cr <- cr[which(!is.na(cr))]
    
    if (length(cr) == 0){ # if cr is empty then return numeric vector of length 0
        cr <- numeric(length = 0)
    } # end if
    
    return(cr)
    
}