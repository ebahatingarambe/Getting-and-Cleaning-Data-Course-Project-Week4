library(dplyr)

filename <- "getdata_projectfiles_UCI HAR Dataset.zip"

# Checking if archieve already exists.
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename)
}

# Checking if folder exists and unzip the file
if (!file.exists("UCI HAR Dataset")) {
  unzip(filename)
}

# 1. Merges the training and the test sets to create one data set.

#Create an object to represent my working folder 
myfolder <- "UCI HAR Dataset"

# Read the data
features <- read.table(file.path(myfolder, "features.txt"), col.names = c("n", "functions"))
activities <- read.table(file.path(myfolder, "activity_labels.txt"), col.names = c("code", "activity"))

x_test <- read.table(file.path (myfolder, "test", "X_test.txt"), col.names = features$functions )
y_test <- read.table(file.path (myfolder, "test","y_test.txt"), col.names = "code")
test_subjects <- read.table(file.path (myfolder, "test","subject_test.txt"), col.names = "subject")

x_train <- read.table(file.path (myfolder, "train", "X_train.txt"), col.names = features$functions)
y_train <- read.table(file.path (myfolder, "train","y_train.txt"), col.names = "code")
train_subjects <- read.table(file.path (myfolder, "train","subject_train.txt"), col.names = "subject")

# Bind the rows for each of the data sets together
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
subject <- rbind(train_subjects, test_subjects)

#Merge the objects to create one table and assign them to a new object called "mydf"
mydf <- cbind(subjects, Y, X)

#2. Extracts only the measurements on the mean and standard deviation for each measurement.
FinalDf <- mydf %>% select(subject, code, contains("mean"), contains("std"))

#3. ses descriptive activity names to name the activities in the data set
FinalDf$code <- activities[FinalDf$code, 2]

# 4: Appropriately labels the data set with descriptive variable names
names(FinalDf)[2] = "Activity"
names(FinalDf)<-gsub("Acc", "Accelerometer", names(FinalDf))
names(FinalDf)<-gsub("Gyro", "Gyroscope", names(FinalDf))
names(FinalDf)<-gsub("BodyBody", "Body", names(FinalDf))
names(FinalDf)<-gsub("Mag", "Magnitude", names(FinalDf))
names(FinalDf)<-gsub("^t", "Time", names(FinalDf))
names(FinalDf)<-gsub("^f", "Frequency", names(FinalDf))
names(FinalDf)<-gsub("tBody", "TimeBody", names(FinalDf))
names(FinalDf)<-gsub("angle", "Angle", names(FinalDf))
names(FinalDf)<-gsub("gravity", "Gravity", names(FinalDf))
names(FinalDf)<-gsub("-mean()", "Mean", names(FinalDf), ignore.case = TRUE)
names(FinalDf)<-gsub("-std()", "STD", names(FinalDf), ignore.case = TRUE)
names(FinalDf)<-gsub("-freq()", "Frequency", names(FinalDf), ignore.case = TRUE)


#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
FinalTidyDf <- FinalDf %>% group_by(subject, Activity) %>%  summarise_all(funs(mean))

write.table(FinalTidyDf, "FinalTidyDf.txt", row.name=FALSE)


