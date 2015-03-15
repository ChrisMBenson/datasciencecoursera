pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)

    filenames <- list.files(directory, full.names=TRUE)                 #creates a list of files
    dat <- do.call("rbind", lapply(filenames, read.csv, header = TRUE)) #puts all the data into a data.frame
    
    
    dat_subset <- dat[which(dat[, "ID"] %in% id),]  #subsets the rows that match the 'id' argument
    mean(dat_subset[, pollutant], na.rm = TRUE)     #identifies the mean for the pollutant 
                                                    #while stripping out the NAs
  
}
