# Programming Project for the "Getting And Cleaning Data" course
# 2015-09-10

# step 1: Merges the training and the test sets to create one data set.
# x are feature records
x_train <- read.table(file = "UCI HAR Dataset/train/X_train.txt")
x_test <- read.table(file = "UCI HAR Dataset/test/X_test.txt")
x <- rbind(x_train, x_test)
rm(x_train, x_test)

# step 2: Extracts only the measurements on the mean
#         and standard deviation for each measurement.
features <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
x <- x[, features[grep("mean|std", features[, 2]), 1]]
names(x) <- features[grep("mean|std", features[, 2]), 2]
rm(features)

# step 3: Uses descriptive activity names
#         to name the activities in the data set
# y are labels of activities
y_train <- read.table(file = "UCI HAR Dataset/train/y_train.txt")
y_test <- read.table(file = "UCI HAR Dataset/test/y_test.txt")
y <- rbind(y_train, y_test)
rm(y_train, y_test)
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt",
                              row.names = 1, stringsAsFactors = FALSE)
y.x <- cbind("activity" = activity_labels[y[, 1], ], x)
rm(activity_labels, x, y)

# step 4: Appropriately labels the data set with descriptive variable names. 
# Finished in step 2 & 3.

# step 5: From the data set in step 4, creates a second,
#         independent tidy data set with the average of each variable
#         for each activity and each subject.
subject_train <- read.table(file = "UCI HAR Dataset/train/subject_train.txt",
                            colClasses = "character")
subject_test <- read.table(file="UCI HAR Dataset/test/subject_test.txt",
                           colClasses = "character")
subject <- rbind(subject_train, subject_test)
rm(subject_train, subject_test)
subject.y.x <- cbind("subject" = subject[, 1], y.x)
rm(subject, y.x)

# setp 6: save the above data set as a txt file
#         created with write.table() using row.name=FALSE
if (!file.exists("data")) {dir.create("data")}
write.table(x = subject.y.x,
            file = "data/running_data.txt",
            row.name = FALSE)