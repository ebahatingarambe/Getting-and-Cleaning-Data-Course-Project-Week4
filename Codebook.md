## Introduction

This file was developped during the assignment on the third course of the Data science specialization. 
It follows 5 steps as provdied in the instructions set up of the assignment.

## Data set information
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. 
Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. 
The experiments have been video-recorded to label the data manually. 
The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

### Download the dataset
Dataset downloaded and extracted under the folder called UCI HAR Dataset on: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### Assign each data to variables
Each data sets was loaded and stored into different objects. The str() function was used to kknow the characterics in object.

- features <- read.table(file.path(myfolder, "features.txt"), col.names = c("n", "functions")), data.frame':	561 obs. of  2 variables:
- activities <- read.table(file.path(myfolder, "activity_labels.txt"), col.names = c("code", "activity")),'data.frame':	6 obs. of  2 variables:

- x_test <- read.table(file.path (myfolder, "test", "X_test.txt"), col.names = features$functions );'data.frame':	2947 obs. of  561 variables:
- y_test <- read.table(file.path (myfolder, "test","y_test.txt"), col.names = "code");'data.frame':	2947 obs. of  1 variable:
- test_subjects <- read.table(file.path (myfolder, "test","subject_test.txt"), col.names = "subject");'data.frame':	2947 obs. of  1 variable:

- x_train <- read.table(file.path (myfolder, "train", "X_train.txt"), col.names = features$functions);'data.frame':	7352 obs. of  561 variables:
- y_train <- read.table(file.path (myfolder, "train","y_train.txt"), col.names = "code");'data.frame':	7352 obs. of  1 variable:
- train_subjects <- read.table(file.path (myfolder, "train","subject_train.txt"), col.names = "subject");'data.frame':	7352 obs. of  1 variable:

### Merges the training and the test sets to create one data set
- X: was obtained by merge merging x_train and x_test using rbind() function; 'data.frame':	10299 obs. of  561 variables:
- Y: was obtained by merging y_train and y_test using rbind() function;'data.frame':	10299 obs. of  1 variable:
- subject: was obtained by merging by merging subject_train and subject_test using rbind() function;'data.frame':	10299 obs. of  1 variable:
- mydf: was obtained by merging all of the previous three merged objects (i.e. subject, Y and X) using cbind() function;'data.frame':	10299 obs. of  563 variables

### Extracts only the measurements on the mean and standard deviation for each measurement
- FinalDf: was created by subsetting mydf, selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement

### Uses descriptive activity names to name the activities in the data set
Entire numbers in code column of the FinalDf replaced with corresponding activity taken from second column of the activities variable

### Appropriately labels the data set with descriptive variable names;
The following are the labelling made to to each column starting with or contaning a specific character:
- code column in FinalDfrenamed into activities
- All `Acc` in column’s name replaced by Accelerometer
- All `Gyro` in column’s name replaced by Gyroscope
- All `BodyBody` in column’s name replaced by Body
- All `Mag` in column’s name replaced by Magnitude
- All start with character `f` in column’s name replaced by Frequency
- All start with character `t` in column’s name replaced by Time

### From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
FinalTidyDf was created by summarizing FinalDf taking the means of each variable for each activity and each subject, after groupped by subject and activity.

### Save the resulting R-script as a text file
Export FinalData into FinalData.txt file.
