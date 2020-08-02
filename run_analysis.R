library(dplyr)


filename <- "DSfinal.zip"
if (!file.exists(filename)) {
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileUrl, destfile = filename, method = "curl")
}

if (!file.exists("UCI HAR Dataset")) {
        unzip(filename)
}


features <- read.table("UCI HAR Dataset/features.txt", 
                       col.names = c("numbers","feat"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", 
                         col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", 
                           col.names = "subjectid")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", 
                     col.names = features$feat)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", 
                     col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", 
                            col.names = "subjectid")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", 
                      col.names = features$feat)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", 
                      col.names = "code")


X <- combine(x_train, x_test)
Y <- combine(y_train, y_test)
Subject <- combine(subject_train, subject_test)
mergedData <- cbind(Subject, Y, X)


tidy <- mergedData %>% select(subjectid, code, contains("mean"), contains("std"))
tidy$code <- activities[tidy$code, 2]
names(tidy)[2] = "activity"

names(tidy) <-gsub("Acc", "Accelerometer", names(tidy))
names(tidy) <-gsub("Gyro", "Gyroscope", names(tidy))
names(tidy) <-gsub("BodyBody", "Body", names(tidy))
names(tidy) <-gsub("Mag", "Magnitude", names(tidy))
names(tidy) <-gsub("^t", "Time", names(tidy))
names(tidy) <-gsub("^f", "Frequency", names(tidy))
names(tidy) <-gsub("tBody", "TimeBody", names(tidy))
names(tidy) <-gsub("-mean()", "Mean", names(tidy), ignore.case = TRUE)
names(tidy) <-gsub("-std()", "STD", names(tidy), ignore.case = TRUE)
names(tidy) <-gsub("-freq()", "Frequency", names(tidy), ignore.case = TRUE)
names(tidy) <-gsub("angle", "Angle", names(tidy))
names(tidy) <-gsub("gravity", "Gravity", names(tidy))


final <- tidy %>% group_by(subjectid, activity) %>% summarise_all(funs(mean))
write.table(final, "finaldata.txt")
