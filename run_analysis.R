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
extracteddata <- mergedall %>% select(subject, code, contains("mean"), contains("std"))

#Naming Activities
extracteddata$code <- activities[extracteddata$code, 2]

#Labelling Dataset
names(extracteddata)[2] = "activity"
names(extracteddata) <- gsub("Acc", "Accelerometer", names(extracteddata))
names(extracteddata) <- gsub("Gyro", "Gyroscope", names(extracteddata))
names(extracteddata) < -gsub("BodyBody", "Body", names(extracteddata))
names(extracteddata) <- gsub("Mag", "Magnitude", names(extracteddata))
names(extracteddata) <- gsub("^t", "Time", names(extracteddata))
names(extracteddata) <- gsub("^f", "Frequency", names(extracteddata))
names(extracteddata) <- gsub("tBody", "TimeBody", names(extracteddata))
names(extracteddata) <- gsub("-mean()", "Mean", names(extracteddata), ignore.case = TRUE)
names(extracteddata) <- gsub("-std()", "STD", names(extracteddata), ignore.case = TRUE)
names(extracteddata) <- gsub("-freq()", "Frequency", names(extracteddata), ignore.case = TRUE)
names(extracteddata) <- gsub("angle", "Angle", names(extracteddata))
names(extracteddata) <- gsub("gravity", "Gravity", names(extracteddata))

#Second Independant Dataset
finaldata <- extracteddata %>%
    group_by(subject, activity) %>%
    summarise_all(funs(mean))
write.table(finaldata, "FinalData.txt", row.name=FALSE)
