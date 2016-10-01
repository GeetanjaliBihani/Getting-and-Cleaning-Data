library(tidyr)
#downloading zip file from URL
setwd("D:/COURSERA/Getting and cleaning files/week4")
if(!(file.exists("./tidyproject"))){dir.create("./tidyproject")}
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,destfile="./tidyproject/data.zip")

#Unzipping downloaded zip file
unzip("./tidyproject/data.zip",exdir=".")

#Loading test data into R
setwd("D:/COURSERA/Getting and cleaning files/week4/tidyproject/UCI HAR Dataset")
testx<-read.table("./test/X_test.txt")
testy<-read.table("./test/y_test.txt")
subject_test<-read.table("./test/subject_test.txt")

#Loading training data into R
trainx<-read.table("./train/X_train.txt")
trainy<-read.table("./train/y_train.txt")
subject_train<-read.table("./train/subject_train.txt")

#Reading activity data
activityl<-read.table("./activity_labels.txt")

#Reading feature data
features<-read.table("./features.txt")

#Assigning column names to test and train datasets
colnames(testx)<-features[,2]
colnames(trainx)<-features[,2]
colnames(testy)<-"ActivityID"
colnames(trainy)<-"ActivityID"
colnames(subject_train)<-"SubjectID"
colnames(subject_test)<-"SubjectID"
colnames(activityl)<-c("ActivityID", "ActivityType")

#1.Merging test data
test_m<-cbind(testy,subject_test,testx)
train_m<-cbind(trainy,subject_train,trainx)
total_m<-rbind(train_m,test_m)

#2.extracting only the measurements on the mean and standard deviation for each measurement.
mean_std<-(grepl("ActivityID",colnames(total_m))|grepl("SubjectID",colnames(total_m))|grepl("mean..",colnames(total_m))|grepl("std..",colnames(total_m)))
new_data<-total_m[,mean_std]

#3.use descriptive activity names to name the activity in the data set
new_data<-merge(new_data,activityl, by ="ActivityID")
new_data<-new_data[,c(1,82,2:81)]

#4.Appropriately label the data set with descriptive variable names.

#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
aggregated_data<-aggregate(. ~new_data$ActivityType+new_data$SubjectID,new_data[,4:81],mean)
head(n)

#Writing the file
write.table(aggregated_data,"aggregated_data.txt",row.names = F)
