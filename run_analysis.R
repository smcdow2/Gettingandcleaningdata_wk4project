#install.packages("dplyr")
#install.packages("data.table")
#Load packages
library(data.table)
library(dplyr)

#Set working directory
setwd("~/Desktop/Coursera/Getting_and_Cleaning_Data/Week4/Wk4_Project")

#Download data files from the web, unzip files, and save time/date info.
dataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destFile <- "wk4projectdata.zip"
if (!file.exists(destFile)){
  download.file(dataURL, destfile = destFile, mode='wb')
}
if (!file.exists("./UCI_HAR_Dataset")){
  unzip(destFile)
}
dateDownloaded <- date()

#load data and create variables
setwd("./UCI HAR Dataset")

#load and assign training data and variables, x(feature data), y(activity data)
x_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")
subject_train <- read.table("./train/subject_train.txt")
#load and assign test data and variables, x(feature data), y(activity data)
x_test <- read.table("./test/X_test.txt")  
y_test <- read.table("./test/y_test.txt") 
subject_test <- read.table("./test/subject_test.txt")
#Features and Activity data
features <- read.table("./features.txt")
activity_labels <- read.table("./activity_labels.txt")

#Assign column names for the  training data
colnames(x_train) = features[,2]
colnames(y_train) = "activityId"
colnames(subject_train) = "subjectId"
#Assign column names for the  testing data
colnames(x_test) = features[,2]
colnames(y_test) = "activityId"
colnames(subject_test) = "subjectId"
#Assign column names for the activity labels
colnames(activity_labels) <- c('activityId','activityType')

#1. Merge training and test data
mrg_X <- rbind(x_train,x_test)
mrg_Y <- rbind(y_train,y_test)
mrg_subject <- rbind(subject_train,subject_test)
Mrgd_data <- cbind(mrg_subject,mrg_Y,mrg_X)

#2. Extract mean and sd for each measurement
TidyData <- Mrgd_data %>% select(subjectId, activityId, contains("mean"), contains("std"))

#3. Assign descriptive names for the activity names
TidyData$activityId <- activity_labels[TidyData$activityId, 2]

#4 Appropriately label the data with the descriptive variable names
names(TidyData)[2] = "Activity"
names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
names(TidyData)<-gsub("^t", "Time", names(TidyData))
names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))
names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("angle", "Angle", names(TidyData))
names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))

#5 From the data set in step 4, create a second, independent tidy data set with the avg of each variable for each activity and each subject.

TidyData2 <- TidyData %>% group_by(subjectId, Activity) %>% summarise_all(funs(mean))
write.table(TidyData2, "TidyData2.txt", row.name=FALSE)

