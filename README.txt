FILE DETAILS 
=============
The github repository contains the follwing files - 

1)run_analysis.R - RScript  that merges the training and test datasets  and then creates a independent tidy dataset with the average of 
each variable for each activity and each subject.
2) Codebook - indicate all the variables and summaries calculated
3) README.txt - Details of the files, scripts and codebooks creatred for the Assignment.

Instructions to run the run_analysis.R Script
=============================================

1)Pre-requisites - Both dplyr and tidyr package must be installed.
 				
2) Copy the below Project datasets to your work directory - 
features.txt
activity_labels.txt
X_train.txt
x_test.txt
X_test.txt
y_test.txt
subject_train
subject_test

3) Copy the script run_analysis.R to work directory.
4) Run below commands - 
i)source("run_analysis.R")
ii)final_ds <- create_dataset()

4) The final tidy summarized dataset will be present in final_ds





