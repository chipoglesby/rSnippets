profile <- list_profiles()

#Works. In this loop, we successfully walk through the ids in the data frame profile and return the given information.
loopData <- function(){
for (i in 1:length(profile$id)){
  if (i == 1){
    xy <- get_ga(profile.id=profile$id[i], start.date = "2015-01-01",
    end.date = "2015-03-30",
    dimensions = "ga:transactionId,ga:productName,ga:date,ga:daysToTransaction",
    metrics = "ga:itemRevenue",
    filters = "ga:productName=@Something")
  }
  else {
    xz <- get_ga(profile.id=profile$id[i], start.date = "2015-01-01",
    end.date = "2015-03-30",
    dimensions = "ga:transactionId,ga:productName,ga:date,ga:daysToTransaction",
      metrics = "ga:itemRevenue",
      filters = "ga:productName=@Something")
      xy <- rbind(xy, xz)
    }
  }
  return(xy)
}
data <- loopData()
