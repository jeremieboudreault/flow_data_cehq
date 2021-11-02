# dms_to_decimal.R

#' @author Jeremie Boudreault.
#'
#' @export
dms_to_decimal <- function(dms) {

    # Split DMS string to c(D, M, S)
    dms_split <- as.numeric(strsplit(dms, split = c("º |\' |\""))[[1L]][1:3])

    # Apply the minus symbol to all terms.
    if (dms_split[1L] < 0L) {
        dms_split[2L] <- dms_split[2L] * -1L
        dms_split[3L] <- dms_split[3L] * -1L
    }

    # Convert to decimals.
    return(sum(dms_split / c(1L, 60L, 3600L)))

}
