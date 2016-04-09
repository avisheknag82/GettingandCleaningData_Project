##  Merges the training and the test sets to create one data set.
## 	Extracts only the measurements on the mean and standard deviation for each measurement.
##	Uses descriptive activity names to name the activities in the data set
##	Appropriately labels the data set with descriptive variable names.
##	From the data set in step 4, creates a second, independent tidy data set with the average
##	of each variable for each activity and each subject.
## This function computes the inverse of the special "matrix" returned by 

 create_dataset <- function()
 {
	library(dplyr)
	library(tidyr)
	
	##Creates dataset for common files
	dsfeatures <- read.csv("features.txt", header = FALSE, sep = "", stringsAsFactors = FALSE)
	dsactivity <- read.csv("activity_labels.txt", header = FALSE, sep = "", stringsAsFactors = FALSE)
	names(dsactivity) <- c("ACTIVITY_ID", "ACTIVITY")
	
	##Creates dataset for training files
	dstraining <- read.csv("X_train.txt", header = FALSE, sep = "", stringsAsFactors = FALSE)
	names(dstraining) <- dsfeatures[,2]
	dstrainingmeanstd <- dstraining[,grep("[mM]ean\\(\\)|[Ss]td\\(\\)", colnames(dstraining))]

	dstrainactivity <- read.csv("y_train.txt", header = FALSE, sep = "", stringsAsFactors = FALSE)
	names(dstrainactivity) <- "ACTIVITY_ID"
	dstrainactivity$id <- 1:nrow(dstrainactivity)

	dstrainactivityname <- merge( x = dstrainactivity, y = dsactivity , by = "ACTIVITY_ID", all.x = TRUE)
	dstrainactivityname2 <- dstrainactivityname[order(dstrainactivityname$id),c(1,3)]

	dstrainsubject <- read.csv("subject_train.txt", header = FALSE, sep = "", stringsAsFactors = FALSE)
	names(dstrainsubject) <- "SUBJECT_ID"

	dstrainfinal <- cbind(dstrainactivityname2,dstrainsubject,dstrainingmeanstd)
	
	##Creates dataset for test files
    dstest <- read.csv("X_test.txt", header = FALSE, sep = "", stringsAsFactors = FALSE)
	names(dstest) <- dsfeatures[,2]
	dstestmeanstd <- dstest[,grep("[mM]ean\\(\\)|[Ss]td\\(\\)", colnames(dstest))]

	dstestactivity <- read.csv("y_test.txt", header = FALSE, sep = "", stringsAsFactors = FALSE)
	names(dstestactivity) <- "ACTIVITY_ID"
	dstestactivity$id <- 1:nrow(dstestactivity)

	dstestactivityname <- merge( x = dstestactivity, y = dsactivity , by = "ACTIVITY_ID", all.x = TRUE)
	dstestactivityname2 <- dstestactivityname[order(dstestactivityname$id),c(1,3)]

	dstestsubject <- read.csv("subject_test.txt", header = FALSE, sep = "", stringsAsFactors = FALSE)
	names(dstestsubject) <- "SUBJECT_ID"

	dstestfinal <- cbind(dstestactivityname2,dstestsubject,dstestmeanstd)
	
	dsall <- rbind(dstrainfinal,dstestfinal)

	
	##Create Tidy Dataset and Summarize Data
  
    tbl_dsall <- tbl_df(dsall)
	tbl_summarize <- tbl_dsall %>% group_by(ACTIVITY_ID,ACTIVITY,SUBJECT_ID) %>% summarise_each(funs(mean))
	tbl_final <- tbl_summarize %>% gather(FEATURE_CALC_AXIS , VALUE ,4:69 ,na.rm = TRUE)
	tbl_final2 <- separate(tbl_final,FEATURE_CALC_AXIS, c("FEATURE","CALCULATION_TYPE", "AXIS"))
	tbl_finalall <- spread(tbl_final2, CALCULATION_TYPE, VALUE)
	colnames(tbl_finalall)[colnames(tbl_finalall)=="mean"] <- "AVG_MEAN"
	colnames(tbl_finalall)[colnames(tbl_finalall)=="std"] <- "AVG_STD"
	View(tbl_finalall)
	tbl_finalall
	write.table(tbl_finalall,"tidy_final.txt",row.name=FALSE)
  }









