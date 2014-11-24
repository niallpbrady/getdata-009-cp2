getdata-009-cp2
===============

Course project 2 for Coursera "Getting and Cleaning Data" course

Steps performed to create tidy data set:

1. Read in the following files:
  UCI HAR Dataset\\train\\X_train.
  UCI HAR Dataset\\train\\y_train.txt
  UCI HAR Dataset\\train\\subject_train.txt
  UCI HAR Dataset\\test\\X_test.txt
  UCI HAR Dataset\\test\\y_test.txt
  UCI HAR Dataset\\test\\subject_test.txt
  UCI HAR Dataset\\features.txt

2. Merge the x and y traning and test datasets
3. Merge the subject data into one dataset
4. Merge the training and test datasets with the combined subject dataset into a list of datasets (merged_full)
5. Identify the mean and standard deviation columns in the feaures file
6. Extract the mean and standard deviation columns into seperate dataset (merged_mean.std)
7. Take the activity descriptions and apply them as meaningul values to the main dataset
8. Create the tidy dataset by merging the main dataset, mean/std dataset and subject dataset  from the merged_full list into a single dataset
9. Write the tidy dataset to a txt file
