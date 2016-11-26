 add2 <- function(x,y) {
   x + y
 }
 
 above10 <- function(x) {
   use <- x>10
   x[use]
 }
 
 above <- function(x,n=10) {
   use <- x>n
   x[use]
 }
 
 columnmean <- function(y) {
   nc <- ncol(y)
   means <- numweric(nc)
   for (1 in 1:nc) {
     means[i] <- mean(y[,i])
   }
   return means
 }