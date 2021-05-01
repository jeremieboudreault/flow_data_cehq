# dates.R


# Simple dates functions to used within this project.


# Project : flow_data_cehq
# Author  : Jeremie Boudreault
# Email   : jeremieboudreault11 [at] gmail [dot] com
# Depends : R (v3.6.3)
# License : To be determined...


# Transform a date format into the integer one.
date_to_int <- function(x) {
    x <- as.character(x)
    x <- gsub("/", "", x)
    x <- gsub("-", "", x)
    x <- as.integer(x)
    return(x)
}

# Transform a integer data for to the date format.
int_to_date <- function(x) {
    x <- as.character(x)
    yy <- substr(x, 1L, 4L)
    mm <- substr(x, 5L, 6L)
    dd <- substr(x, 7L, 8L)
    return(as.Date(paste0(yy, "/", mm, "/", dd)))
}

# Check for leap year.
is_leap <- function(x) {
    return(as.integer(((x %% 4L) == 0L)))
}
