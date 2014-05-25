Coursera (Data Science, Class 3)
## Get and clean data - Course Project

###Installation and Run

* Please clone this repository to your prefered directory in your machine
* Open RStudio, set working directory to the directory from the above step (in RStudio, go to Session -> Set Working Directory )
* Now you should see the file run_analysis.R. Run all the codes
* If you have not installed package "data.table", please uncomment the code at line number 8
* It will around 2-3 minutes to download the dataset and run the codes. It is not required, but recommended that you have a cup of coffee while waiting
* Run the code
* If succesfully completed, you should see a new file named tidy_data.txt

###Coding convention:

Prefix of each variable is the abbreviation of its data type. For example, the df_ in df_features tell you that the variable is a data frame

###Main Step

####Step 1: Download and unzip the files

* Download the file using download.file(...)
* Unzip the file using unzip(...)
* Note: since the file is quite big, if you already downloaded it and unzip it upfront, please put the folder "UCI HAR Dataset" into the working directory so that you can skip this time-consuming step

####Step 2: Create tables from .txt files

* Using read.table(...), I create several data.frame variables from given downloaded text files

### STEP 3: Combine several tables 

* Create table of all subjects (df_subject)  by combining subject train and subject test tables (10299 obs of 1 variable)
* Create table of all data set (df_x) by combing train set (from X_train.txt) and test set (X_Test.txt) (10299 obs of 66 variables)
* Create table of all data labels (df_y) by combing train labels (from y_train.txt) and test labels (y_test.txt) (10299 obs of 1 variables)
* in df_y, convert numeric value to activity name using activity_labels.txt



