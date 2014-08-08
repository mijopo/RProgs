best <- function(state, outcome) {
  options(warn=-1)
  #outv <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  #outv <- read.csv("j1.csv", colClasses = "character")
  #suppressWarnings(warning("testit"))
  outv <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  colnames(outv)[11] <- "hearta"
  colnames(outv)[17] <- "heartf"
  colnames(outv)[23] <- "pneum"
  colnames(outv)[2] <- "hospn"
  
  if (!(state %in% outv$State)) {
    #message ("invalid state")
    stop('invalid state')
  }
  if (!(outcome %in% c("heart failure","heart attack","pneumonia"))) {
    #message ("invalid outcome")
    stop('invalid outcome')
  }
  #jj <- get("state")
  #print (jj)
  #print (outv)
  #subv <- outv[outv$State=="TX"]
  subv <- subset(outv, State==state)
  subv$heartf <- as.numeric(subv$heartf)
  subv$hearta <- as.numeric(subv$hearta)
  subv$pneum <- as.numeric(subv$pneum)
 
  veccy <- data.frame()
  #print(subv)
  if (outcome == "heart failure") {
    
    veccy <- subv[order(subv$heartf,subv$hospn), ]
  }
  if (outcome=="heart attack") {
   veccy <- subv[order(subv$hearta, subv$hospn), ]
  }
  if (outcome == "pneumonia") {
    veccy <- subv[order(subv$pneum, subv$hospn), ]
  }
  outit <- veccy$hospn[1]
  outit  
  
#Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure
  #Hospital 30-Day Death (Mortality) Rates from Heart Attack
  #"Hospital 30-Day Death (Mortality) Rates from Heart Failure"
  #Hospital 30-Day Death (Mortality) Rates from Pneumonia
  #'b' %in% v
  ## returns TRUE
  
  #match('b',v)
  ## Read outcome data
  ## Check that state and outcome are valid
  ## Return hospital name in that state with lowest 30-day death
  #my.quotes[order(my.quotes$symbol, my.quotes$Close),]
  #p. Sorting III.12
  #R> colnames(X)[2] <- "superduper"
  ## rate
}
