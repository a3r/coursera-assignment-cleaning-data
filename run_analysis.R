library(dplyr)
library(reshape2)

if (!file.exists("./CleaningDataProgAss")) {dir.create("./CleaningDataProgAss")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./CleaningDataProgAss/raw.zip", method = "curl")
unzip("./CleaningDataProgAss//raw.zip", exdir = "./CleaningDataProgAss/")

activityLabels <- read.table("./CleaningDataProgAss//UCI HAR Dataset/activity_labels.txt")
features <- read.table("./CleaningDataProgAss//UCI HAR Dataset/features.txt")
xTest <- read.table("./CleaningDataProgAss//UCI HAR Dataset/test/X_test.txt")
yTest <- read.table("./CleaningDataProgAss//UCI HAR Dataset/test/y_test.txt")
subjectTest <- read.table("./CleaningDataProgAss//UCI HAR Dataset/test/subject_test.txt")

testBodyAccX <- read.table("./CleaningDataProgAss//UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt")
testBodyAccY <- read.table("./CleaningDataProgAss//UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt")
testBodyAccZ <- read.table("./CleaningDataProgAss//UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt")
testBodyGyroX <- read.table("./CleaningDataProgAss//UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt")
testBodyGyroY <- read.table("./CleaningDataProgAss//UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt")
testBodyGyroZ <- read.table("./CleaningDataProgAss//UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt")
testTotalAccX <- read.table("./CleaningDataProgAss//UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt")
testTotalAccY <- read.table("./CleaningDataProgAss//UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt")
testTotalAccZ <- read.table("./CleaningDataProgAss//UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt")

xTrain <- read.table("./CleaningDataProgAss//UCI HAR Dataset/train/X_train.txt")
yTrain <- read.table("./CleaningDataProgAss//UCI HAR Dataset/train/y_train.txt")
subjectTrain <- read.table("./CleaningDataProgAss//UCI HAR Dataset/train/subject_train.txt")

trainBodyAccX <- read.table("./CleaningDataProgAss//UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt")
trainBodyAccY <- read.table("./CleaningDataProgAss//UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt")
trainBodyAccZ <- read.table("./CleaningDataProgAss//UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt")
trainBodyGyroX <- read.table("./CleaningDataProgAss//UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt")
trainBodyGyroY <- read.table("./CleaningDataProgAss//UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt")
trainBodyGyroZ <- read.table("./CleaningDataProgAss//UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt")
trainTotalAccX <- read.table("./CleaningDataProgAss//UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt")
trainTotalAccY <- read.table("./CleaningDataProgAss//UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt")
trainTotalAccZ <- read.table("./CleaningDataProgAss//UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt")

# Merging all subjects to 1 table; sort=FALSE means that subjectTest goes first, 
# followed by subjectTrain
subjects <- merge(subjectTest, subjectTrain, all=TRUE, sort=FALSE)
subjects <- rename(subjects, subjectID=V1)
activityType <- rbind(yTest, yTrain)
activityType <- rename(activityType, activityCode=V1)
activityLabels <- rename(activityLabels, activity_name=V2)
activityByName <- merge(activityType, activityLabels, by.x="activityCode", by.y="V1", sort=FALSE)
subjectsActivities <- cbind(subjects, activityByName) 

bodyAccX <- merge(testBodyAccX, trainBodyAccX, all=TRUE)
colnames(bodyAccX) <- c(1:128)
colnames(bodyAccX) <- paste("body_acc_x", colnames(bodyAccX), sep="_")

bodyAccY <- merge(testBodyAccY, trainBodyAccY, all=TRUE)
colnames(bodyAccY) <- c(1:128)
colnames(bodyAccY) <- paste("body_acc_y", colnames(bodyAccY), sep="_")

bodyAccZ <- merge(testBodyAccZ, trainBodyAccZ, all=TRUE)
colnames(bodyAccZ) <- c(1:128)
colnames(bodyAccZ) <- paste("body_acc_z", colnames(bodyAccZ), sep="_")

bodyGyroX <- merge(testBodyGyroX, trainBodyGyroX, all=TRUE)
colnames(bodyGyroX) <- c(1:128)
colnames(bodyGyroX) <- paste("body_gyro_x", colnames(bodyGyroX), sep="_")

bodyGyroY <- merge(testBodyGyroY, trainBodyGyroY, all=TRUE)
colnames(bodyGyroY) <- c(1:128)
colnames(bodyGyroY) <- paste("body_gyro_y", colnames(bodyGyroY), sep="_")

bodyGyroZ <- merge(testBodyGyroZ, trainBodyGyroZ, all=TRUE)
colnames(bodyGyroZ) <- c(1:128)
colnames(bodyGyroZ) <- paste("body_gyro_z", colnames(bodyGyroZ), sep="_")

totalAccX <- merge(testTotalAccX, trainTotalAccX, all=TRUE)
colnames(totalAccX) <- c(1:128)
colnames(totalAccX) <- paste("total_acc_x", colnames(totalAccX), sep="_")

totalAccY <- merge(testTotalAccY, trainTotalAccY, all=TRUE)
colnames(totalAccY) <- c(1:128)
colnames(totalAccY) <- paste("total_acc_y", colnames(totalAccY), sep="_")

totalAccZ <- merge(testTotalAccZ, trainTotalAccZ, all=TRUE)
colnames(totalAccZ) <- c(1:128)
colnames(totalAccZ) <- paste("total_acc_z", colnames(totalAccZ), sep="_")

measurements <- cbind(bodyAccX, bodyAccY, bodyAccZ, bodyGyroX, bodyGyroY, bodyGyroZ, totalAccX, totalAccY, totalAccZ)

featureNames <- as.character(features$V2)
allFeatures <- merge(xTest, xTrain, all=TRUE, sort=FALSE)
colnames(allFeatures) <- featureNames

# Rename up to standards
validColumnNames <- make.names(names=names(allFeatures), unique=TRUE, allow_ = TRUE)
names(allFeatures) <- validColumnNames
finalTable <- cbind(subjectsActivities, measurements, allFeatures)

# Choosing only the columns that are of interest
tableOfMeanAndStd <- select(finalTable, subjectID:activity_name, contains("ean"), contains("std"))

meltedFeatures <- melt(tableOfMeanAndStd, id=c("subjectID", "activity_name"), measure.vars=c(4:89))
featureByID <- group_by(meltedFeatures, subjectID, activity_name, variable)
result <- arrange(summarize(featureByID, mean(value)), subjectID)

write.table(result, "./CleaningDataProgAss/AverageMeasurements.txt", row.name=FALSE)