rankhospital <- function(state, outcome, num = "best") {
  outv <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  colnames(outv)[11] <- "hearta"
  colnames(outv)[17] <- "heartf"
  colnames(outv)[23] <- "pneum"
  colnames(outv)[2] <- "hospn"
  if (!(state %in% outv$State)) {
    stop('invalid state')
  }
  if (!(outcome %in% c("heart failure","heart attack","pneumonia"))) {
    stop('invalid outcome')
  }
  subv <- subset(outv, State==state)
  subv$heartf <- as.numeric(subv$heartf, na.rm=TRUE)
  subv$hearta <- as.numeric(subv$hearta, na.rm=TRUE)
  subv$pneum <- as.numeric(subv$pneum, na.rm=TRUE)
  veccy <- data.frame()
  veccyT <- data.frame()
  if (outcome == "heart failure") {
    veccy <- subv[order(subv$heartf,subv$hospn), ]
    veccy <- subset(veccy, select = c(hospn,heartf)) 
  }
  if (outcome=="heart attack") {
    veccy <- subv[order(subv$hearta, subv$hospn), ]
    veccy <- subset(veccy, select = c(hospn,hearta))
    
  }
  if (outcome == "pneumonia") {
    veccy <- subv[order(subv$pneum, subv$hospn), ]
    veccy <- subset(veccy, select = c(hospn,pneum))
  }
  if (num == "best") {
    outit <- veccy$hospn[1]
  } else if (num == "worst") {
   x1 <- complete.cases(veccy)
   x2 <- veccy[x1,]
   jjt <- length(x2$hospn)
   outit <- x2$hospn[jjt]
  } else if (num > length(subv$pneum)) {
    outit <- NA
  } else {
    outit <- veccy$hospn[num]
  }
  outit  
}