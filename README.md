# GetCleanProject
Repository for the Getting and Cleaning Data Course Project

## Project Description
The following description is taken directly from the course project page.

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


## run_analysis.R
Note: All these commands are done in the user's working directory.

### Getting Data
The run_analysis.R script starts by downloading and unzipping the UCI HAR dataset using the download.file and unzip functions. 

### Creating Header for Data Set
Using read.table, read in the variable names from features.txt. The variable names were modified as follows:
-Remove "(", ")", "-" and ","
-Fix the "BodyBody" naming error to "Body"
-Change "mean" and "std" to "Mean" and "Std" to adhere to camelCase naming convention
-Final call to make.unique to ensure no repeated names

#### Note on Descriptive Feature Names
The original feature names from the dataset were maintained because they followed a consistent naming convention. While these names are abbreviations, they are descriptive. Please see the CODEBOOK.md, for more details.

### Reading and Merging the Data
Using read.table, subject_test.txt, Y_test.txt, and X_test.txt are imported. These files are combined column-wise into testdata. This was repeated for the files labeled train.

The two data sets are combined row-wise to create allMessyData, a data frame of 10299 observations and 563 varibles. The header for the table was "subject_id" (corresponding to the data in "subject_*.txt"), "activity" (corresponding to the data in "Y_*.txt"), and the variable names cleaned from features.txt (corresponding to the data in "X_*.txt")

## Creating the First Tidy Data Set

Using the dplyr package, variables for the mean and standard deviation were selected along with the subject_id and activity. The meanFreq and angle columns were excluded, because they separate statistics from the mean nor standard deviation. The activity column was modifying, changing the numerical values to descriptive variable names listed in the activity_labels.txt file from the UCI HAR Dataset. The result is meanStdData, a data table with 10299 observations of 68 variables. 

A tidy dataset, as described in the course notes [Components of Tidy Data](https://d396qusza40orc.cloudfront.net/getdata/lecture_slides/01_03_componentsOfTidyData.pdf) are:
1. Each varible you measure should be in one column
2. Each different observation of that variable should be in a different row
3. There should be one table for each "kind" of varible
4. "If you have multiple tables, they should include a column in the table that allows them to be linked"

All the data is of one "kind", that is, measurements from participants completing various exerices. Since the third requirement is satisified, requirement 4 does not apply. The format of this dataset, and the final dataset, is "wide". This choice was made since each feature -- tBodyAccMeanX, etc. -- is a separate dependent variable the same event, fulfilling the the first requirement. This structure also fulfills the second requirement, each row is a separate observation with a subject, activity, and the features. I believe this format better fulfills the second requirement since combining all the features into one column would require the creation of a new column of indices corresponding to the different activity measurements.

### Creation of Final Tidy Data Set
The final data set, avgMeanStd was created using the group_by and summarise_each functions. avgMeanStd consists of the average of each feature for each subject and activity. This tidy data set consists of 180 observations of the 68 variables.