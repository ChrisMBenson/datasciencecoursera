rankhospital <- function(state, outcome, num = "best") {
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
  
  bStateExists <- state %in% outcomes$State
  
  vector.is.empty <- function(x) return(length(columnIndex) == 0 )
  
  if(vector.is.empty(columnIndex) == TRUE | bStateExists == FALSE)
  {
    if(vector.is.empty(columnIndex)){ 
      stop("invalid outcome")
    }   
    
    if(!bStateExists){
      stop("invalid state")
    }     
  }
  else
  {
  
    colname <- as.name(outcome2)
    
    os <- subset(outcomes, State == state, select=c(2, columnIndex))
    
    os <- transform(os, Hospital = Hospital.Name, Rate = as.numeric(os[[2]]),  Rank = rank(as.numeric(os[,2]), na.last = TRUE, ties.method = "min"))
    
    cos <- os[complete.cases(os),]
    
    nos <- cos[order(cos[,5], cos[,1]),]
    
    if (num == "best") num <- as.numeric(1)
    if (num == "worst") num <- as.numeric(max(nos$Rank))
    if (is.numeric(num))
    {
      if (as.numeric(num) > max(nos$Rank))
        {
        NA
        }
      else
        {
          sos <- subset(nos, Rank == num, select = c(1))
          as.character(sos[1,1])
        }
    }
    else
    {
      NA
    }
    
    
  }

  
}
