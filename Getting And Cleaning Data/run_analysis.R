
#Step 1. Merges the training and the test sets to create one data set.
#Step 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#Step 3. Uses descriptive activity names to name the activities in the data set
#Step 4. Appropriately labels the data set with descriptive variable names. 
#Step 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.



## STEP 0: load required packages
if (!require("reshape2")) {
  install.packages("reshape2")
}
# load the reshape2 package (will be used in STEP 5)
require("reshape2")


## STEP 1: Merges the training and the test sets to create one data set

# Read the training data into data frames
train_sub <- read.table("train/subject_train.txt")
train_x <- read.table("train/X_train.txt")
train_y <- read.table("train/y_train.txt")
train <- cbind(train_sub, train_y, train_x)

# Read the test data into data frames
test_sub <- read.table("test/subject_test.txt")
test_x <- read.table("test/X_test.txt")
test_y <- read.table("test/y_test.txt")
test <- cbind(test_sub, test_y, test_x)

#merge the train data and test data sets
merged_data <- rbind(train, test)



## STEP 2: Extracts only the measurements on the mean and standard deviation for each measurement.


# Load and add column names for measurement files
feature_names <- read.table("features.txt", col.names = c("id", "name"))
features <- c("subject", "activity", as.vector(feature_names[, "name"]))

names(merged_data) <- features 

# filter only features that has mean or std in the name
filter_features <- grepl("mean|std|subject|activity", features) & !grepl("meanFreq", features)
feature_data = merged_data[, filter_features]


## STEP 3: Uses descriptive activity names to name the activities in the data set.
activities <- read.table("activity_labels.txt", col.names=c("id", "name"))
for (i in 1:nrow(activities)) {
  feature_data$activity[feature_data$activity == activities[i, "id"]] <- as.character(activities[i, "name"])
}


## STEP 4: Appropriately labels the data set with descriptive activity names. 
descriptive_feature_names <- features[filter_features]
descriptive_feature_names <- gsub("\\(\\)", "", descriptive_feature_names)
descriptive_feature_names <- gsub("Acc", "-acceleration", descriptive_feature_names)
descriptive_feature_names <- gsub("Mag", "-Magnitude", descriptive_feature_names)
descriptive_feature_names <- gsub("^t(.*)$", "\\1-time", descriptive_feature_names)
descriptive_feature_names <- gsub("^f(.*)$", "\\1-frequency", descriptive_feature_names)
descriptive_feature_names <- gsub("(Jerk|Gyro)", "-\\1", descriptive_feature_names)
descriptive_feature_names <- gsub("BodyBody", "Body", descriptive_feature_names)
descriptive_feature_names <- tolower(descriptive_feature_names)

names(feature_data) <- descriptive_feature_names


## STEP 5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# create the tidy data set
melted <- melt(feature_data, id=c("subject","activity"))
tidy_data <- dcast(melted, subject+activity ~ variable, mean)

# write the tidy data set to a file
write.table(tidy_data, "tidy_data.txt", row.names=FALSE)