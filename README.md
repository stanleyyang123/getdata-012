
# Getting and Cleaning - Peer Assessment

---

## Assignement

Assignement is as follow (from the course page):

From the data set available here :

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following.
 1. Merges the training and the test sets to create one data set.
 2. Extracts only the measurements on the mean and standard deviation for each measurement.
 3. Uses descriptive activity names to name the activities in the data set
 4. Appropriately labels the data set with descriptive variable names.
 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


## How this was done

The script is called run_annalysis.R and has the following step (fully
commented in the code)

We first load the features and activity labels that are stored into
their own file. Using `grep`, we keep only labels that have `mean` or `std`
into their name, in order to only keep the columns we are interested
from the data sets (as specified in step 2).

Then we load both sets of data (training, and test). For both sets, we
load the 3 tables (`x_`, `s_` and `y_` prefixes). Data is in the `x_`
and perform the following transformations:
 1. Subset columns with the features we are interested in
 2. Rename columns with features names previously loaded (requirement
4)
 3. Add a subject columns (will be used later), from `s_*` file
 4. Add an activity lable columns from previously, from `y_*` file

Both tables are processed the same way (could have used a function
with table's names as input, instead of duplicating code).

Then we merge both tables (requirement 1).

At this point, we more or less have answered requirement 1 to 4 (but
things were not done in the same order). Data is stored into `dataset` variable.

We then create the independent `tidyset` that holds the mean per
subject and activity.

Finally columns names are changed a little bit in order to have a more
consistent namins scheme. We replace `mean` and `std` by their
capitalized version and remove parenthesis in column names.

Both data sets are save to a file: `dataset.txt` and `tidyset.txt`
(this is the one that answers requirement 5).



