# read_table.R


# Read the table of the file and return a data.table::data.table().


read_table <- function(path) {

    # Read the file.
    x <- data.table::fread(
        input = path,
        skip  = 21L,
        fill  = TRUE
    )

    # Updates names.
    names(x) <- c("STATION", "DATE", "FLOW", "FLAG", "EMPTY")

    # Drop not relevent columns.
    x[, `:=`(STATION = NULL, EMPTY = NULL)]

    # Convert date to the proper format.
    x[, DATE := as.Date(DATE)]

    # Add a field for <DATEI>.
    x[, DATEI := date_to_int(DATE)]

    # Add fields for <YEAR> and <MONTH>.
    x[, YEAR := as.integer(substr(DATEI, 1L, 4L))]
    x[, MONTH := as.integer(substr(DATEI, 5L, 6L))]

    # Reorder columns.
    data.table::setcolorder(x, c("DATE", "DATEI", "YEAR", "MONTH", "FLOW", "FLAG"))

    # Update <FLAG> when missing values.
    x[is.na(FLOW), FLAG := "NA"]

    # Return the table.
    return(x[])

}

