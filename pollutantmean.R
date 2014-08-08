pollutantmean <- function(directory, pollutant,id= 1:332) {
  filenames <- list.files(directory, pattern="*.csv", full.names=TRUE)
  fin <- c()
  for (i in id) {
    vec <- read.csv(filenames[i])
    if (pollutant=="sulfate") {
      vals <- vec$sulfate
    }
    if (pollutant=="nitrate") {
      vals <- vec$nitrate
    }
    vals <- vals[!is.na(vals)]
    fin <- append(fin,vals)
  }
  round(mean(fin), digits=3)
}
  
  