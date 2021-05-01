# fetch_stns.R


# Get station numbers (and other infos) within a given hydrographic region.


# Project : flow_data_cehq
# Author  : Samuel Perreault
# Email   : sperreault2407 [at] gmail [doc] com
# Depends : R (v3.6.3)
# License : To be determined...


fetch_stns <- function(
    region_numbers # 0 to 13 (except 0 and 11)
) {

    # Convert to character.
    region_numbers <- as.character(region_numbers)

    # Loop on all regions numbers.
    region_numbers <- lapply(
        X   = region_numbers,
        FUN = function(w) {
            if (nchar(w) == 1L) {
                return(paste0("0", w))
            } else {
                return(w)
            }
        }
    )

    # Url of interest (as of April 21, 2021).
    urls <- paste0(
        "https://www.cehq.gouv.qc.ca/hydrometrie/historique_donnees/",
        "ListeStation.asp?regionhydro=", region_numbers, "&Tri=Non"
    )

    # Extract list of station in the table.
    meta_list <- lapply(urls, function(url) {
        read_html(url)         %>%
        html_node("#tblListe") %>%
        html_table()
    })

    # First row of each tibble contains the column names, we edit them to avoid later problems
    meta_title <- meta_list[[1L]][1L, ]
    meta_title <- substr(meta_title, 1L, sapply(meta_title, nchar) - 1L)
    meta_title <- gsub(" ", "_", meta_title)

    # rbind all tibbles (without first row) and set names
    stns_meta <- do.call(
        what = "rbind",
        args = lapply(meta_list, function(tab) tab[-1L, , drop = FALSE])
    )

    # Update names.
    names(stns_meta) <- meta_title

    # Return final table as a data.table.
    return(data.table::setDT(stns_meta))

}

