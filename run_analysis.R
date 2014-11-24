##clear global environment
rm(list=ls())

##ensure plyr package is ready to use
library("plyr")

##ensure working directory is set correctly for files to be ready
setwd("C:\\Users\\n_brady\\Documents")

##read in files
training_x <- read.table("UCI HAR Dataset\\train\\X_train.txt")

training_y <- read.table("UCI HAR Dataset\\train\\y_train.txt")

training_subject <- read.table("UCI HAR Dataset\\train\\subject_train.txt")

test_x <- read.table("UCI HAR Dataset\\test\\X_test.txt")

test_y <- read.table("UCI HAR Dataset\\test\\y_test.txt")

test_subject <- read.table("UCI HAR Dataset\\test\\subject_test.txt")

features <- read.table("UCI HAR Dataset\\features.txt")

##merge x and y datasets using row-binding
merged_x <- rbind(training_x, test_x)
merged_y <- rbind(training_y, test_y)

##merge subject dataset using row-binding
merged_subject <- rbind(training_subject, test_subject)

# merge train and test datasets and return
merged_full <- list(x=merged_x, y=merged_y, subject=merged_subject)

# get the mean and std columns
mean.col <- sapply(features[,2], function(x) grepl("mean()", x, fixed=T))
std.col <- sapply(features[,2], function(x) grepl("std()", x, fixed=T))

# extra mean and std columns from datasets
merged_mean.std <- merged_full$x[, (mean.col | std.col)]
colnames(merged_mean.std) <- features[(mean.col | std.col), 2]

##assign meaningful values to activities
merged_full$y[merged_full$y[,1] == "1", 1] <- "WALKING"
merged_full$y[merged_full$y[,1] == "2", 1] <- "WALKING_UPSTAIRS"
merged_full$y[merged_full$y[,1] == "3", 1] <- "WALKING_DOWNSTAIRS"
merged_full$y[merged_full$y[,1] == "4", 1] <- "SITTING"
merged_full$y[merged_full$y[,1] == "5", 1] <- "STANDING"
merged_full$y[merged_full$y[,1] == "6", 1] <- "LAYING"

##prepare sub-datasets for merging
colnames(merged_full$y) <- "activity"

colnames(merged_full$subject) <- c("subject")

##merge datasets into tidy dataset
merged_full_tidy <- cbind(merged_mean.std, merged_full$y, merged_full$subject)

merged_full_tidy <- ddply(merged_full_tidy, .(subject, activity), function(x) colMeans(x[,1:60]))

##write tidy dataset to file
write.csv(merged_full_tidy, "UCI_HAR_tidy.txt", row.names=FALSE)
