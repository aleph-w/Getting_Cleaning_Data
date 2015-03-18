setwd("X:/Coursera/ExDataAnalysis")

features <- read.table("./UCI HAR Dataset/features.txt")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# apply column names
names(x_test) <- t(features[,2])

# extract columns of means and standard deviations and combine them
means <- x_test[, grep('mean', names(x_test))]
sds <- x_test[, grep('std', names(x_test))]
mean_sd <- cbind(means,sds)


# Replace numbers with activity type
for (row in 1:nrow(y_test))
{
  if (y_test[row,1] == 1)
  {
    y_test[row,1] = "WALKING"
  }
  else if (y_test[row,1] == 2)
  {
    y_test[row,1] = "WALKING_UPSTAIRS"
  }
  else if (y_test[row,1] == 3)
  {
    y_test[row,1] = "WALKING_DOWNSTAIRS"
  }
  else if (y_test[row,1] == 4)
  {
    y_test[row,1] = "STANDING"
  }
  else if (y_test[row,1] == 5)
  {
    y_test[row,1] = "STANDING"
  }
  else if (y_test[row,1] == 6)
  {
    y_test[row,1] = "LAYING"
  }
}

# Rename variable
names(y_test) <- c("Activity_Type")

# Combine with means_sd
data_test <- cbind(y_test, mean_sd)

# Rename subject test data variable
names(subject_test) <- c("Subject")

# Combine with dataset
data_test <- cbind(subject_test, data_test)

###
# Repeat with Training set
###
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# apply column names
names(x_train) <- t(features[,2])

# extract columns of means and standard deviations and combine them
means <- x_train[, grep('mean', names(x_train))]
sds <- x_train[, grep('std', names(x_train))]
mean_sd <- cbind(means,sds)


# Replace numbers with activity type
for (row in 1:nrow(y_train))
{
  if (y_train[row,1] == 1)
  {
    y_train[row,1] = "WALKING"
  }
  else if (y_train[row,1] == 2)
  {
    y_train[row,1] = "WALKING_UPSTAIRS"
  }
  else if (y_train[row,1] == 3)
  {
    y_train[row,1] = "WALKING_DOWNSTAIRS"
  }
  else if (y_train[row,1] == 4)
  {
    y_train[row,1] = "STANDING"
  }
  else if (y_train[row,1] == 5)
  {
    y_train[row,1] = "STANDING"
  }
  else if (y_train[row,1] == 6)
  {
    y_train[row,1] = "LAYING"
  }
}

# Rename variable
names(y_train) <- c("Activity_Type")

# Combine with means_sd
data_train <- cbind(y_train, mean_sd)

# Rename subject test data variable
names(subject_train) <- c("Subject")

# Combine with dataset
data_train <- cbind(subject_train, data_train)

# and combine test and train

data_all <- rbind(data_test, data_train)

# Create last tidy dataset:
tidy_data <- c()
for (person in unique(data_all$Subject))
{
  for (activity in unique(data_all$Activity_Type))
  {
    tempsub <- subset(data_all, Subject == person & Activity_Type == activity)
    newrow <- c()
    newrow <- cbind(newrow,person)
    newrow <- cbind(newrow, activity)
    for (col in 3:ncol(tempsub))
    {
      newrow <- cbind(newrow, mean(tempsub[,col]))
    }
    tidy_data <- rbind(tidy_data, newrow)
  }
}

tidy_data <- data.frame(tidy_data)
names(tidy_data) <- names(data_all)

test <- tidy_data

names(test[,1]) <- c("testName")

write.table(tidy_data, "./Data_Cleansing_Project.txt", row.name=FALSE)
