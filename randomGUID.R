randomGUID <- function(n, length){
    randomString <- c(1:n)
    for (i in 1:n)
    {
      randomString[i] <- paste(sample(c(0:9, letters, LETTERS), length,
                                      replace = TRUE), collapse = "")
    }
    return(randomString)
}

# Example creates a random GUID
randomGUID(n = 1, length = 20)
