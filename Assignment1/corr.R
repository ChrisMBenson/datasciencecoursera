corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  
  
  filenames <- list.files(directory, full.names=TRUE)                 #creates a list of files
  dat <- do.call("rbind", lapply(filenames, read.csv, header = TRUE)) #puts all the data into a data.frame
  
  cc <- complete(directory, dat)
  
  cf <- subset(cc, cc$nobs > threshold)
   
  cf_full <- subset(dat, dat$ID %in% cf$id)
  
  cf_f <- cf_full[complete.cases(cf_full),]
  
  
  cv <- c()
  
  for(i in unique(cf$id))
  {
    
      cs <- subset(cf_f, cf_f$ID == i)
    
      nitrate <- cs$nitrate

      sulfate <- cs$sulfate

      cv <- c(cv, cor(nitrate, sulfate))
     
   }
  
  cv
}
