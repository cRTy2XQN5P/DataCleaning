# Codebook

## processed_data.txt

This is the product of running the run_anaylisis script. The script:
1. Merges all the raw data:
1.1 Training and test data is merged
1.2 Subject information is added as a column
1.3 Activity name is added as a column.
2. Makes the data as human readable as possible, by adding activity labels and column names.
3. Selects all the means and standard deviations for each observation, while removing all other variables.
4. Calculates the mean values by aggregating the data by subject and activity

The final data set has 81 variables of which:
* The "subject" column is an identifier for the study participants
* The "activity" column describes the activity that subjects were performing during the study.
* All other values (and units) are described in the README.txt and the features_info.txt files found in the zipped file.


