## Check efficiency of ways to calculate mean of column pwgtp15
## From the data extracted to variable DT. The method with the
## quickest overall run time is the most efficient.

# Will be using the fread function from the data.table package
#Need to install and load package
require(data.table)

# Load the data
DT <- fread("getdatarest.csv")

#Now run the methods to confirm they calculate the same information, do not save output
M1 <- function(DT){sapply(split(DT$pwgtp15,DT$SEX),mean)}

M2 <- function(DT){DT[,mean(pwgtp15),by=SEX]}

M3 <- function(DT){tapply(DT$pwgtp15,DT$SEX,mean)}

M4 <- function(DT){mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)}

#in order to confirm we have found optimal method,
#run the method 1000 times.
run <- 1000
Method1 <- replicate(run, system.time(M1(DT)))
Method2 <- replicate(run, system.time(M2(DT)))
Method3 <- replicate(run, system.time(M3(DT)))
Method4 <- replicate(run, system.time(M4(DT)))

Method1 <- data.table(Method1)
Method2 <- data.table(Method2)
Method3 <- data.table(Method3)
Method4 <- data.table(Method4)


#Now calculate Min, Mean, Max, on the eapsed time to run the functions
MMM <- matrix(0,4,3)
MMM[1,] <- c(min(as.numeric(Method1[3,])), mean(as.numeric(Method1[3,])), max(as.numeric(Method1[3,])))
MMM[2,] <- c(min(as.numeric(Method2[3,])), mean(as.numeric(Method2[3,])), max(as.numeric(Method2[3,])))
MMM[3,] <- c(min(as.numeric(Method3[3,])), mean(as.numeric(Method3[3,])), max(as.numeric(Method3[3,])))
MMM[4,] <- c(min(as.numeric(Method4[3,])), mean(as.numeric(Method4[3,])), max(as.numeric(Method4[3,])))

# Calculate the cumulative average over all sequences
CumSum1 <- cumsum(as.numeric(Method1[3,])) / seq_along(as.numeric(Method1[3,]))
CumSum2 <- cumsum(as.numeric(Method2[3,])) / seq_along(as.numeric(Method2[3,]))
CumSum3 <- cumsum(as.numeric(Method3[3,])) / seq_along(as.numeric(Method3[3,]))
CumSum4 <- cumsum(as.numeric(Method4[3,])) / seq_along(as.numeric(Method4[3,]))

# Each row in MMM corresponds to a Method. Find the row index for the fastest average runtime, which corresponds 
# to the Method with the fastest runtime.
Best <- which(MMM[,2] == min(MMM[,2]))