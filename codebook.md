The run_analysis.R file prepares the data for processing by doing the following.

1.Download the dataset from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" and the data is extracted under the folder UCI HAR Dataset

2. Assign all data to variables
   - x_train <- train/x_train.txt (7352 rows, 561 columns), Training set.
   - y_train <- train/y_train.txt (7351 rows, 1 column), Traing set labels.
   - subject_train <- train/subject_train.txt (7352 rows, 1 column), Each row identifies the subject who performed the      activity for each window sample. Its range is from 1 to 30. 
   - x_test <- test/x_test.txt ( 2947 rows, 561 columns), Test set.
   - y_test <- test/y_test.txt (2947 rows, 1 column), Test labels.
   - subject_test <- test/subject_test.txt ( 2947 rows, 1 column), Each row identifies the subject who performed the       activity for each window sample. Its range is from 1 to 30. 
   - features <- features.txt ( 561 rows, 2 variables), List of all features,the features selected for this database       come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
   - activity_labels <- activity_labels.txt ( 6 rows of two variables), Links the class labels with their activity  
    name.
3. Added descriptive column names to data.
   - x_train & x_test <- added column names to this data fram from 2nd column of the features data.
   - y_train $ y_test <- added "activityId" as a descriptive column name
   - subject_train & subject_test <- added " subjectId" as a descriptive column name
   
4.Merges the training and the test sets to create one data set.
  - mrg_X (10299 rows and 561 columns) created by merging x_train and x_test using the rbind() function. 
  - mrg_Y (10299 rows and 1 column) created by merging y_train and y_test using the rbind() function.
  - mrg_subject (10299 rows and 1 column) created by merging subject_train and subject_test using the rbind() 
    function.
  - Mrgd_data (10299 rows and 563 columns) created by merging mrg_subject,mrg_Y, and mrg_X, using the cbind()     
    function.

5.Extracts only the measurements on the mean and standard deviation for each measurement.
  - TidyData (10299 rows, 88 columns) is created by subsetting Mrgd_data, selecting only columns: subjectId,    
    activityId and the measurements of mean and standard deviation (std) for each measurement.
   
6.Uses descriptive activity names to name the activities in the data set.
  - Insert the actual activity label names into the Tidy data.
  - TidyData$activityId <- activity_labels[TidyData$activityId, 2]
  
7.Appropriately labels the data set with descriptive variable names.
  - "activityId" column in TidyData renamed into activities.
  - All instances of "Acc" in column’s name replaced by "Accelerometer".
  - All instances of "Gyro" in column’s name replaced by "Gyroscope".
  - All instances of "BodyBody" in column’s name replaced by Body".
  - All instances of "Mag" in column’s name replaced by Magnitude".
  - All instances of the character "f" in column’s name replaced by "Frequency".
  - All instances of the character "t" in column’s name replaced by "Time".

8.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each 
  activity and each subject.
  - TidyData2 (180 rows, 88 columns) is created by sumarizing TidyData taking the means of each variable for each 
    activity and each subject, after groupped by subject and activity.
