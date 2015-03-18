# Getting_Cleaning_Data
Location of files for the final project in Getting and Cleaning Data


The script works as follows:

- Datasets are downloaded
- Using the features dataset, the names are applied to the x_train and x_test datasets
- A grep command is used to extract column names with 'mean' of 'std' in them
- These are then combined
- The 'Activity Number' is replaced by the activity name
- This is combined with the dataset containing the means and standard deviations
- A loop is than called that subsets according to subject and activity
- For each subject and activity combination, means of all the variables are extracted and outputted into a row vector
- This is then placed into a new dataset using rbind
- Once all combinations are done, this is written to a text file using the write.table() command
