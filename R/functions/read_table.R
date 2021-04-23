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

    # Convert data to integer format.
    x[, DATE := date_to_int(DATE)]

    # Return the table.
    return(x[])

}

