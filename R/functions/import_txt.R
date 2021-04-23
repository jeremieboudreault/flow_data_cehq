# import_txt.R


# Get flow data from cehq.qc.ca



import_txt <- function(
    station_numbers,
    suffix = "Q",
    wait = 1
) {

    # construct appropriate urls
    urls <- paste0("https://www.cehq.gouv.qc.ca/depot/historique_donnees/fichier/",station_numbers,"_",suffix,".txt")

    # write file with urls in it
    write.table(data.frame(urls), "data/temp_station_urls00.txt", row.names = F, col.names = F, quote = F)

    shell_command <- paste0("cd data/; wget --input-file temp_station_urls00.txt --wait=",wait)
    system(command = shell_command)

    # remove temp file
    file.remove("data/temp_station_urls00.txt")

    return(NULL)
}

