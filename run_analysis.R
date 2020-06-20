#Retrieving Data
if (!file.exists(FileName)){
FileData <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
FileName <- "Assn3.zip"
download.file(FileData, FileName, method = "curl")
unzip(FileName)
}
