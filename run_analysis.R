#Checking & Retrieving Data
filename <- "assn3.zip"
if(!file.exists(filename)){dir.create("filename")
                           filedata <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
                           download.file(filedata, filename, method = "curl")
                           }

#Unzipping Data
if (!file.exists("assgn3")){dir.create("assgn3")
                            assgn3 <- unzip(zipfile=FileName, exdir="assgn3")
                            }

#Reading Tables
activitylabels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")
subjecttest <- read.table("UCI HAR Dataset/test/subject_test.txt")
xtest <- read.table("UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("UCI HAR Dataset/test/y_test.txt")
subjecttrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
xtrain <- read.table("UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("UCI HAR Dataset/train/y_train.txt")

#Assigning Column Names
colnames(activitylabels) <- c('ActivityNumber','Activity')
colnames(features) <- c('Number','Activity')
colnames(subjecttest) <- "Subject Number"
colnames(xtest) <- features[,2]
colnames(ytest) <- "ActivityNumber"
colnames(subjecttrain) <- "Subject Number"
colnames(xtrain) <- features[,2]
colnames(y_train) <-"ActivityNumber"

#Merging Test and Training Data
mergedtrain <- cbind(subjecttrain, xtrain, ytrain)
mergedtest <- cbind(subjecttest, xtest, ytest)
mergedall <- rbind(mergedtrain, mergedtest)

#Extracting Mean and Standard Deviation
ExtractedData <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))

#Naming Activities
ExtractedData$code <- activities[TidyData$code, 2]

#Labelling Dataset
names(TidyData)[2] = "activity"
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

#Second Independant Dataset
FinalData <- TidyData %>%
    group_by(subject, activity) %>%
    summarise_all(funs(mean))
write.table(FinalData, "FinalData.txt", row.name=FALSE)
