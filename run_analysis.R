library(data.table)

# Set working directory.
# Data is supposed to be there already...

setwd ('UCI HAR Dataset/')

# Get the features. 2 columns table
features <- read.table ('features.txt', col.names = c ('id', 'name'))

# Keep only features we are interesed in, i.e. mean and std
features <- subset (features, grepl ('-(mean|std)[(]', features$name))

# Get activity labels
labels <- read.table ('activity_labels.txt', col.names = c ('level', 'label'))

# Read training data
y_train = read.table ("train//y_train.txt") #, as.is = T)
x_train = read.table ("train//x_train.txt") #, as.is = T)
s_train = read.table ("train//subject_train.txt")

# Restrict our data to features we are interested in
x_train <- x_train[,features$id]

# And rename columns
names (x_train) <- features$name

# Add subject column to x_train, from s_train
x_train$subject = factor (s_train[,1])

# Add label column to x_train, from y_train but using labels from activity_labels.txt
x_train$label   = factor (y_train[,1], levels = labels$level, labels = labels$label)

# Read training data
y_test  = read.table ("test//y_test.txt") #, as.is = T)
x_test  = read.table ("test//x_test.txt") #, as.is = T)
s_test  = read.table ("test//subject_test.txt")

# Restrict our data to features we are interested in
x_test <- x_test[,features$id]

# And rename columns
names (x_test) <- features$name

# Add subject column to x_train, from s_train
x_test$subject = factor (s_test[,1])

# Add label column to x_train, from y_train but using labels from activity_labels.txt
x_test$label   = factor (y_test[,1], levels = labels$level, labels = labels$label)

# Now, merges both tables
dataset <- rbind (x_train, x_test)

# Convert to data table
dataset <- data.table (dataset)

# Create new set with average per activity (label) and subject
tidyset <- dataset[, lapply (.SD, mean), by=list (label, subject)]

# Let names have a more consistent naming scheme
n <- names (tidyset)

n <- gsub ('-std', 'Std', n)
n <- gsub ('-mean', 'Mean', n)
n <- gsub ('[()]', '', n)
n <- gsub ('BodyBody', 'Body', n)

setnames (tidyset, n)

#
setwd('..')

# Write data to files
write.table (dataset, file = 'rawdata.txt',  row.names = FALSE)
write.table (tidyset, file = 'tidydata.txt', row.names = FALSE, quote = FALSE)

