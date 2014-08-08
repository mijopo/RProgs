complete <- function(directory, id = 1:332) {
  filenames <- list.files(directory, pattern="*.csv", full.names=TRUE)
  nobs <- c()
  for (i in id) {
    vec <- read.csv(filenames[i])
    cc <- complete.cases(vec)
    nobs <- c (nobs,sum(cc))
  }
  fdf <- data.frame(id,nobs) 
  fdf
}