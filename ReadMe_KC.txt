The following list consists of my interpretation and assumptions:

1.Step 2 from the assignment asks, “Extracts only the measurements on the mean and standard deviation for each 
measurement.”  Only measurements with BOTH mean and standard deviations are included in the assignments, and the 
following variables are not included although the labels contain the word “means”:

VARIABLE EXCLUDED
fBodyAcc-meanFreq()-X/Y/Z
angle(tBodyAccJerkMean),gravityMean)
angle(tBodyGroMean,gravityMean)
angle(tBodyGyroJerkMean,gravityMean)
angle(X/Y/Z,gravityMean)

VARIABLE INCLUDED
tBodyAcc-mean/std-X/Y/Z
tGravityAcc-mean/std –X/Y/Z
tBodyAccJerk-mean/std -X/Y/Z
tBodyGyro-mean/std -X/Y/Z
tBodyGyroJerk-mean/std -X/Y/Z
fBodyAcc-mean/std -X/Y/Z
fBodyAccJerk-mean/std -X/Y/Z
fBodyGyro-mean/std -X/Y/Z
tBodyAccMag-mean/std
tGravityAccMag-mean/std
tBodyAccJerkMag-mean/std
tBodyGyroMag-mean/std
tBodyGyroJerkMag-mean/std
fBodyAccMag-mean/std
fBodyBodyAccJerkMag-mean/std
fBodyBodyGyroMag-mean/std
fBodyBodyGyroJerkMag-mean/std

2.The strategy is to put axial-specific variables in their own groups.  So datX consists of all X-axial means 
and standard deviations, whereas datY consists of all Y-axial means and standard deviations.  The same applies 
to Z.  The variables that are non-axial specific are grouped in datN.

3.Variable names in datX, and datY, and datZ are changed by deleting X/Y/Z, so the name no longer indicates the 
axial.  But a new variable called axial is created in each dataset (1=X, 2=Y, 3=Z, and 0=non-axial specific).  
4.Then the 3 datasets (datX, datY, datZ) are merged to create tempD.

5.The instruction clearly states that averages should be calculated by activity.  But there is no detail if the 
averages should also be done by subject and axial (or the lack of).  From the features_info document where it
explains the variables that have no X, Y, or Z, "Additional vectors obtained by averaging the signals in a signal
window sample..." It seems to be implying that those means (i.e., gravityMean, tbodyAccMean, tBodyAccJerkMean,...,etc.)
were alreday averages across different vectors (axials), so it doesn't seem to be required to average by axial athough 
the variable called axial is created, the interpretation is then to calculate the average by activity only.

6.Another ambiguity is whether to treat melt means and standard deviations or keep them as independent variables.  
On page 11 of Hadley Wickham’s paper entitled “Tidy Data”, an example displays  (i.e. Table 11b on the lower right 
hand corner) tmax and tmin as 2 different variables in 2 separate columns.  To think about it some more, mean and 
standard deviation measure different things: means measure central tendency and standard deviations measure dispersion.  
So the decision is to treat the means and standard deviations in separate columns as independent variables.
