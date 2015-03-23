rankall <- function(outcome, num = "best") {
  ## Read outcome data
  ## Check that state and outcome are valid
  ## For each state, find the hospital of the given rank
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  ## Read outcome data
  outcomes <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  simpleCap <- function(x) {
    s <- strsplit(x, " ")[[1]]
    paste(toupper(substring(s, 1,1)), substring(s, 2),
          sep="", collapse=" ")
  }
  
  outcome <- simpleCap(outcome)
  
  outcome2 <- paste(c("Hospital.30.Day.Death..Mortality..Rates.from.", gsub(" ", ".", outcome)), collapse="")
  
  options(warn=-1)
  
  columnIndex <- which(colnames(outcomes) %in% outcome2)

  
  vector.is.empty <- function(x) return(length(columnIndex) == 0 )
  

    if(vector.is.empty(columnIndex)){ 
      stop("invalid outcome")
    }   
    

    
    colname <- as.name(outcome2)
    
    os <- subset(outcomes, select=c(2, State, columnIndex))
    
    os <- transform(os, hospital = Hospital.Name, state = State, Rate = as.numeric(os[[3]]))##,  Rank = ave(as.numeric(os[,3]), Hospital.Name, FUN = function(x) rank(x, na.last = TRUE, ties.method = "min")))
    
    os <- subset(os, select=c(hospital, state, Rate))
  
    os <- transform(os,  Rank = ave(Rate, state, FUN = function(x) rank(x, na.last = TRUE, ties.method = "min")))
       
    os
                    
    cos <- os[complete.cases(os[,3]),]
    
    nos <- cos[order(cos$Rank, cos$hospital),]
  
    mos <- transform(nos,  Max = ave(Rank, state, FUN = function(x) max(x)), Min = ave(Rank, state, FUN = function(x) min(x)))
  
    totMax <- max(mos$Max)
  
  
    sos <- subset(nos, Rank == num, select = c(1,2))

    sos
    
  
  
    if (num == "best") num <- as.numeric(1)
    if (is.numeric(num))
    {
      if (as.numeric(num) > totMax)
      {
        NA
      }
      else
      {
            sos <- subset(mos, Rank == num, select = c(1,2))
            sos 
      }
    }
    else if (num == "worst")
    {
      sos <- subset(mos, Rank == Max, select = c(1,2))
      sos
    }

  
}