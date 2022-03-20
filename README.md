# Getting and cleaning data

Written by Jörg Sahlmann

## How the script works

x_train, y_train and subject_train data set will be joined into x_train by a additional common variable row_id.

x_test, y_test and subject_test data set will be joined into x_test by a additional common variable row_id in the same way.

x_train and x_test will be combined in data set all_data.

The activity id and the activity label will be imported and saved in data set activity_labels.

The feature id and the feature label will be imported and saved in data set features. The names of the features will be normalized into a form which might be used as variable name. The minus sign will be replaced by an underscore. Parentheses will be omitted.

All columns of the data set all_data will be renamed with the feature name. The mean and standard deviation variables will be selected.

The activity labels will be joined to the data set.

The result of the following line is the data set all_data which satisfies

  - training and test sets are merged
  - only the measurement for mean and standard deviation are included
  - descriptive activity names are used
  - appropriate descriptive variable names are used

This data set will be summarized by activity and subject. The average for each variable will be calculated and stored in a respective variable. The results will be saved in the data set all_data_mean.

## Code book

The resulting data set all_data_mean includes the following variables.

  - activity: Activity label

  - subject: Subject 

The following variables are the result variables with the average by activity and mean. The name of the variables reflects the statistical value (mean) and the source of the data.

mean_tBodyAcc_mean_X

mean_tBodyAcc_mean_Y

mean_tBodyAcc_mean_Z

mean_tBodyAcc_std_X

mean_tBodyAcc_std_Y

mean_tBodyAcc_std_Z

mean_tGravityAcc_mean_X

mean_tGravityAcc_mean_Y

mean_tGravityAcc_mean_Z

mean_tGravityAcc_std_X

mean_tGravityAcc_std_Y

mean_tGravityAcc_std_Z

mean_tBodyAccJerk_mean_X

mean_tBodyAccJerk_mean_Y

mean_tBodyAccJerk_mean_Z

mean_tBodyAccJerk_std_X

mean_tBodyAccJerk_std_Y

mean_tBodyAccJerk_std_Z

mean_tBodyGyro_mean_X

mean_tBodyGyro_mean_Y

mean_tBodyGyro_mean_Z

mean_tBodyGyro_std_X

mean_tBodyGyro_std_Y

mean_tBodyGyro_std_Z

mean_tBodyGyroJerk_mean_X

mean_tBodyGyroJerk_mean_Y

mean_tBodyGyroJerk_mean_Z

mean_tBodyGyroJerk_std_X

mean_tBodyGyroJerk_std_Y

mean_tBodyGyroJerk_std_Z

mean_fBodyAcc_mean_X

mean_fBodyAcc_mean_Y

mean_fBodyAcc_mean_Z

mean_fBodyAcc_std_X

mean_fBodyAcc_std_Y

mean_fBodyAcc_std_Z

mean_fBodyAccJerk_mean_X

mean_fBodyAccJerk_mean_Y

mean_fBodyAccJerk_mean_Z

mean_fBodyAccJerk_std_X

mean_fBodyAccJerk_std_Y

mean_fBodyAccJerk_std_Z

mean_fBodyGyro_mean_X

mean_fBodyGyro_mean_Y

mean_fBodyGyro_mean_Z

mean_fBodyGyro_std_X

mean_fBodyGyro_std_Y

mean_fBodyGyro_std_Z
