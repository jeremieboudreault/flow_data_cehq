# date_to_int.R


# Transform a date format into the integer one.
date_to_int <- function(x) {
    x <- as.character(x)
    x <- gsub("/", "", x)
    x <- gsub("-", "", x)
    x <- as.integer(x)
    return(x)
}

