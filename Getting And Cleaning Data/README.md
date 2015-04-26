UCI HAR Dataset Analysis
========================

This repo contains the R scripts that can be used to analysis the [UCI HAR Dataset](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) and convert it into a tidy data set.


## Requirements

To create a R script that does the following


1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Steps to work on this course project

1. Download the data source and put into a folder on your local drive. You'll have a ```UCI HAR Dataset``` folder.
2. Put ```run_analysis.R``` in the parent folder of ```UCI HAR Dataset```, then set it as your working directory using ```setwd()``` function in RStudio.
3. Run ```source("run_analysis.R")```, then it will generate a new file ```tidy_data.txt``` in your working directory.

## Dependencies

```run_analysis.R``` file will help you to install the dependencies automatically. It depends on ```reshape2```

## R code

The R code that is used for analysis is available in the [run_analysis.R](run_analysis.R) file.

Source the file in R using the following command and it will automatically download the dataset, perform the transformation, tidy the data and save it in the file `tidy_data.txt`.

```R
source("run_analysis.R")
```

The tidy data set can be loaded back into R using the following command

```R
tidy_data <- read.table("tidy_data.txt")
```

## Data CodeBook

The [codebook](CodeBook.md) available in this repo describes the variables, the data, the transformations that are done and the clean up that was performed on the data.
