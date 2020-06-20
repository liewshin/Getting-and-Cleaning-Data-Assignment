FileData <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
FileLocation <- "Assn3.zip"
download.file(FileData, FileLocation, method = "curl")
