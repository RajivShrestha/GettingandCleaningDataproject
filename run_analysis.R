library(plyr)
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

destfile <- paste(getwd(), "datafile.zip", sep="/")
if(!file.exists(destfile)) {
  download.file(fileurl, destfile)
}

if(!file.exists("data")) {
  unzip("datafile.zip")
  file.rename("UCI HAR Dataset", "data")
}

# 1. Merge the training and the test sets to create one data set.
x_train <- read.table("./data/train/X_train.txt")
y_train <- read.table("./data/train/y_train.txt")
subject_train <- read.table("./data/train/subject_train.txt")

x_test <- read.table("./data/test/X_test.txt")
y_test <- read.table("./data/test/y_test.txt")
subject_test <- read.table("./data/test/subject_test.txt")

combinedData <- rbind(x_train, x_test)
combinedLabel <- rbind(y_train, y_test)
combinedSubject <- rbind(subject_train, subject_test)

# 2. Extracts only the measurements on the mean and the standard deviation for each measurement
features <- read.table("./data/features.txt")
selectedFeatures <- grep("mean(){1}|std(){1}", features[,2])

combinedData <- combinedData[, selectedFeatures]
names(combinedData) <- features[selectedFeatures, 2]

# Make column name more readable
names(combinedData) <- gsub("\\(\\)", "", names(combinedData))
names(combinedData) <- gsub("mean", "Mean", names(combinedData))
names(combinedData) <- gsub("std", "Std", names(combinedData))
names(combinedData) <- gsub("-", "", names(combinedData))

# 3. Use descriptive activity names to name the activities in the data set
activity <- read.table("./data/activity_labels.txt")
activityLabel <- activity[combinedLabel[,1],2]
combinedLabel[,1] <- combinedLabel
names(combinedLabel) <- "activity"

# 4. Appropriately label the data set with the descriptive variable names.
names(combinedSubject) <- "subject"
tidydata <- cbind(combinedSubject, combinedLabel, combinedData)

# 5. From the data set in step 4, create a second independent tidy data set with the average of each vairable for each activity and each subject.
finalData <- ddply(tidydata, .(subject, activity), function(x) colMeans(x[, 3:81]))
names(finalData) <- c("subject", "activity", paste("Mean",names(finalData[,-c(1,2)]), sep=''))
write.table(finalData, "final_output.txt", sep ="\t", row.name=FALSE)
