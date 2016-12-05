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

profile <- list_profiles()

# Doesn't work
# Here I've pulled the transaction ID's needed from the previous loop
# Now I want to get other transactions from users with a given transaction ID.
# The RGA package doesn't like that the segment does not contain quotations and
# will return an error.

loopData <- function(){
for(i in 1:length(data$transaction.Id)){
  if (i == 1){
    xy <- get_ga(profile.id=0123456789, start.date = "2015-01-01",
    end.date = "2015-03-30",
    dimensions = "ga:transactionId,ga:productName,ga:date,ga:daysToTransaction",
    metrics = "ga:itemRevenue",
# Something is wrong with the line below.
# Should equal to be users::condition::ga:transactionId==0123456
    segment= users::condition::ga:transactionId=data$transaction.id[i])
    } else {
    xz <- get_ga(profile.id=0123456789, start.date = "2015-01-01",
    end.date = "2015-03-30",
    dimensions = "ga:transactionId,ga:productName,ga:date,ga:daysToTransaction",
    metrics = "ga:itemRevenue",
# Something is wrong with the line below.
# Should equal to be users::condition::ga:transactionId==0123456
    segment= users::condition::ga:transactionId=data$transaction.id[i])
    xy <- rbind(xy,xz)
  }
}
return(xy)
}
data <- loopData()
