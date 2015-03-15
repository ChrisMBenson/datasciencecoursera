complete <- function(directory, dat, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  
  #filenames <- list.files(directory, full.names=TRUE)                 #creates a list of files
  #dat <- do.call("rbind", lapply(filenames, read.csv, header = TRUE)) #puts all the data into a data.frame

  cc <- data.frame(id = integer(0), nobs = integer(0))
  
  x <- 1
  
  for (i in id)
  {


    nb = sum(complete.cases(dat[dat$ID == i,]))
    
    cc[x,] <- c(i ,nb)
    
    x <- x + 1
    
  }
  
  cc
  
  
#   dat_subset <- subset(dat, !is.na(dat$sulfate) & !is.na(dat$nitrate), select=Date:ID)  #subsets the rows that match the 'id' argument
#   
#   
#   library(plyr)
#   
#   counts <- count(dat_subset,"ID")
#   
#   counts <- rename(counts, c("ID" = "id", "freq" = "nobs"))
#   
# 
#   retcnt = counts[which(counts[, "id"] %in% id),]
#   
#   rownames(retcnt) <- seq(length=nrow(retcnt))
#   
#   retcnt
  
}
