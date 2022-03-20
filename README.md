# Getting and cleaning data

Written by Jörg Sahlmann

## How the script works

x_train, y_train and subject_train data set will be joined into x_train by a additional common variable row_id.

x_test, y_test and subject_test data set will be joined into x_test by a additional common variable row_id in the same way.

x_train and x_test will be combined in data set all_data.

The activity id and the activity label will be imported and saved in variable activity_labels.


# Mapping of col number and sensor measurement
features <- read_delim("dataset/features.txt", delim = " ", col_names = FALSE)
# Change the variable names to more appropriate names which might serve as correct name without parentheses 
features$X2 <- str_replace_all(features$X2,"-", "_")
features$X2 <- str_replace_all(features$X2,"\\(\\)", "")

# Rename all columns to get the right sequence
names(all_data) <- c("activity_id", "row_id", "subject", features$X2)
# Filter for the columns with mean and standard deviation
vars_mean_std <- which(str_detect(features$X2, "_mean_|_std_"))
features$X2[vars_mean_std]
# Select columns with mean and standard deviation
all_data <- all_data %>% select("activity_id", "subject", features$X2[vars_mean_std])

all_data <- left_join(all_data, activity_labels, by = "activity_id")

## The result of the following line is the data set which satisfies
# - training and test sets are merged
# - only the measurement for mean and standard deviation are included
# - descriptive activity names are used
# - appropriate descriptive variable names are used
all_data <- all_data %>% select("activity", "subject", features$X2[vars_mean_std])


all_data_mean <- all_data %>% group_by(activity, subject) %>% summarize(
  mean_tBodyAcc_mean_X      = mean(tBodyAcc_mean_X),
  mean_tBodyAcc_mean_Y      = mean(tBodyAcc_mean_Y),
  mean_tBodyAcc_mean_Z      = mean(tBodyAcc_mean_Z),
  mean_tBodyAcc_std_X       = mean(tBodyAcc_std_X) ,
  mean_tBodyAcc_std_Y       = mean(tBodyAcc_std_Y) ,
  mean_tBodyAcc_std_Z       = mean(tBodyAcc_std_Z) ,
  mean_tGravityAcc_mean_X   = mean(tGravityAcc_mean_X),
  mean_tGravityAcc_mean_Y   = mean(tGravityAcc_mean_Y),
  mean_tGravityAcc_mean_Z   = mean(tGravityAcc_mean_Z),
  mean_tGravityAcc_std_X    = mean(tGravityAcc_std_X),
  mean_tGravityAcc_std_Y    = mean(tGravityAcc_std_Y),
  mean_tGravityAcc_std_Z    = mean(tGravityAcc_std_Z),
  mean_tBodyAccJerk_mean_X  = mean(tBodyAccJerk_mean_X),
  mean_tBodyAccJerk_mean_Y  = mean(tBodyAccJerk_mean_Y),
  mean_tBodyAccJerk_mean_Z  = mean(tBodyAccJerk_mean_Z),
  mean_tBodyAccJerk_std_X   = mean(tBodyAccJerk_std_X),
  mean_tBodyAccJerk_std_Y   = mean(tBodyAccJerk_std_Y),
  mean_tBodyAccJerk_std_Z   = mean(tBodyAccJerk_std_Z),
  mean_tBodyGyro_mean_X     = mean(tBodyGyro_mean_X),
  mean_tBodyGyro_mean_Y     = mean(tBodyGyro_mean_Y),
  mean_tBodyGyro_mean_Z     = mean(tBodyGyro_mean_Z),
  mean_tBodyGyro_std_X      = mean(tBodyGyro_std_X),
  mean_tBodyGyro_std_Y      = mean(tBodyGyro_std_Y),
  mean_tBodyGyro_std_Z      = mean(tBodyGyro_std_Z),
  mean_tBodyGyroJerk_mean_X = mean(tBodyGyroJerk_mean_X),
  mean_tBodyGyroJerk_mean_Y = mean(tBodyGyroJerk_mean_Y),
  mean_tBodyGyroJerk_mean_Z = mean(tBodyGyroJerk_mean_Z),
  mean_tBodyGyroJerk_std_X  = mean(tBodyGyroJerk_std_X),
  mean_tBodyGyroJerk_std_Y  = mean(tBodyGyroJerk_std_Y),
  mean_tBodyGyroJerk_std_Z  = mean(tBodyGyroJerk_std_Z),
  mean_fBodyAcc_mean_X      = mean(fBodyAcc_mean_X),
  mean_fBodyAcc_mean_Y      = mean(fBodyAcc_mean_Y),
  mean_fBodyAcc_mean_Z      = mean(fBodyAcc_mean_Z),
  mean_fBodyAcc_std_X       = mean(fBodyAcc_std_X),
  mean_fBodyAcc_std_Y       = mean(fBodyAcc_std_Y),
  mean_fBodyAcc_std_Z       = mean(fBodyAcc_std_Z),
  mean_fBodyAccJerk_mean_X  = mean(fBodyAccJerk_mean_X),
  mean_fBodyAccJerk_mean_Y  = mean(fBodyAccJerk_mean_Y),
  mean_fBodyAccJerk_mean_Z  = mean(fBodyAccJerk_mean_Z),
  mean_fBodyAccJerk_std_X   = mean(fBodyAccJerk_std_X),
  mean_fBodyAccJerk_std_Y   = mean(fBodyAccJerk_std_Y),
  mean_fBodyAccJerk_std_Z   = mean(fBodyAccJerk_std_Z),
  mean_fBodyGyro_mean_X     = mean(fBodyGyro_mean_X),
  mean_fBodyGyro_mean_Y     = mean(fBodyGyro_mean_Y),
  mean_fBodyGyro_mean_Z     = mean(fBodyGyro_mean_Z),
  mean_fBodyGyro_std_X      = mean(fBodyGyro_std_X),
  mean_fBodyGyro_std_Y      = mean(fBodyGyro_std_Y),
  mean_fBodyGyro_std_Z      = mean(fBodyGyro_std_Z)  ) %>% ungroup()

write.table(all_data, file = "all_data.txt", row.names = FALSE)
write.table(all_data_mean, file = "all_data_mean.txt", row.names = FALSE)

