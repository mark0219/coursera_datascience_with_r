##########################################
#Getting and Cleaning Data Course Project#
##########################################

#Mark Zhang

require(dplyr)
require(qdap)

#Read data into R
X_train <- read.table('UCI HAR Dataset/train/X_train.txt', header = F, sep = '')
X_test <- read.table('UCI HAR Dataset/test/X_test.txt', header = F, sep = '')
y_train <- read.table('UCI HAR Dataset/train/y_train.txt')
y_test <- read.table('UCI HAR Dataset/test/y_test.txt')
featureNames <- read.table('UCI HAR Dataset/features.txt')
subject_train <- read.table('UCI HAR Dataset/train/subject_train.txt')
subject_test <- read.table('UCI HAR Dataset/test/subject_test.txt')

#Merges the training and the test sets to create one data set
trainSet <- cbind(cbind(X_train, subject_train), y_train)
testSet <- cbind(cbind(X_test, subject_test), y_test)
mergedDataset <- rbind(trainSet, testSet)
colnames(mergedDataset) <- c(as.character(featureNames[,2]), 'subject', 'activities')

#Extracts only the measurements on the mean and standard deviation for each measurement
mergedSubset <- mergedDataset[, c(grep('\\mean\\b', names(mergedDataset)), grep('std()', names(mergedDataset)), 562, 563)]

#Uses descriptive activity names to name the activities in the data set
mergedSubset$activities <- mgsub(c(1,2,3,4,5,6), 
                                 c('WALKING', 
                                   'WALKING_UPSTAIRS', 
                                   'WALKING_DOWNSTAIRS', 
                                   'SITTING', 
                                   'STANDING', 
                                   'LAYING'), mergedSubset$activities)

#Appropriately labels the data set with descriptive variable names
colnames(mergedSubset) <- tolower(colnames(mergedSubset))

#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
newtidyData <- aggregate(x = mergedSubset[, -c(67, 68)], 
                         by = list(activities = mergedSubset$activities,
                                   subject = mergedSubset$subject), FUN = mean)

#Output tidy data
write.table(newtidyData, 'tidyData.txt', row.names = F)

