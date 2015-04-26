## Collect all the data test/train in one folder. Also, keep the features.txt in this folder, this is to get the column names
## To get the column headers added to the X data set. 
read_head <- read.table("features.txt") 
r <- read_head$V2 ## column names stored in the variable r 

## Step1 - Create the merged data
x_test <- read.table("X_test.txt", header=FALSE)
names(x_test) <-  r ## Add the feature names to each of the column from the vector r above. Useful for Step4 below

y_test <- read.table("Y_test.txt")
names(y_test) <- c("activity")

subject_test <- read.table("subject_test.txt")
names(subject_test) <-  c("subject")

subject_test_y <- cbind(subject_test,y_test)

subject_test_x_y <- cbind(subject_test_y,x_test)


## Create a dataset for train similar to test
subject_train <- read.table("subject_train.txt")
names(subject_train) <- c("subject")

x_train <- read.table("X_train.txt")
names(x_train) <- r


y_train <- read.table("Y_train.txt")
names(y_train) <- c("activity")

subject_train_y <- cbind(subject_train,y_train)

subject_train_x_y <- cbind(subject_train_y,x_train)

## finally end of Step1 mergedData
mergedData <- rbind(subject_test_x_y, subject_train_x_y)

## get the mean and std deviation columns

mergeDataMean <- mergedData[,grepl("mean\\(\\)", names(mergedData))]
mergeDataStd <- mergedData[,grepl("std\\(\\)", names(mergedData))]

mergeDataMeanStd <- cbind(mergeDataMean,mergeDataStd)

subSubjectActivity <- subset(mergedData, select = c(subject,activity))

## subsetWithMeanStd is now complete with the subset of the Mean/Std. deviation and activity and subject columns selected.
subsetWithMeanStd <- cbind(subSubjectActivity,mergeDataMeanStd)

## Step 3 - Replace the activity labels
subsetWithMeanStd[subsetWithMeanStd$activity == 1,]$activity = "WALKING"
subsetWithMeanStd[subsetWithMeanStd$activity == 2,]$activity = "WALKING_UPSTAIRS"
subsetWithMeanStd[subsetWithMeanStd$activity == 3,]$activity = "WALKING_DOWNSTAIRS"
subsetWithMeanStd[subsetWithMeanStd$activity == 4,]$activity = "SITTING"
subsetWithMeanStd[subsetWithMeanStd$activity == 5,]$activity = "STANDING"
subsetWithMeanStd[subsetWithMeanStd$activity == 6,]$activity = "LAYING"


## Step4 - 
## Give desciptive name to all the columns. Taken care of in Step 1 above

## Step 5
##
stdMeanMelt <- melt(step2,id=c("subject","activity"), measure.vars=c("tBodyAcc-mean()-X" ,  "tBodyAcc-mean()-Y" ,  "tBodyAcc-mean()-Z" , "tGravityAcc-mean()-X"  , "tGravityAcc-mean()-Y" ,  "tGravityAcc-mean()-Z" ,   "tBodyAccJerk-mean()-X" ,  "tBodyAccJerk-mean()-Y"  ,  "tBodyAccJerk-mean()-Z"  ,  "tBodyGyro-mean()-X" ,  "tBodyGyro-mean()-Y"   ,   "tBodyGyro-mean()-Z"  ,  "tBodyGyroJerk-mean()-X"   ,  "tBodyGyroJerk-mean()-Y"  ,  "tBodyGyroJerk-mean()-Z" ,  "tBodyAccMag-mean()"  ,  "tGravityAccMag-mean()"  ,  "tBodyAccJerkMag-mean()" , "tBodyGyroMag-mean()"  ,   "tBodyGyroJerkMag-mean()" ,  "fBodyAcc-mean()-X"  ,  "fBodyAcc-mean()-Y"  ,  "fBodyAcc-mean()-Z" ,  "fBodyAccJerk-mean()-X"   ,    "fBodyAccJerk-mean()-Y"  ,  "fBodyAccJerk-mean()-Z"   ,    "fBodyGyro-mean()-X"  ,  "fBodyGyro-mean()-Y" ,  "fBodyGyro-mean()-Z" , "fBodyAccMag-mean()"  , "fBodyBodyAccJerkMag-mean()" , "fBodyBodyGyroMag-mean()"  ,  "fBodyBodyGyroJerkMag-mean()" ,"tBodyAcc-std()-X" ,   "tBodyAcc-std()-Y" ,  "tBodyAcc-std()-Z"  ,  "tGravityAcc-std()-X" ,  "tGravityAcc-std()-Y"  ,   "tGravityAcc-std()-Z"  ,       "tBodyAccJerk-std()-X" ,    "tBodyAccJerk-std()-Y"  ,      "tBodyAccJerk-std()-Z"  ,  "tBodyGyro-std()-X"  ,   "tBodyGyro-std()-Y" ,   "tBodyGyro-std()-Z"  ,    "tBodyGyroJerk-std()-X"  ,  "tBodyGyroJerk-std()-Y" ,   "tBodyGyroJerk-std()-Z"  ,   "tBodyAccMag-std()" ,          "tGravityAccMag-std()" ,  "tBodyAccJerkMag-std()"  ,     "tBodyGyroMag-std()"    ,      "tBodyGyroJerkMag-std()" ,     "fBodyAcc-std()-X"  ,          "fBodyAcc-std()-Y"   ,  "fBodyAcc-std()-Z"   ,   "fBodyAccJerk-std()-X"  ,  "fBodyAccJerk-std()-Y"  ,   "fBodyAccJerk-std()-Z"     ,   "fBodyGyro-std()-X" ,  "fBodyGyro-std()-Y"  ,     "fBodyGyro-std()-Z"   ,  "fBodyAccMag-std()" , "fBodyBodyAccJerkMag-std()" ,  "fBodyBodyGyroMag-std()"  , "fBodyBodyGyroJerkMag-std()"), variable.name = "MeanAndStdMeasurement")

## MeanAndStdMeasurement variable from the melt

finalTidyDataSet <- dcast(stdMeanMelt, subject + activity ~ MeanAndStdMeasurement, mean)



