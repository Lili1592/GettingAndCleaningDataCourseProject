library(tidyverse)

# Reading the datasets :

Features = read.table("features.txt", h = F)
Features
dim(Features)

ActivityLabels = read.table("activity_labels.txt", h = F)
ActivityLabels

DataTestSubject = read.table(file = "test/subject_test.txt", col.names = "Subject")
head(DataTestSubject)
dim(DataTestSubject)

DataTestX = read.table(file = "test/X_test.txt")
head(DataTestX, n=1)
dim(DataTestX)

DataTestActivity = read.table(file = "test/y_test.txt", col.names = "Activity")
head(DataTestActivity, n=1)
dim(DataTestActivity)

DataTrainSubject = read.table(file = "train/subject_train.txt", col.names = "Subject")
head(DataTrainSubject)
dim(DataTrainSubject)

DataTrainX = read.table(file = "train/X_train.txt")
head(DataTrainX, n=1)
dim(DataTrainX)
names(DataTrainX)

DataTrainActivity = read.table(file = "train/y_train.txt", col.names = "Activity")
head(DataTrainActivity, n=1)
dim(DataTrainActivity)


# 1. Merging the datasets togather to create one single dataset :

DataSubjectTotal = rbind(DataTrainSubject, DataTestSubject)
dim(DataSubjectTotal)

DataXTotal = rbind(DataTrainX, DataTestX)
dim(DataXTotal)
names(DataXTotal) = Features[ ,2]
head(DataXTotal)

DataYTotal = rbind(DataTrainActivity, DataTestActivity)
dim(DataYTotal)

DataTotal = cbind(DataSubjectTotal, DataYTotal, DataXTotal)
dim(DataTotal)
names(DataTotal)
ViewData = DataTotal[c(1:10),c(1:10)]
ViewData


# 2. Extracting the measurements on the mean and standard deviation for each measurement :

Extraction = grep("-mean\\(\\)|-std\\(\\)", Features[, 2])
ExtractedData = DataTotal[,Extraction]
dim(ExtractedData)
ExtractedData[c(1:10), c(1:10)]


# 3. Using descriptive activity names to name the activities :

ExtractedData[,2] = ActivityLabels[ExtractedData[,2], 2]
names(ExtractedData[,2]) = "activity"
head(ExtractedData)


# 4. Appropriately labelling the data set with descriptive variable names :

names(ExtractedData)
# Already done.


# 5. Creating a second tidy data set with the average of each variable for each activity and each subject :

SecondDataSet = aggregate(. ~ Subject + Activity, data = ExtractedData, mean)
SecondDataSet[,c(1,2,3)]
dim(SecondDataSet)

write.table(SecondDataSet, "SecondDataSet")
  
