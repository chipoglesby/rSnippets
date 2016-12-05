library(jsonlite)
library(stringr)
library(bigrquery)

zipcodeQueryResults <- function(
  zipCode = NULL,
  radius = NULL,
  apiKey = NULL,
  columns = NULL,
  project = NULL
){
  if (!is.null(apiKey)) {
    url <- paste("https://www.zipcodeapi.com/rest/", apiKey, "/radius.json/",
    zipCode, "/", radius, "/mile", sep = "")
    zipResults <- as.data.frame(fromJSON(url), col.names = "")
    query_exec(paste(
       "SELECT ", columns, " FROM [table.dataSet] WHERE
       regexp_match(left(postalCode, 2), \"",
      str_c(unique(str_sub(zipResults$zip_code, 1, 2)), collapse = "|"), "\")
      GROUP BY ", columns, sep = ""), project = project)
    }
}

# Example
results <- zipcodeQueryResults(
  zipCode = 90210,
  radius = 200,
  apiKey = "xxx",
  columns = "xxx",
  project = "xxx"
)
