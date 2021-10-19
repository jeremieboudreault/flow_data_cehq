# read_info.R


# Read the information in the header of the file.


read_info <- function(path) {

    # Open file.
    con <- file(path, "r")

    # Read first 20 lines.
    lines <- readLines(con, n = 20L)

    # Deal with bad characters.
    lines <- unlist(lapply(
        X           = lines,
        FUN         = gsubm,
        pattern     = names(map_char),
        replacement = unlist(map_char))
    )

    # Extract relevant information.
    stn  <- substr(lines[3L], 9L, 31L)
    desc <- substr(lines[3L], 32L, nchar(lines[3L]))
    ws   <- substr(lines[4L], 16L, 31L)
    reg  <- substr(lines[4L], 41L, nchar(lines[4L]))
    lat  <- substr(lines[5L], 24L, 35L)
    lon  <- substr(lines[5L], 39L, 50L)

    # Express lat-long in decimal
    lat  <- sum(as.numeric(strsplit(lat, split = c("º |\' |\""))[[1]][1:3])/c(1,60,3600))
    lon  <- sum(as.numeric(strsplit(lon, split = c("º |\' |\""))[[1]][1:3])/c(1,60,3600))

    # Return a list
    l <- list(
        STATION_ID = stn,
        DESC       = desc,
        WS_AREA    = ws,
        REGIME     = reg,
        LATITUDE   = lat,
        LONGITUDE  = lon
    )

    # Trim whitespaces.
    l <- lapply(l, trimws, which = "both")

    # Convert back lon/lat to numeric.
    l$LATITUDE <- as.numeric(l$LATITUDE)
    l$LONGITUDE <- as.numeric(l$LONGITUDE)

    # Close connection.
    close(con)

    # Return the information.
    return(l)

}


# Mapping between weird character and correct UTF-8 values.
map_char <- list(
  `\xc9` = "É",
  `\xcb` = "Ë",
  `\xe8` = "è",
  `\xe9` = "é",
  `\xeA` = "ê",
  `\xeb` = "ë",
  `\xc0` = "À",
  `\xc2` = "Â",
  `\xe0` = "à",
  `\xe2` = "â",
  `\xce` = "Î",
  `\xee` = "î",
  `\xf4` = "ô",
  `\xc7` = "Ç",
  `\xe7` = "ç",
  `\xb3` = "**3",
  `\xb2` = "**2",
  `\xb0`  = "º",
  `\xfc\xbe\x8c\xa3\xa4\xbc` = "'"
)

# Version of gsub() accepting multiple patterns and replacement value.
gsubm <- function(pattern, replacement, x) {
    for (i in seq_along(pattern))
        x <- gsub(pattern[i], replacement[i], x)
    return(x)
}

