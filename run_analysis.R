
setwd("C:/Documents/DataScience/3. Data Cleaning/Assignments/Assignment1/UCI HAR Dataset/data")

##########################################################
#TEST FILE
##########################################################

#reading in test (space delimited file)

 test<-read.table("X_test.txt", sep="")
 head(test)
 str(test)
 summary(test)

#reading in features.txt to get names for the 561 variables

 tempN<-read.csv("features.txt", sep="",header=FALSE)
 str(tempN)
 head(tempN)
 tail(tempN)

#changing the names to a vector 

 labels<-as.character(tempN[,2])
 
#naming variables in x_test using names from features.txt

 names(test)<-labels
 str(test)

#reading in subject_test (ids)

 idTest<-read.csv("subject_test.csv",sep=",",header=FALSE)
 head(idTest)

#renaming var but need to load the data.table package
#first in order to do that

 library(data.table,lib.loc="c:/R/RPackages/")
 setnames(idTest,old=c("V1"), new=c("id"))
 head(idTest)
	
#reading in y_test (activities var)
 
 actvTest<-read.csv("y_test.csv",sep=",",header=FALSE)
 head(actvTest)
 str(actvTest)
 table(actvTest)

#renaming var here to indicate activities
 
 setnames(actvTest,old=c("V1"),new=c("actv"))
 head(actvTest)

#merging all 3 datasets

 masterTest<-cbind(idTest,actvTest,test)
 str(masterTest)
 tail(masterTest)


#checking to see if masterTest has the right number
#of rows and columns: 2947 rows and 563 cols

 dim(idTest)
 dim(actvTest)
 dim(test)
 dim(masterTest)

##########################################################
#TRAIN FILE
##########################################################

#reading in training (space delimited file)
 train<-read.table("X_train.txt", sep="")
 head(train)
 str(train)
 summary(train)

#naming variables in x_train using names in features.txt

 names(train)<-labels
 head(train)
 str(train)

#reading in subject_train (ids)

 idTrain<-read.csv("subject_train.csv",sep=",",header=FALSE)
 head(idTrain)
 table(idTrain)
 str(idTrain)

#renaming var but need to load the data.table package
#first in order to do that

 setnames(idTrain,old=c("V1"), new=c("id"))
 head(idTrain)
	
#reading in y_train (activities var)
 
 actvTrain<-read.csv("y_train.csv",sep=",",header=FALSE)
 head(actvTrain)
 str(actvTrain)
 table(actvTrain)

#renaming var here to indicate activities
 
 setnames(actvTrain,old=c("V1"),new=c("actv"))
 head(actvTrain)

#merging all 3 datasets

 masterTrain<-cbind(idTrain,actvTrain,train)
 str(masterTrain)
 tail(masterTrain)

#Checking the dimensions fo masterTrain, which should be
#7532 rows and 563 columns

dim(idTrain)
dim(actvTrain)
dim(train)
dim(masterTrain)

#merging the train and test data

 master<-rbind(masterTest, masterTrain)
 head(master)

#checking the dimensions of master, which should be
#10299 rows and 563 cols

 dim(masterTest)
 dim(masterTrain)
 dim(master)

#creating an unique row of index numbers for merging later
#not sure if it'll be needed down tht road but creating one 
#just in case

 master$uid<-seq(1,10299,length.out=10299)


#recoding activities in the activity variable using descriptive names

  master$activity[master$actv==1]<-"walk"
  master$activity[master$actv==2]<-"walkUpstairs"
  master$activity[master$actv==3]<-"walkDownstairs"
  master$activity[master$actv==4]<-"sit"
  master$activity[master$actv==5]<-"stand"
  master$activity[master$actv==6]<-"lay"

  table(master$actv)
  table(master$activity)

#creating 4 small datasets to keep the axials vars separately
#while the means/stds that have no axial stay on its own
 
 varsX<-c("id", "uid", "activity", 
	"tBodyAcc-mean()-X", "tBodyAcc-std()-X",
	"tGravityAcc-mean()-X", "tGravityAcc-std()-X",
	"tBodyAccJerk-mean()-X", "tBodyAccJerk-std()-X",
	"tBodyGyro-mean()-X", "tBodyGyro-std()-X",
	"tBodyGyroJerk-mean()-X", "tBodyGyroJerk-std()-X",
	"fBodyAcc-mean()-X", "fBodyAcc-std()-X",
	"fBodyAccJerk-mean()-X", "fBodyAccJerk-std()-X",	
	"fBodyGyro-mean()-X", "fBodyGyro-std()-X")
 datX<-master[varsX]
 
 varsY<-c("id", "uid", "activity", 
	"tBodyAcc-mean()-Y", "tBodyAcc-std()-Y",
	"tGravityAcc-mean()-Y", "tGravityAcc-std()-Y",
	"tBodyAccJerk-mean()-Y", "tBodyAccJerk-std()-Y",
	"tBodyGyro-mean()-Y", "tBodyGyro-std()-Y",
	"tBodyGyroJerk-mean()-Y", "tBodyGyroJerk-std()-Y",
	"fBodyAcc-mean()-Y", "fBodyAcc-std()-Y",
	"fBodyAccJerk-mean()-Y", "fBodyAccJerk-std()-Y",	
	"fBodyGyro-mean()-Y", "fBodyGyro-std()-Y")
 datY<-master[varsY]

 varsZ<-c("id", "uid", "activity", 
	"tBodyAcc-mean()-Z", "tBodyAcc-std()-Z",
	"tGravityAcc-mean()-Z", "tGravityAcc-std()-Z",
	"tBodyAccJerk-mean()-Z", "tBodyAccJerk-std()-Z",
	"tBodyGyro-mean()-Z", "tBodyGyro-std()-Z",
	"tBodyGyroJerk-mean()-Z", "tBodyGyroJerk-std()-Z",
	"fBodyAcc-mean()-Z", "fBodyAcc-std()-Z",
	"fBodyAccJerk-mean()-Z", "fBodyAccJerk-std()-Z",	
	"fBodyGyro-mean()-Z", "fBodyGyro-std()-Z")
 datZ<-master[varsZ]


 varsN<-c("id", "uid", "activity",
  "tBodyAccMag-mean()", "tBodyAccMag-std()",
  "tGravityAccMag-mean()", "tGravityAccMag-std()",
  "tBodyAccJerkMag-mean()", "tBodyAccJerkMag-std()",
  "tBodyGyroMag-mean()", "tBodyGyroMag-std()",
  "tBodyGyroJerkMag-mean()", "tBodyGyroJerkMag-std()",
  "fBodyAccMag-mean()", "fBodyAccMag-std()",
  "fBodyBodyAccJerkMag-mean()", "fBodyBodyAccJerkMag-std()",
  "fBodyBodyGyroMag-mean()", "fBodyBodyGyroMag-std()",
  "fBodyBodyGyroJerkMag-mean()", "fBodyBodyGyroJerkMag-std()")
 datN<-master[varsN]


#renaming all the vars in the datasets that contain 
#info on the 3 axials with the same set of names
#for stacking later

 datX<-rename(datX,c(oldname="newname"))
 names(datX)<-c("id", "uid", "activity", 
	"tBodyAccMean", "tBodyAccStd",
	"tGravityAccMean", "tGravityAccStd",
	"tBodyAccJerkMean", "tBodyAccJerkStd",
	"tBodyGyroMean", "tBodyGyroStd",
	"tBodyGyroJerkMean", "tBodyGyroJerkStd",
	"fBodyAccMean", "fBodyAccStd",
	"fBodyAccJerkMean", "fBodyAccJerkStd",	
	"fBodyGyroMean", "fBodyGyroStd")

 datY<-rename(datY,c(oldname="newname"))
 names(datY)<-c("id", "uid", "activity", 
	"tBodyAccMean", "tBodyAccStd",
	"tGravityAccMean", "tGravityAccStd",
	"tBodyAccJerkMean", "tBodyAccJerkStd",
	"tBodyGyroMean", "tBodyGyroStd",
	"tBodyGyroJerkMean", "tBodyGyroJerkStd",
	"fBodyAccMean", "fBodyAccStd",
	"fBodyAccJerkMean", "fBodyAccJerkStd",	
	"fBodyGyroMean", "fBodyGyroStd")

 datZ<-rename(datZ,c(oldname="newname"))
 names(datZ)<-c("id", "uid", "activity", 
	"tBodyAccMean", "tBodyAccStd",
	"tGravityAccMean", "tGravityAccStd",
	"tBodyAccJerkMean", "tBodyAccJerkStd",
	"tBodyGyroMean", "tBodyGyroStd",
	"tBodyGyroJerkMean", "tBodyGyroJerkStd",
	"fBodyAccMean", "fBodyAccStd",
	"fBodyAccJerkMean", "fBodyAccJerkStd",	
	"fBodyGyroMean", "fBodyGyroStd")


 datN<-rename(datN,c(oldname="newname"))
 names(datN)<-c("id", "uid", "activity", 
	"tBodyAccMagMean", "tBodyAccMagStd",
	"tGravityAccMagMean", "tGravityAccMagStd",
	"tBodyAccJerkMagMean", "tBodyAccJerkMagStd",
	"tBodyGyroMagMean", "tBodyGyroMagStd",
	"tBodyGyroJerkMagMean", "tBodyGyroJerkMagStd",
	"fBodyAccMagMean", "fBodyAccMagStd",
	"fBodyBodyAccJerkMagMean", "fBodyBodyAccJerkMagStd",	
	"fBodyBodyGyroMagMean", "fBodyBodyGyroMagStd",
	"fBodyBodyGyroJerkMagMean", "fBodyBodyGyroJerkMagStd")

#creating a variable to indicate the axial type in each dataset

  datX$axial=seq(1,1,length.out=10299)
  datY$axial=seq(2,2,length.out=10299)  
  datZ$axial=seq(3,3,length.out=10299)
  datN$axial=seq(0,0,length.out=10299)

#merging data on the 3 axials into 1 dataset
 
 tempD<-rbind(datX, datY, datZ)

 dim(datX)
 dim(datY)
 dim(datZ)
 dim(tempD)

#getting averages from tempD

	attach(tempD)
	avgAxials<-aggregate(tempD, by=list(tempD$activity),FUN=mean)
	detach(tempD)


#getting averages by activity from datN

  	attach(datN)
	avgNoaxial<-aggregate(datN, by=list(datN$activity),
			FUN=mean)
	avgNoaxial
	detach(datN)

#only keeping the avgs and activities

 dropA<-names(avgAxials) %in% c("id", "uid", "activity","axial")
 finalA<-avgAxials[!dropA]

 dropN<-names(avgNoaxial) %in% c("id", "uid", "activity","axial")
 finalN<-avgNoaxial[!dropN]

#renming Group.1 in both datasets

 names(finalA)[names(finalA)=="Group.1"]<-"activity"
 names(finalN)[names(finalN)=="Group.1"]<-"activity"
 names(finalA)
 names(finalN)

#merging the 2 datasets

tidy<-merge(x=finalA,y=finalN, by=("activity")
	,all.x=TRUE)
write.table(tidy,"tidy.txt",row.names=FALSE)
 
