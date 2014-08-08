corr <- function(directory, threshold = 0) {
  filenames <- list.files(directory, pattern="*.csv", full.names=TRUE)
  vec <- complete(directory)
  len <- 1
  cases_complete_threshold<-vec$nobs >threshold
  #print(cases_complete_threshold)
  idl <- vec$id[cases_complete_threshold]
  #idl <- c(1:32)
  myl <- numeric()
  idlist <- c()
  corlist <- c()
  thresholdlist <- c()
  for (i in idl) {
    locv <- read.csv(filenames[i])
    corval<-cor( locv$nitrate,locv$sulfate,use="complete.obs",method="pearson")
    myl <- c(myl,corval)
    if (corval < -0.21050) {
      #print(i)
      #print(corval)
      #print(vec$nobs[i])
    }
    #idlist <- c(idlist,i)
    #corlist <- c(corlist,corval)
    #thresholdlist <- c(thresholdlist,vec$nobs[i])
  }
  myl <- signif(myl,3)
  #trdf <- data.frame(idlist,corlist,thresholdlist)
  #trdf
}

  