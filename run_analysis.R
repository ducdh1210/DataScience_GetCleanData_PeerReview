##############################################################
# NAME: Duc Do                                               #
# CLASS: Coursera, Data Science: Getting and Cleaning Data   #
# Course Project (Peer Review)                               #                                
# May 24, 2014                                               #
##############################################################

#install.packages("data.table")

##############################################################
# STEP 1: Download and unzip files

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,destfile="dataset.zip",method="curl")
unzip(zipfile="dataset.zip")

##############################################################
# STEP 2: Read tables (df_ refers to dataframe)

# read activity labels
df_activity <- read.table(file="./UCI HAR Dataset/activity_labels.txt")

# read the features (measurement names)
df_features <- read.table(file="./UCI HAR Dataset/features.txt")

# read the subject data (indicating participant)
df_subj_train <- read.table(file="./UCI HAR Dataset/train/subject_train.txt")
df_subj_test <- read.table(file="./UCI HAR Dataset/test/subject_test.txt")

# read the observation data (values for row)
df_x_train <- read.table(file="./UCI HAR Dataset/train/X_train.txt")
df_x_test <- read.table(file="./UCI HAR Dataset/test/X_test.txt")

# read the label data (activity labels for column names)
df_y_train <- read.table(file="./UCI HAR Dataset/train/y_train.txt")
df_y_test <- read.table(file="./UCI HAR Dataset/test/y_test.txt")

##############################################################
# STEP 3: row binding (subject train, subjest test), (X_train, X_test), (Y_Train, Y_Test)

df_subj = rbind(df_subj_train, df_subj_test)
df_x = rbind(df_x_train, df_x_test)
df_y = rbind(df_y_train, df_y_test)

# in df_y, convert numeric value to activity name
df_y$V1 <- factor(df_y$V1, df_activity[,1], df_activity[,2])

##############################################################
# STEP 4: from feature table, get and clean feature labels relating to mean and std

# get a factor, which is the second column of df_features
ft_feature <- df_features[,2];
# create a vector whose each element is the index of the row referring to a mean measure
vt_mean <- grep("-mean()", fixed=TRUE, ft_feature)  
# create a vector whose each element is the index of the row referring to a mean measure
vt_std <-  grep("-std()", fixed=TRUE, ft_feature)  
# combining those two above vectors and sort the indexes
vt_col <- c(vt_mean,vt_std)
vt_col <- sort(vt_col) 
# keep only labels which contains "mean" and "std" in its name 
ft_feature <- ft_feature[vt_col];

##############################################################
# STEP 5: Refine dataset df_x and add subject and activity columns to it

# refine df_x so that it only contains columns refering measures of mean or std
df_x <- df_x[,vt_col]

# add subject and activity columns to df_x
df_General <- cbind(df_subj, df_y, df_x)

##############################################################
# STEP 6: Add header to the dataset

# header of the first two columns are Subject and Activity
colnames(df_General)[1:2]<-c('Subject', 'Activity')

# from 3rd column to the last column, the headers are obtained from ft_feature
colnames(df_General)[3:length(df_General)] <- as.character(ft_feature)

##############################################################
# *STEP 7: Data Analysis --> find mean based on subject and activity

# load data table package
library(data.table)

# create data table variabel from df_General
dt_General <- data.table(df_General)

# take all columns except first two, split them by the couple (Subject - Activity), and find mean to each splitted group
# credit to: http://lamages.blogspot.com/2012/01/say-it-in-r-with-by-apply-and-friends.html
dt_Refined_General <- dt_General[,lapply(.SD,mean),by="Subject,Activity",.SDcols=3:length(dt_General)]

# reorder the rows based on Subject - Activity
dt_Refined_General <- dt_Refined_General[order(dt_Refined_General$Subject,dt_Refined_General$Activity),]

##############################################################
# STEP 8: Write to .txt file
write.table(dt_Refined_General, "tidy_data.txt", sep="\t", row.names = F, col.names = T)






