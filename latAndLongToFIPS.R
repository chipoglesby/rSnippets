# FCC's Census Block Conversions API
# http://www.fcc.gov/developers/census-block-conversions-api
latlong2fips <- function(latitude, longitude) {
 url <- "http://data.fcc.gov/api/block/find?format=json&latitude=%f&longitude=%f"
 url <- sprintf(url, latitude, longitude)
 json <- RCurl::getURL(url)
 json <- RJSONIO::fromJSON(json)
 as.character(json$County["FIPS"])
}

# Larimer County
latlong2fips(latitude = 40.6956, longitude = 105.5943)
