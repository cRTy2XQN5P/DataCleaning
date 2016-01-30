# DataCleaning

## run_analysis.R 
This file contains **all** scripts required to process the data.

> To run the scripts, unzip the included data file into the working directory.

### run_analysis
*Main* function. Reads, filters, and processes the raw data.
Then, it calculates the average of each variable for each activity and each subject.
The calculated data is then written to a processed_data.txt file in the working directory.

### GetProcessedData
Reads all the raw data, filters it, and processes it into a single tidy data set.

### MergeDataSets
Reads and merges the train and test data sets from the raw data.
Returns a list with three elements:
1. The merged X data
2. The merged Y data
3. The merged Z (subject) data

### GetColumnsForMeansAndStandardDeviations
Gets the column indices and names for the values that we are interested in from the features.txt file.
Returns a list where the first element is a vector of indices and the second
is a character vector with names.

### ReplaceActivityNumbersWithActivityLabels
Parameter activities is a numeric vector with values 1-6.
Returns a readable character vector for the activities parameter.