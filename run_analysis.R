# Part 2
# Read activity ID, subject ID and data column names for each dataset
# and combine to create tidy data table

data = function (folder) {
  ## Activity ID key ##
  path = file.path(folder, paste0("y_", folder, ".txt"))
  y_data = read.table(path, header=FALSE, col.names = c("ActiviytID"))
  ## subject ID ##
  path = file.path(folder, paste0("subject_", folder, ".txt"))
  subject_data = read.table(path, header=FALSE, col.names=c("SubjectID"))
  ## Column key ##
  data_columns = read.table("features.txt", header=FALSE, as.is=TRUE, col.names=c("MeasureID", "MeasureName"))
  
  ## data ##
  path = file.path(folder, paste0("X_", folder, ".txt"))
  dataset = read.table(path, header=FALSE, col.names=data_columns$MeasureName)
  
  
  ## Subset to mean and std only ##
  subset_data_columns = grep(".*mean\\(\\)|.*std\\(\\)", data_columns$MeasureName)
  
  dataset = dataset[, subset_data_columns]
  
  dataset$ActivityID = y_data$ActivityID
  dataset$SubjectID = subject_data$SubjectID
  
  dataset
}

# read and construct test
read_test = function() {
  data("test")
}

# read and construct train
read_train = function () {
  data("train")
}

# Part 1: merge datasets and give proper column names
mergeDataset = function () {
  dataset = rbind(read_test(), read_train())
  cnames = colnames(dataset)
  cnames = gsub("\\.+mean\\.+", cnames, replacement = "Mean")
  cnames = gsub("\\.+std\\.+", cnames, replacement = "Std")
  colnames(dataset) = cnames
  dataset
}

# Part 3 & Part 4
# Assign appropriate activity labels to each row of data
activityLabels = function (dataset) {
  activity_labels = read.table("activity_labels.txt", header = FALSE, as.is=TRUE, col.names = c("ActivityID", "ActivityName"))
  activity_labels$ActivityName = as.factor(activity_labels$ActivityName)
  data_labels = merge(dataset, activity_labels)
  data_labels
}

# merging the activity labels to the merged dataset
merge_label_data = function () {
  activityLabels(mergeDataset())
}

# Part 5
# Creating a second, independent tidy data set with the average of each variable for each activity and each subject. 
tidyData = function(merge_label_data) {
  library(reshape2)
  
  vars = c("ActivityID", "ActivityName", "SubjectID")
  measure_vars = setdiff(colnames(merge_label_data), vars)
  melted_data <- melt(merge_label_data, id=vars, measure.vars=measure_vars)
  
  # recast 
  dcast(melted_data, ActivityName + SubjectID ~ variable, mean)
}

#Getting the clean tidy dataset
final_datafile =function(folder){
  tidy_data = tidyData(merge_label_data())
  write.table(tidy_data, folder)
}

final_datafile("final_output.txt")
