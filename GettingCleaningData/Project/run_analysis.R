### Coursera | Data Scientist Toolbox | Getting and Cleaning Data | FINAL PROJECT
#
## Created by BCGuyatt | Dec 2016


# load required packages
packages <- c("data.table", "reshape2", "knitr", "markdown")
sapply(packages, library, character.only=TRUE, quietly=TRUE)


###  USER DEFINED INPUT START
# set the working directory in the following line:
pname <- file.path("/Users", "Ben", "Documents", "DataScienceCoursera", "GettingCleaningData", "ProjectTest")
### USER DEFINED INPUT END


# create path names
dpname <- file.path(pname, "UCI HAR Dataset")

# Read the files from the test & train datasets
# read subject files
dtSubjectTrain <- fread(file.path(dpname, "train", "subject_train.txt"))
dtSubjectTest  <- fread(file.path(dpname, "test" , "subject_test.txt" ))

#read the activity files
dtActivityTrain <- fread(file.path(dpname, "train", "Y_train.txt"))
dtActivityTest  <- fread(file.path(dpname, "test" , "Y_test.txt" ))

# read the data files
dtTrain <- fread(file.path(dpname, "train", "X_train.txt"))
dtTest  <- fread(file.path(dpname, "test" , "X_test.txt" ))


# merge the Test and Train datasets for both the Subject & Activity data
dtSubject <- rbind(dtSubjectTrain, dtSubjectTest)
setnames(dtSubject, "V1", "subject")
dtActivity <- rbind(dtActivityTrain, dtActivityTest)
setnames(dtActivity, "V1", "activityNum")
# merge the Train and Test datasets by rows
dt <- rbind(dtTrain, dtTest)


# Merge the combined Subject and Activity datasets by columns
dtSubject <- cbind(dtSubject, dtActivity)
# merge the combined dt and Subject datsets by columns
dt <- cbind(dtSubject, dt)
# Set primary key in the final merged datasets
setkey(dt, subject, activityNum)

# now use the features.txt file to derived which variables in the combined dt variable
# relate to mean and stdev
features <- fread(file.path(dpname, "features.txt"))
setnames(features, names(features), c("Num", "Name"))
features_ms <- features[grepl("mean\\(\\)|std\\(\\)", Name)]
features_ms$Code <- features_ms[, paste0("V", Num)]


# use the code column to subset from the dt table
select <- c(key(dt), features_ms$Code)
dt_sub <- dt[, select, with=FALSE]
setkey(dt_sub, subject, activityNum)

# Now need to derive the activities from the activity_labels.txt file
dtActivityNames <- fread(file.path(dpname, "activity_labels.txt"))
setnames(dtActivityNames, names(dtActivityNames), c("activityNum", "activityName"))

dt_sub <- merge(dt_sub, dtActivityNames, by="activityNum", all.x=TRUE)
setkey(dt_sub, subject, activityNum, activityName)

#reshape dataset from wide format to long format
dt_sub <- data.table(melt(dt_sub, key(dt_sub), variable.name="Code"))
# merge activity name.
dt_sub <- merge(dt_sub, features_ms[, list(Num, Code, Name)], by="Code", all.x=TRUE)

# Create a new variable, activity that is equivalent to activityName as a factor class. 
# Create a new variable, feature that is equivalent to featureName as a factor class.
dt_sub$activity <- factor(dt_sub$activityName)
dt_sub$feature <- factor(dt_sub$Name)

# use an temp function to make the final stage easier to perform
grepfunc <- function (x) {
    grepl(x, dt_sub$feature)
}

## Seperate features from Name using the grepfunc function
## Start with features with 2 categories
n <- 2
y <- matrix(seq(1, n), nrow=n)
x <- matrix(c(grepfunc("^t"), grepfunc("^f")), ncol=nrow(y))
dt_sub$featDomain <- factor(x %*% y, labels=c("Time", "Freq"))
x <- matrix(c(grepfunc("Acc"), grepfunc("Gyro")), ncol=nrow(y))
dt_sub$featInstrument <- factor(x %*% y, labels=c("Accelerometer", "Gyroscope"))
x <- matrix(c(grepfunc("BodyAcc"), grepfunc("GravityAcc")), ncol=nrow(y))
dt_sub$featAcceleration <- factor(x %*% y, labels=c(NA, "Body", "Gravity"))
x <- matrix(c(grepfunc("mean()"), grepfunc("std()")), ncol=nrow(y))
dt_sub$featVariable <- factor(x %*% y, labels=c("Mean", "SD"))
## Consider features with 1 category
dt_sub$featJerk <- factor(grepfunc("Jerk"), labels=c(NA, "Jerk"))
dt_sub$featMagnitude <- factor(grepfunc("Mag"), labels=c(NA, "Magnitude"))
## Finally, look at features with 3 categories
n <- 3
y <- matrix(seq(1, n), nrow=n)
x <- matrix(c(grepfunc("-X"), grepfunc("-Y"), grepfunc("-Z")), ncol=nrow(y))
dt_sub$featAxis <- factor(x %*% y, labels=c(NA, "X", "Y", "Z"))

# Check all features have been accounted for
r1 <- nrow(dt_sub[, .N, by=c("feature")])
r2 <- nrow(dt_sub[, .N, by=c("featDomain", "featAcceleration", "featInstrument", "featJerk", "featMagnitude", "featVariable", "featAxis")])

if (r1 == r2) {message("All the features have been accounted for")
} else {stop("Not all the features have been accounted for: code has been STOPPED.")}

# calculate the average for each veraible and each subset in tidydata format
# this is done using a primary key for all features required
setkey(dt_sub, subject, activity, featDomain, featAcceleration, featInstrument, featJerk, featMagnitude, featVariable, featAxis)
TidyDat <- dt_sub[, list(count = .N, average = mean(value)), by=key(dt_sub)]




# final stage - create the codebook
setwd(pname)
knit("generateCodebook.Rmd", output="codebook.md", encoding="ISO8859-1", quiet=TRUE)
markdownToHTML("codebook.md", "codebook.html")
