# Jörg Sahlmann
#
# Specialisation Data Science
# Getting and cleaning data
#

library(readr)
library(tidyverse)

# Merges the training and the test sets to create one data set.
# =============================================================

# Read train data sets
x_train <- read.table("dataset/train/X_train.txt", header = FALSE)
x_train$row_id <- seq.int(nrow(x_train))
y_train <- read.table("dataset/train/y_train.txt", header = FALSE)
y_train <- y_train %>% rename(activity_id = V1)
y_train$row_id <- seq.int(nrow(y_train))
subject_train <- read.table("dataset/train/subject_train.txt", header = FALSE)
subject_train$row_id <- seq.int(nrow(subject_train))
subject_train <- subject_train %>% rename(subject = V1)

# Join train data sets
y_train <- left_join(y_train, subject_train, by = "row_id")
x_train <- left_join(y_train, x_train, by = "row_id")

# Read test data sets
x_test <- read.table("dataset/test/X_test.txt", header = FALSE)
x_test$row_id <- seq.int(nrow(x_test))
y_test <- read.table("dataset/test/y_test.txt", header = FALSE)
y_test <- y_test %>% rename(activity_id = V1)
y_test$row_id <- seq.int(nrow(y_test))
subject_test <- read.table("dataset/test/subject_test.txt", header = FALSE)
subject_test$row_id <- seq.int(nrow(subject_test))
subject_test <- subject_test %>% rename(subject = V1)

# Join test and train data sets
y_test <- left_join(y_test, subject_test, by = "row_id")
x_test <- left_join(y_test, x_test, by = "row_id")

# Combine test and training set
all_data <- rbind(x_train, x_test)

# Mapping of activity id and activity name
activity_labels <- read_delim("dataset/activity_labels.txt", delim = " ", col_names = FALSE)
names(activity_labels) <- c("activity_id", "activity")

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
