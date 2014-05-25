Coursera (Data Science, Class 3)
## Get and clean data - Course Project

###Install and Run

* Please clone this repository to your prefered directory in your machine
* Open RStudio, set working directory to the directory from the above step (in RStudio, go to Session -> Set Working Directory )
* Now you should see the file run_analysis.R
* If you have not installed package "data.table", please uncomment the code at line number 8
* Run all the codes
* It will around 2-3 minutes to download the dataset and run the codes. It is not required, but recommended that you have a cup of coffee while waiting

* If succesfully completed, you should see a new file named tidy_data.txt

###Coding convention

Prefix of each variable is the abbreviation of its data type. For example, the df_ in df_features tell you that the variable is a data frame

###Main Steps and Explaination

####STEP 1: Download and unzip the files
* Download the file using download.file(...)
* Unzip the file using unzip(...)
* Note: since the file is quite big, if you already downloaded it and unzip it upfront, please put the folder "UCI HAR Dataset" into the working directory so that you can skip this time-consuming step

####STEP 2: Create tables from .txt files
* Using read.table(...), I create several data.frame variables from given downloaded text files

####STEP 3: Combine several tables 
* Create table of all subjects (df_subject)  by combining subject train and subject test tables (10299 obs of 1 variable)
* Create table of all data set (df_x) by combing train set (from X_train.txt) and test set (X_Test.txt) (10299 obs of 66 variables)
* Create table of all data labels (df_y) by combing train labels (from y_train.txt) and test labels (y_test.txt) (10299 obs of 1 variables)
* in df_y, convert numeric value to activity name using activity_labels.txt

####STEP 4: from feature table, get and clean feature labels relating to mean and std
Note: At step 2, I created df_feature table from features.txt. Now, I want to keep the indexes of row whose value is the word "mean" and "std"" in it
* Obtain df_feature[,2], which is a factor. Call it ft_feature
* Using regular expression, create a vector whose each element is the index of the row referring to a mean measurement label
* Using regular expression, create a vector whose each element is the index of the row referring to a std measurement label
* Create a vector by combining two above vectors, then sort the new vector. Call it vt_col
* Using vt_col to update ft_feature so that it only contains row relevant to mean and std measurement label

####STEP 5: Refine dataset df_x and add subject and activity columns to it
* Using vt_col to update df_x so that it only contains columns refering measures of mean or std
* Create a new dataframe by binding df_subj (subject dataframe) and df_y (activity dataframe) to df_x. Call it df_General

####STEP 6: Add header to the dataset
* Use "Subject" and "Activity" as headers of first 2 columns in df_General
* Use df_feature to assign headers to remaining columns of df_General

####STEP 7: Find mean based on subject and activity
* Load data table package
* Create data table dt_General from df_General
* Take all columns except first two, split them by the couple (Subject - Activity), and find mean to each splitted group: dt_Refined_General <- dt_General[,lapply(.SD,mean),by="Subject,Activity",.SDcols=3:length(dt_General)]
* Reorder the rows based on Subject - Activity

####STEP 8: Write to .txt file
* Make a new .txt file from dt_Refined_General table. Call it tidy_data.txt


