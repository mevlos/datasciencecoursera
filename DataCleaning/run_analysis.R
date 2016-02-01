
# Load libraries
library(dplyr)
library(tidyr)

# Load data tables training
subject_train <- read.table("train/subject_train.txt")
X_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")

# Load data tables test
subject_test <- read.table("test/subject_test.txt")
X_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")

# Load labels
activity_labels <- read.table("activity_labels.txt")
features <- read.table("features.txt")

# Rename the columns of X
names(X_train) <- features$V2
names(X_test) <- features$V2

# Change of the values of y with the correct activity labels
y_train <- left_join(y_train,activity_labels) %>% select(V2)
y_test <- left_join(y_test,activity_labels) %>% select(V2)

# Rename the column of y and subject
names(y_train) <- "activity"
names(y_test) <- "activity"
names(subject_train) <- "subject"
names(subject_test) <- "subject"

# Join the columns
data_train = cbind(subject_train,X_train,y_train)
data_test = cbind(subject_test,X_test,y_test)

# Merge the two data sets
data <- rbind(data_train,data_test)

# Look for indices of the columns with mean and standard deviation
indices <- grep("[mM]ean()|std()", names(data))

# Add the indices for sunject (1) and y (563)
indicest <- c(1,indices,563)

# Select the columns with mean and standard deviation
data1 <- data[,indicest]

# data1 is the data set wanted at question 4. 

# Buiding of data2, the data set wanted at question 5.
data2 <- group_by(data1,subject,activity) %>% summarise_each(funs(mean))

# Save data2
write.table(data2, file = "data2.txt", row.name = FALSE)



