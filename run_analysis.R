run_analysis <- function(){
    library(plyr)
    
    processed_data <- GetProcessedData()
    
    # Calculate the average of each variable for each activity and each subject
    processed_data <- ddply(processed_data, .(subject, activity), colwise(mean))
    
    write.table(processed_data, file.path("processed_data.txt"), row.names = F)
}

GetProcessedData <- function(){
    merged_data <- MergeDataSets()
    
    merged_xdata <- merged_data[[1]]
    merged_ydata <- merged_data[[2]]
    merged_zdata <- merged_data[[3]]
    
    cols <- GetColumnsForMeansAndStandardDeviations()
    cols_indices <- cols[[1]]
    cols_names <- cols[[2]]
    
    # Filter on the columns we are interested on and add their names
    filtered <- merged_xdata[, cols_indices]
    colnames(filtered) <- cols_names
    
    # Create the activity column for the observations
    activity <- ReplaceActivityNumbersWithActivityLabels(merged_ydata)
    
    # Create the subject column for the observations
    # Convert the data.frame to a vector so that the name is used as the column name
    subject <- merged_zdata[,1]
    
    # Add the activity and subject columns
    filtered <- cbind(filtered, activity, subject)
    
    return(filtered)
}

MergeDataSets <- function(){
    # Define paths to train files
    trainRootPath <- file.path("UCI HAR Dataset", "train")
    xTrainFilePath <- file.path(trainRootPath, "x_train.txt")
    yTrainFilePath <- file.path(trainRootPath, "y_train.txt")
    zTrainFilePath <- file.path(trainRootPath, "subject_train.txt")
    
    # Define paths to test files
    testRootPath <- file.path("UCI HAR Dataset", "test")
    xTestFilePath <- file.path(testRootPath, "x_test.txt")
    yTestFilePath <- file.path(testRootPath, "y_test.txt")
    zTestFilePath <- file.path(testRootPath, "subject_test.txt")
    
    # Merge x files
    x_train <- read.table(xTrainFilePath)
    x_test <- read.table(xTestFilePath)
    x_merged <- rbind(x_train, x_test)
    
    # Merge y files
    y_train <- read.table(yTrainFilePath)
    y_test <- read.table(yTestFilePath)
    y_merged <- rbind(y_train, y_test)
    
    # Merge z files
    z_train <- read.table(zTrainFilePath)
    z_test <- read.table(zTestFilePath)
    z_merged <- rbind(z_train, z_test)
    
    return(list(x_merged, y_merged, z_merged))
}

GetColumnsForMeansAndStandardDeviations <- function(){
    # Read the list of features
    featuresFilePath <- file.path("UCI HAR Dataset", "features.txt")
    features <- read.table(featuresFilePath)
    features <- features[,2]
    
    # Find the indices for mean and std
    mean_indices <- grep("mean", features)
    std_indices <- grep("std", features)
    
    # Combine the indices and order them
    indices <- c(mean_indices, std_indices)
    indices <- indices[order(indices)]
    
    # Get the names for the indices
    names <- as.character(features[indices])
    
    return(list(indices, names))
}

ReplaceActivityNumbersWithActivityLabels <- function (activities){
    activityLabelsFilePath <- file.path("UCI HAR Dataset", "activity_labels.txt")
    activityLabels <- read.table(activityLabelsFilePath)

    # Convert activities to a data frame so that we can later apply a join
    activities <- data.frame(activities)
    colnames(activities) <- c("ID")
    
    # Do a left join on activities.ID and activityLables.V1
    activities <- merge(activities, activityLabels, by.x = "ID", by.y = "V1")
    
    # Return the labels without the IDs
    return(as.character(activities[,2]))
}
    