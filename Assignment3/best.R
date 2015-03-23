best <- function(state, outcome) {
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
    
    os <- transform(os, Hospital = Hospital.Name, result = as.numeric(os[[2]]),  rank = rank(as.numeric(os[,2]), na.last = TRUE))

    
    nos <- os[order(os[,5]),]
    
    as.character(nos[1,1])
  }
    ##Ranked <- transform(os, rank = ave(os[,1], as.numeric(os[,2]), FUN=function(x) order(x,decreasing=T)))
    ##x= ave(count,year,FUN=function(x) order(x,decreasing=T)))
    ##Ranked <- rank(as.numeric(os[,columnIndex]), )
  
    ##Ranked
  
  ## Check that state and outcome are valid
  ## Return hospital name in that state with lowest 30-day death
  ## rate

}
