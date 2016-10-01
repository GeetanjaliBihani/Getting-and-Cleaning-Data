# Getting-and-Cleaning-Data
Project solution for getting and cleaning data project.

-The script begins with downloading the zipped files through the URL mentioned. 

-The downloaded files are transferred to a local repository.

-The files in the repository are loaded in the R environment. These files are 'X_test','y_test','subject_test','X_train','y_train','subject_train', 'activity_labels' and'features'.

-Since our data tables don't have column names, column names are defined for each table.

-The testing and training files are merged through the function cbind which binds the data tables columnwise and the table total_m is formed.

-The mean and standard deviation measurements in the new merged dataset are subsetted with the help of REGEX command called grepl, which leads to a logical subsetting of the data.

-This subset is used to subset our total_m table, forming a data table with only mean and standard deviation values, indexed by ActivityID. This table is called new_data.

-The new_data table is updated by adding a descriptive column of 'ActivityType', by merging the tables new_data and activity_labels.

-The data is aggregated using the aggregate function, on the basis of the variables 'ActivityType' and 'SubjectID' and mean values of the column entries respectively.

-The data is stored in a table called 'aggregated_data' and is written to the local repository using the write.table command.


