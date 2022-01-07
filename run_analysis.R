directory <- file.path("2ndminiproject", "specdata")
files <- list.files(directory, recursive = TRUE)
files

#Read the files to be used in the project.
featuresTrainData <- read.table(file.path(directory, "train", "X_train.txt"), header = FALSE)
featuresTestData <- read.table(file.path(directory, "test", "X_test.txt"), header = FALSE)

subjectTrainData <- read.table(file.path(directory, "train", "subject_train.txt"), header = FALSE)
subjectTestData <- read.table(file.path(directory, "test", "subject_test.txt"), header = FALSE)

activityTrainData <- read.table(file.path(directory, "train", "Y_train.txt"), header = FALSE)
activityTestData <- read.table(file.path(directory, "test", "Y_test.txt"), header = FALSE)

#Merges the training and the test sets to create one data set.
#rbind() is used to concatenate the sets into one data set. 
featuresDataset <- rbind(featuresTrainData, featuresTestData)
subjectDataset <- rbind(subjectTrainData, subjectTestData)
activityDataset <- rbind(activityTrainData, activityTestData)

#Assign names to variables.
names(subjectDataset) <- c("Subject")
names(activityDataset) <- c("Activity")
featuresDatasetNames <- read.table(file.path(directory, "features.txt"), header = FALSE)
names(featuresDataset) <- featuresDatasetNames$V2

#Combine the tidy data into one data set.
combineDataset <- cbind(subjectDataset, activityDataset)
tidyData <- cbind(featuresDataset, combineDataset)

#Extracts only the measurements on the mean and standard deviation for each measurement.
#Subset the names of features with "mean()" or "std()"
featuresDataSubsetNames <- featuresDatasetNames$V2[grep("mean\\(\\)|std\\(\\)", featuresDatasetNames$V2)]

#Subset the data frame tidyData according to selected names of features.
selectedNames <- c(as.character(featuresDataSubsetNames), "Subject", "Activity")
tidyData <- subset(tidyData, select = selectedNames)
str(tidyData) #Check the structures of the data frame.

#Uses descriptive activity names to name the activities in the dataset
#Read activity's descriptive names from "activity_labels.txt"
activityLabels <- read.table(file.path(directory, "activity_labels.txt"), header = FALSE)
tidyData$Activity <- as.character(tidyData$Activity)
tidyData$Activity[tidyData$Activity == 1] <- "Walking"
tidyData$Activity[tidyData$Activity == 2] <- "Walking upstairs"
tidyData$Activity[tidyData$Activity == 3] <- "Walking downstairs"
tidyData$Activity[tidyData$Activity == 4] <- "Sitting"
tidyData$Activity[tidyData$Activity == 5] <- "Standing"
tidyData$Activity[tidyData$Activity == 6] <- "Laying"
tidyData$Activity <- as.factor(tidyData$Activity)
head(tidyData$Activity, 30)

#Appropriately labels the data set with descriptive variable names.
names(tidyData) <- gsub("^t", "time", names(tidyData))
names(tidyData) <- gsub("^f", "frequency", names(tidyData))
names(tidyData) <- gsub("Acc", "Accelerometer", names(tidyData))
names(tidyData) <- gsub("BodyBody", "Body", names(tidyData))
names(tidyData) <- gsub("Gyro", "Gyroscope", names(tidyData))
names(tidyData) <- gsub("Mag", "Magnitude", names(tidyData))
names(tidyData)

#From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
install.packages("plyr")
library(plyr)
tidyData2 <- aggregate(. ~Subject + Activity, tidyData, mean)
tidyData2 <- tidyData2[order(tidyData2$Subject, tidyData2$Activity),]
write.table(tidyData2, file = "tidyData.txt", row.name = FALSE) 