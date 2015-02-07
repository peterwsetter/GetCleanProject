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

### Reading and Merging the Data
Using read.table, subject_test.text, Y_test.txt, and X_test.txt are imported. Names are added to each, identifying the subject_test as "subject_id", y_test as "activity", and X_test with the feature names from features.txt. These files are combined column-wise into testdata.

These steps were repeated for the training data to create the data frame traindata.

The two data sets are combined row-wise to create allMessyData, a data frame of 10299 observations and 563 varibles.

## Cleaning Data
