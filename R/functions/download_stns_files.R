# download_stns_files.R


# Download flow data from cehq.qc.ca -- implemented for Linux and Mac only.


# Project : flow_data_cehq
# Author  : Samuel Perreault
# Email   : sperreault2407 [at] gmail [doc] com
# Depends : R (v3.6.3)
# License : To be determined...


download_stns_files <- function(
    station_numbers, # stations to be imported
    suffix  = "Q",   # Looking for _Q.txt files (or _N.txt files?), can be a vector
    replace = TRUE,  # replace existing files (or skip download)
    wait    = 1L,
    verbose = TRUE,
    path    = file.path("data")
) {

    # Filenames (as on the cehq website)
    filenames <- paste0(station_numbers, "_", suffix, ".txt")

    # Check if some already exist
    existing_files <- intersect(list.files(path), filenames)

    if(replace & length(existing_files) > 0) file.remove(file.path(path, existing_files))
    if(!replace & length(existing_files) > 0){
        filenames <- setdiff(filenames, existing_files)
        if(length(filenames) == 0 & verbose){
            cat("All stations selected have an associated `.txt` file in the data/ folder.\n",
                "Because replace = F, nothing is done and the procedure is aborted.\n")
            return(NULL)
        }
    }

    # Detect OS and begin importation.
    OS <- Sys.info()["sysname"]

    # Check for Linux of Mac (Darwin).
    if(OS == "Linux" | OS == "Darwin"){

        # construct appropriate urls
        urls <- paste0("https://www.cehq.gouv.qc.ca/depot/historique_donnees/fichier/",filenames)

        # write file with urls in it
        write.table(data.frame(urls), file.path(path,"temp_station_urls00.txt"), row.names = F, col.names = F, quote = F)

        # run command in terminal
        shell_command <- paste0("cd data; wget --input-file temp_station_urls00.txt --wait=",wait)
        system(command = shell_command)

        # remove temp file
        file.remove(file.path(path, "temp_station_urls00.txt"))

    } else {
        cat("Implemented only for Linux and Mac OS (so far).\n")
    }

    # Do for Windows
    return(NULL)
}

