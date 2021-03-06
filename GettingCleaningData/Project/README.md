## This is the README file for the Getting and Cleaning Data Project

### Aim of the porject:

### Instructions

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set.
Review criterialess 
The submitted data set is tidy.
The Github repo contains the required scripts.
GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.
The README that explains the analysis files is clear and understandable.
The work submitted for this project is the work of the student who submitted it.
Getting and Cleaning Data Course Projectless 
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following.

Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement.
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names.
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Good luck!



## To run script for this project:

1. From the GitHub Repository download the following files to your working directory: 
..1. Dataset.zip, 
..2. generateCodebook.Rmd, 
..3.  README.txt, 
..4. run_analysis.r.
2. Unzip the Dataset.zip using a archive package such as 7zip. 
This must be unpacked to a sub folder in the working directory called: 
"UCI HAR Dataset"
3. Open the r_script called run_analysis.r using a text editor
4. On line 14 of the script add your working directory pathname, 
this working directory should contain the zip file folder 
"UCI HAR Dataset" as per step 2 above.
5. Run the R script - it runs the analysis, creates the tidy data 
text file and generates the codebook at the end using the 
generateMarkdown.Rmd file.

## Outputs produced:

1. Tidy dataset file DatasetHumanActivityRecognitionUsingSmartphones.txt (tab-delimited text)
2. Codebook file codebook.md (Markdown)