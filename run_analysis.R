## This script runs an analysis on the UCI HAR dataset
## producing two tidy datasets:
## 1. The mean and standard deviation information from the test and training
## 2. The mean of each variable for each activity and each subject.
## This script is part of the course project for Getting and Cleaning
## Data of the Data Science Specialization.
## For more information and discussion, please see the ReadMe.md in this repo

## Download and unzip the dataset into the working directory
#fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#destfilename <- "UCI HAR dataset.zip"
#download.file(fileurl, destfile = destfilename, method = "curl")
#unzip(destfilename)

## Import test data
#subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
#x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
#y_test <- read.table("./UCI HAR Dataset/test/Y_test.txt")

## Add names
#featurenames <- read.table("./UCI HAR Dataset/features.txt")

fixes <- c("\\(", "\\)", "\\-", "\\,")
cleanNames <- featurenames$V2
for (fix in fixes) {
        cleanNames <- gsub(fix, "", cleanNames,)
}
cleanNames <- gsub("BodyBody", "Body", cleanNames,)
cleanNames <- gsub("mean", "Mean", cleanNames,)
cleanNames <- gsub("std", "Std", cleanNames,)
cleanNames <- make.unique(cleanNames)

# Merge all the test data in the order of subject, activity, and collected data
#testdata <- cbind(subject_test, y_test, x_test)

# Import, name, and merge the training data as above
#subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
#x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
#y_train <- read.table("./UCI HAR Dataset/train/Y_train.txt")

#traindata <- cbind(subject_train, y_train, x_train)

# Combine test and training data into a single data frame
allMessyData <- rbind(testdata, traindata)
names(allMessyData) <- c("subject_id", "activity", cleanNames)
anyDuplicated(cleanNames)