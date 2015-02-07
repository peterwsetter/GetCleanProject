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