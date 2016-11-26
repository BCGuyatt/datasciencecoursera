pollutantmean <- function(directory, pollutant, id = 1:332) {
    
    ## 'direcotry' is a char vector indicating the location of the CSV files
    ## 'pollutant' is a char vector indicating the name of the pollutant for which we will calculate_
    ## the mean; either 'sulfate' or 'nitrate'
    ## 'id' is an integer indicating which monitor ids to use
    ##
    ## Return the mean poluutant value across all the ids in the id vector.
    ##
    ## Created by BCGuyatt | R Programming Course | Coursera Oct 2016
    
    # get the list of all files in the directory
    listfiles <- list.files(directory)
    
    # initiate the id_values variable with NULL
    id_values <- NULL
    
    for (i in 1:length(id)) {
        
        # read data from the ith data file
        data <- read.csv(file=file.path(directory, listfiles[id[i]]), sep=',', header=TRUE)
        
        # calc mean from the respective pollutant columqqQn of data and store in id_mean
        id_values <- c(id_values, data[which(!is.na(data[,pollutant])),pollutant])
        
    } # end for
    
    # the pollutant mean for all national data from the id monitor subset.
    pollutantmean <- mean(id_values)
    # return pollutantmean
    return(pollutantmean)
    
}