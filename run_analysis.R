########################################################################################
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive activity names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
########################################################################################
run.analysis <- function() {
  library(data.table)
  ##########################################################
  # Load dependencies
  ##########################################################
  source("constants.R")
  source("analysis_functions.R")
  ##########################################################
  # Create a single dataset as a result of merging the training and test sets
  ##########################################################
  train.dataset <- create.set("train")
  test.dataset <- create.set("test")
  total.dataset <- rbind(train.dataset, test.dataset)
  ##########################################################
  # Free memory
  ##########################################################
  rm(train.dataset, test.dataset)
  ##########################################################
  # Beautify content of dataset
  ##########################################################
  # Define the columns' names
  colnames(total.dataset) <- dataset.column.names()
  # Work only with the columns
  total.dataset <- extract.columns.dataset(total.dataset)
  # Apply labels with activity names
  total.dataset <- label.activity.column(total.dataset)
  ##########################################################
  # Generate output
  ##########################################################
  write.table(create.new.dataset(total.dataset),
    "resultant_dataset.txt",
    sep=",",
    row.names=FALSE,
    quote=FALSE)
  print("All done. Please look for resultant_dataset.txt in the working directory as that contains the resultant dataset.")
}
