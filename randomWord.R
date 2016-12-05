library(jsonlite)

randomWord <- function(word, token){
    data <- fromJSON(paste("http://words.bighugelabs.com/api/2/", token,
                           "/", word, "/json", sep = ""))
    return(data$adjective$syn[sample(1:length(data$adjective$syn),
                                     1, replace=T)])
}

# Example
randomWord(word = "okay", token = "xxx")
"hunky-dory"
