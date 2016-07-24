# Getting and Cleaning Data - Mentor assessment project

The data was collected from the accelerometers from the Samsung Galaxy S smartphone. A full description of the data is available at:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data can be downloaded from:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

In the run_analysis.R script, functions were created for each step.

Function data :
This function takes one variables, which happens to be boththe suffix for the filename and the folder name in which the file exists
as the data exists in both train and test folders with file names as subject_folder, X_folder, y_folder. 
The y_data file contains Activity_ID. The X_data file contains data for MeasureID and MeasureName.
The subject_data file contains SubjectID.
This function reads the three files from a folder and creates data.frame in R environment with appropriate column names.
The grep function is used to match only those columns which are means or standard deviations.

Function read_test :
This function is used to read the test data into the R environment

Function read_train :
This function is used to read the train data into the R environment

Function mergeDataset :
This function binds the two dataset read in the above functions by rows and the appropriate column names are assigned

Function activityLabels:
This function takes a dataset as argument and reads the activity labels from text files and merges it with the dataset.

Function merge_label_data :
This function runs the activityLabels function to get a activity labelled dataset.

Function tidyData:
This function creates a tidy data set with average of each variable for each activity and each subject.

Function tidy_datafile:
A new tidy independent dataset is generated and saved a text file to be submitted.
