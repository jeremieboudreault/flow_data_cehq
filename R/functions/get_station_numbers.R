# rvest_stations.R


# Get station numbers within a given hydrographic region

# requires rvest, dplyr

rvest_stations <- function(
    region_numbers # 0 to 13 (except 0 and 11)
) {

    region_numbers <- as.character(region_numbers)
    if(nchar(region_numbers) == 1) region_numbers <- paste0("0",region_numbers)

    # weird to put that in there right?
    library(dplyr)
    library(rvest)

    # url of interest (April 21, 2021)
    urls <- paste0("https://www.cehq.gouv.qc.ca/hydrometrie/historique_donnees/ListeStation.asp?regionhydro=",region_numbers,"&Tri=Non")

    meta_list <- lapply(urls, function(url){
        read_html(url) %>%
            html_node("#tblListe") %>%
            html_table()
    })

    # first row of each tibble contains the column names, we edit them to avoid later problems
    meta_title <- meta_list[[1]][1,]
    meta_title <- substr(meta_title,1,sapply(meta_title,nchar)-1)
    meta_title <- gsub(" ", "_", meta_title)

    # rbind all tibbles (without first row) and set names
    stns_meta <- do.call("rbind", lapply(meta_list, function(tab) tab[-1,,drop=F]))
    names(stns_meta) <- meta_title

    stns_meta
}


