filenames <- list.files("specdata", full.names=TRUE)                 #creates a list of files
dat <- do.call("rbind", lapply(filenames, read.csv, header = TRUE)) #puts all the data into a data.frame

dat_subset <- subset(dat, !is.na(dat$sulfate) & !is.na(dat$nitrate), select=Date:ID)  #subsets the rows that match the 'id' argument
