First, get the working directory by running "getwd()" without quotations. If the working directory is not the directory where the data is stored, set the working directory using "setwd()" (without quotations) with the path of the directory where the data is stored.
Second, we get the list of files by securing a path into "directory" and placing the function list.files to display them.
Third, we read the files needed to be used in this problem. To read the files, read.table function enclosed file.path function - which secured a path from the directory to the specific txt file - with the "false" value in header attribute. The step is repeated until all the needed data are read and placed into a data frame.
Fourth, we proceed to the main objectives in solving the problem.
A. To merge the training and the test sets into one dataset:
= First, we bind the rows - using rbind function - according to the variables needed which are Features, Subject, and Activity.
= Then, we assign the names of the variables accordingly. In case of the features, there is a text file which stored the appropriate names for its variables. Thus, read.table function enclosed file.path function - which secured a path from the directory to the specific txt file - with the "false" value in head attribute. After that, names for the variable are assigned to the Features dataset.
= Lastly, we combine the individual dataset into a one dataset by using cbind function.

        tidyData is the name of the dataset.

    B. To extract the measurements on the mean and standard deviation for each measurement:
        = First, we get the names of the data by pattern matching using grep function and stored into a vector named featuresDataSubsetNames.
        = Second, we placed the names of the data from where the extraction will happen into selectedNames.
        = Then, we stored the data of the subset selected from tidyData according to the selectedNames into tidyData.
        = Lastly, we check for the structure of the data frame tidyData.

    C.  To use descriptive activity names to name the activities in the dataset:
        = First, we read the file containing the activity labels by enclosing file.path function - which secured a path from the directory to the specific txt file named "activity_labels.txt" - in the function read.table with the "false" value in header attribute.
        = Then, we factorize the variable Activity from the data frame tidyData.
        = Lastly, we checked if the factorization were successful by displaying 30 values from tidyData.

    D. To appropriately label the data sets with descriptive variable names:
        = We used the gsub function to replace the initial variable name by giving the initial name and the variable name it should replace into, accordingly.
        = This command repeats until all variables have their descriptive names.
        = Lastly, we check if the change is successful by running the command "names(tidyData)" without quotations.

    E. From the dataset in D, to create a second, independent tidy data set with the average of each variable for each activity and each set:
        = First, we install and load the package "plyr".
        = Second, we get the data from Subject to Activity from the tidyData, as well as the mean by using the aggregate function and storing it into tidyData2.
        = Then, we store the data in the tidyData2 in an order manner by using the order function.
        = Lastly, we write a txt file named "tidyData.txt" with the data from the sorted tidyData2.

AND, THAT'S IT.
Hoping that this md file explained how run_analysis.R works and how the commands inside connects with each other.

THANK YOU!
Happy new year!
