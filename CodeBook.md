---
Title: "Codebook for run_analysis.R"
Author: "Shilp Shah"
Date: "07/01/20"
---

## Project Description
run_analysis.R is meant to perform data preparation and then follow the steps outlined in the assignment description.

Here are the seven steps that run_analysis.R took to achieve that goal.

1. **Downloads the file from the internet and extract the files from the UCI HAR Dataset.**

2. **Assigns data to variables.**\
features <- features.txt : 561 rows, 2 columns\
activities <- activity_labels.txt : 6 rows, 2 columns\
subject_test <- test/subject_test.txt : 2947 rows, 1 column\
x_test <- test/X_test.txt : 2947 rows, 561 columns\
y_test <- test/y_test.txt : 2947 rows, 1 columns\
subject_train <- test/subject_train.txt : 7352 rows, 1 column\
x_train <- test/X_train.txt : 7352 rows, 561 columns\
y_train <- test/y_train.txt : 7352 rows, 1 columns

3. **Merges the training and the test sets to create one data set.**\
X (10299 rows, 561 columns) is created by merging x_train and x_test using **combine()** function\
Y (10299 rows, 1 column) is created by merging y_train and y_test using **combine()** function\
Subject (10299 rows, 1 column) is created by merging subject_train and subject_test using **combine() function\
mergedData (10299 rows, 563 column) is created by merging Subject, Y and X using cbind() function

4. **Extracts only the measurements on the mean and standard deviation for each measurement.**\
tidy (10299 rows, 88 columns) is created by subsetting mergedData, selecting only columns: 
subjectid, code and the measurements on the mean and standard deviation (std) for each measurement

5. **Uses descriptive activity names to name the activities in the data set.**\
Entire numbers in code column of the tidy replaced with corresponding activity taken from second column of the activities variable

6. **Appropriately labels the data set with descriptive variable names.**\
code column in tidy renamed into activities\
All Acc in column’s name replaced by Accelerometer\
All Gyro in column’s name replaced by Gyroscope\
All BodyBody in column’s name replaced by Body\
All Mag in column’s name replaced by Magnitude\
All start with character f in column’s name replaced by Frequency\
All start with character t in column’s name replaced by Time\

7. **From the data set in step 6, creates a second, independent tidy data set with the average of each variable for each activity and each subject.**\
final (180 rows, 88 columns) is created by sumarizing tidy taking the means of each variable for each activity and each subjectid, after grouped by subject and activityid.
Exports final into finaldata.txt file.
