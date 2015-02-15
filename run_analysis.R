## This script runs an analysis on the UCI HAR dataset
## producing two tidy datasets:
## 1. The mean and standard deviation information from the test and training
## 2. The mean of each variable for each activity and each subject.
## This script is part of the course project for Getting and Cleaning
## Data of the Data Science Specialization.
## For more information and discussion, please see the ReadMe.md in this repo

## Download and unzip the dataset into the working directory
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destfilename <- "UCI HAR dataset.zip"
download.file(fileurl, destfile = destfilename, method = "curl")
unzip(destfilename)

## Create header for data set
featurenames <- read.table("./UCI HAR Dataset/features.txt")

## Remove "(", ")", "," and "-" from the names of the features
fixes <- c("\\(", "\\)", "\\-", "\\,")
cleanNames <- featurenames$V2
for (fix in fixes) {
        cleanNames <- gsub(fix, "", cleanNames,)
}

cleanNames <- gsub("BodyBody", "Body", cleanNames,)
## Change lowercase "mean" and "std" to uppercase for camelCase naming
## of varibles
cleanNames <- gsub("mean", "Mean", cleanNames,)
cleanNames <- gsub("std", "Std", cleanNames,)
cleanNames <- make.unique(cleanNames)

## Read test data
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/Y_test.txt")

# Merge all the test data in the order of subject, activity, and collected data
testdata <- cbind(subject_test, y_test, x_test)

# Import, name, and merge the training data as above
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/Y_train.txt")

traindata <- cbind(subject_train, y_train, x_train)

# Combine test and training data into a single data frame
allMessyData <- rbind(testdata, traindata)
names(allMessyData) <- c("subject_id", "activity", cleanNames)
anyDuplicated(cleanNames)

## Load dplyr library for data manipulations
library(dplyr)

## Convert dataframe to a tbl_df from the dplyr package
allMessyData <- tbl_df(allMessyData)

## Select columns that include data on the mean or standard deviation
meanStdData <- select(allMessyData, 
                      subject_id, 
                      activity, 
                      contains("mean"), 
                      contains("std"),
                      -contains("angle"),
                      -contains("Freq"))

## Replace numbered activity names with descriptive activty names
meanStdData$activity <- as.character(meanStdData$activity)
meanStdData$activity <- gsub('1', 'walking', meanStdData$activity)
meanStdData$activity <- gsub('2', 'walkingUpstairs', meanStdData$activity)
meanStdData$activity <- gsub('3', 'walkingDownstairs', meanStdData$activity)
meanStdData$activity <- gsub('4', 'sitting', meanStdData$activity)
meanStdData$activity <- gsub('5', 'standing', meanStdData$activity)
meanStdData$activity <- gsub('6', 'laying', meanStdData$activity)

## Use group_by and summarise_each to create final data set
## Citation http://stackoverflow.com/questions/21644848/summarizing-multiple-columns-with-dplyr?rq=1

avgMeanStd <- meanStdData %>%
group_by(subject_id, activity) %>%
        summarise_each(funs(mean))

write.table(avgMeanStd, file = "avgMeanStd.txt")