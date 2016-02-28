# Getting and Cleaning Data Course Project
========================================
run_analysis.R is the script that runs to combine data from different files to single one and write the output to single file. This file contains the process in which run_analysis.R works.


1. Make sure you have GettingandCleaningdata folder in your home directory.

2. Use **source("run_analysis.R")** command in RStudio. 

3. The script **run_analysis.R**
    1. Downloads the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip, extracts the data and renames the folder to "data".
    2. Creates data frame with data combined from train, test, label and subject data
    3. Selects only measurements on the mean and standard deviation for each measurement.
    4. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    5. Writes the output to the file **final_output.txt**.

3. Output file **final_output.txt** is generated as final output of the script with 180 * 81 dimension.
