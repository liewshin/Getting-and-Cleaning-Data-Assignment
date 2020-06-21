## Variable Description
`features` contains the terms that are measured in the datasets

`subjecttrain`, `xtrain`, `ytrain`, `subjecttest`, `xtest`, and `ytest` contain the data from the downloaded files.

## About the Data
`activitylabels` contains the labels for the activities

`features` contains the labels for the datasets

`subjecttest` &  `subjecttrain` contains the subject numbers

`xtest` & `xtrain` contains the values obtained from the testing and training respectively

`ytest` & `ytrain` contains the labels that correspond to the activity from activitylabels

## Transformation
1. Training data was merged by combining `subjecttrain`, `xtrain`, and `ytrain`, while test data was merged by combining `subjecttest`, `xtest`, and `ytest`. These two datasets were then merged together to form one whole dataset
2. The data on mean and standard deviation was extracted out by selecting the corresponding column names.
3. This dataset was appropriately labelled with descriptive activity names.
4. A second dataset with the average of each variable for each activity and each subject was created.
