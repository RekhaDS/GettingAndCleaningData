# GettingAndCleaningData
The Getting and Cleaning Data Repository to store the project files
This repository contains the project assignment for the Getting and Cleaning data course. 

The repository contains this Readme.md along with the run_analysis.R and the Code book files. 

The code book contains the description for the variables used for measurement. 
The run_analysis.R file is a R script that uses the data downloaded from the following location
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The assignment is asking for the following -

To create an R script called run_analysis.R that does the following. 
Step 1) Merges the training and the test sets to create one data set.
Step 2) Extracts only the measurements on the mean and standard deviation for each measurement. 
Step 3) Uses descriptive activity names to name the activities in the data set
Step 4)Appropriately labels the data set with descriptive variable names. 
Step 5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


run_analysis.R file :- 
--------------------
The  run_analysis.R file is split in to 5 sections as project requirement. 
The goal is to convert the given raw data in to a tidy data format. 
Each of the lines in the R file can be run independently to reach the final tidy data set.

PREREQUISITE FOR EXECUTING THE RUN_ANALYSIS.R FILE :- 
Download the file. ( file Dataset.zip)
Extract it and copy all the test and train data in to one folder. 
In the same folder copy the run_analysis.R file. 
Also, make sure that the actiivty_labels.txt file and features.txt file are in the same folder as well. Ths features.txt file is referenced to get the names of the columns.

High level description of R script:-
Get the train and test text files, read them in to R, use cbind to merge the individual files in train set (x_test,y_test and subject_test) and do the same merge with cbind for the test sets. And then use rbind to merge the two data sets - train and test.

After the merge, create a subset of the columns from 561 columns, get down to 66 to include only the mean and std. deviation columns. Replace the activity numbers with their respective descriptions as per activity_labels.txt.
Finally use met and dcast from the package reshape2 to get to the final tidy data set.

Detailed description for run_analysis.R code - (please look at the run_analysis.R file to understand the variables used and referenced here. )
 
Step1  :-
a) read_head is the file that reads the feature.txt file to capture the column names and store in a variable r.
b) Read/Load the text x_test.txt/y_test.txt/subject_test.txt files respectively to x_test/y_test, subject_test variables.
c) First step, column bind the sub_ject_test and y_test variables to create a intermediate column including the subject and the y_test columsn
d) Next, column bind to add the x_test file that contains the various measurements for the subjects to the resulting column bind data set from c) above.
e) Read/Load the x_train.txt/y_train.txt and subject_train.txt files as well.  and store it in x_train/y_train/subject_train
f) Perfom the same steps c and d on this new data set for training. The final data set containing all three training data is called subject_train_x_y and subject_test_x_y
g) To now finally get the mergeddata, use the function rbind to merge the two data sets created in step d and step f above. Which means
merge using rbind subject_test_x_y, subject_train_x_y and store in merged_data.

This ends Step1, creating a mergedData set for both train and test. 

Now, to move on to step2 :-
Grep for the mean and store in mergeDataMean and grep for std. deviation from the mergedData and store in mergeDataStd.
Next, cbind the two data sets to create a data set that contains both the mean and std. deviation measurements. 
This data set is then merged with the activity and subject data using cbind. The final set createdhere is the subsetWithMeanStd. 

This gives us Step2 result. Ie. get the mean/std. deviation measurement columns from the Step1 data set. 

For Step3, we simpy make sure that based on the Activity_labels.txt file the activity that is measured as a number contains the descptive name
like so:-
1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING

This gives us Step3. 

Step4 uses the package reshape2. Make sure that you install reshape2 and load it before using the melt/dcast function for getting the final tidy data.
Melt, melts the data in to a tall narrow data set that contains the id = subject and activity and is measured along the 66 mean/std. deviation columns
that we subset in Step2. The ariable is called MeanAndStdMeasurement in the melt function. 

dcast then created a final tidy data set that is done across the two id variables activity and subject with respect to the measurement, 
MeanAndStdMeasurement. 

This completes Step5. 
