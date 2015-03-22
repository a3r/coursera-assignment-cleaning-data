1. Include all dependent libraries
2. Create a directory if it doesn't exist yet
3. Download the zip-archive with data and unzip it
4. Read all dataset files into R. Variables in the environment are named in camel case.
5. Merge all dataset files into one data frame step by step (not changing their order; sort=FALSE):
* merge test and train subjects (and rename columns)
* merge test and trains activity types (and rename columns)
* match activity types to their names
* separately match corresponding files from "Inertial Signals" folders in test set and train set. Change the names of columns from V1-Vn to the prefix which is the name of the file and number of the column. Then merge them to create Measurements
* Extract features' names from features. Merge features of test set and train set and give them names from the extracted vector
* Rename feature columns so that they meet the standards and search can be performed
* Create final table containing all the information from the downloaded files
6. Choose only the columns that are of interest: mean and std.
7. Transpose feature columns (melt) to create a tidy set
8. Group data by subject ID and activity ID
9. Get the average value for variables and arrange the results by subject IDs
10. Write tidy data to a txt file.