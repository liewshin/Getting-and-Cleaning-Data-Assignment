#Installing Packages
if(!require(dplyr)){
        install.packages("dplyr")
}
library(dplyr)

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
colnames(subjecttest) <- "SubjectNumber"
colnames(xtest) <- features[,2]
colnames(ytest) <- "ActivityNumber"
colnames(subjecttrain) <- "SubjectNumber"
colnames(xtrain) <- features[,2]
colnames(ytrain) <-"ActivityNumber"

#Merging Test and Training Data
mergedtrain <- cbind(subjecttrain, xtrain, ytrain)
mergedtest <- cbind(subjecttest, xtest, ytest)
mergeddata <- rbind(mergedtrain, mergedtest)

#Extracting Mean and Standard Deviation
extracteddata <- mergeddata %>% select(contains("mean"), contains("std"))

#Naming 
names(extracteddata) <- c("ActivityNumber", "Activity")

#Labelling Dataset
names(extracteddata) <- gsub("Acc", "Accelerometer", names(extracteddata))
names(extracteddata) <- gsub("Gyro", "Gyroscope", names(extracteddata))
names(extracteddata) <- gsub("BodyBody", "Body", names(extracteddata))
names(extracteddata) <- gsub("Mag", "Magnitude", names(extracteddata))
names(extracteddata) <- gsub("^t", "Time", names(extracteddata))
names(extracteddata) <- gsub("^f", "Frequency", names(extracteddata))

#Second Independant Dataset
finaldata <- extracteddata %>%
    group_by(SubjectNumber, Activity) %>%
    summarise_all(funs(mean)) %>%
    ungroup()
write.table(finaldata, "FinalData.txt", row.name=FALSE)
