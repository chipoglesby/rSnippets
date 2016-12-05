library(httr)
library(RJSONIO)
library(RCurl)
library(rCharts)

full_url <- oauth_callback()
full_url <- gsub("(.*localhost:[0-9]{1,5}/).*", x=full_url, replacement="\\1")
print(full_url)
appName <- "xxx"
clientId <- "xxx"
clientSecret <- "xxx"
scope = "basic"
instagram <- oauth_endpoint(
  authorize = "https://api.instagram.com/oauth/authorize",
  access = "https://api.instagram.com/oauth/access_token")
myapp <- oauth_app(appName, clientId, clientSecret)
igOAuth <- oauth2.0_token(instagram, myapp,scope="basic",
type = "application/x-www-form-urlencoded",cache=FALSE)
tmp <- strsplit(toString(names(igOAuth$credentials)), '"')
token <- tmp[[1]][4]
userInfo <- fromJSON(getURL(paste('https://api.instagram.com/v1/users/self/',
  '?access_token=',token,sep="")),unexpected.escape = "keep")
received_profile <- userInfo$data[[1]]
userId <- userInfo$data[7]
media <- fromJSON(getURL(paste('https://api.instagram.com/v1/users/', userId,
  '/media/recent/?access_token=',token,sep="")))
df = data.frame(no = 1:length(media$data))
for(i in 1:length(media$data))
{
  df$comments[i] <-media$data[[i]]$comments
  df$likes[i] <- media$data[[i]]$likes
  df$date[i] <- toString(as.POSIXct(as.numeric(media$data[[i]]$created_time),
  origin="1970-01-01"))
}
m1 <- mPlot(x = "date", y = c("likes", "comments"), type = "Line", data = df)
